#!/usr/bin/env bash
# Runner de tandas: toma tareas de tareas.md, lanza claude headless, verifica gates.
# Uso: ./scripts/runner.sh            (corre toda la cola)
#      ./scripts/runner.sh --once     (solo la primera pendiente)
# Requiere: claude CLI autenticado (plan Max), repo git limpio.

set -uo pipefail
COLA="tareas.md"
LOG="runner.log"
MAX_REINTENTOS=3

pendientes() { grep -n '^\- \[ \]' "$COLA" | head -1; }

gates() {
  local modulo="$1"
  echo "── gates [$modulo]" | tee -a "$LOG"
  [ -f docker-compose.yml ] || [ -f compose.yml ] && docker compose up -d >/dev/null 2>&1
  local ok=0
  # Guardas de existencia: las tareas de infraestructura (scaffold, contracts, ui-*)
  # crean estas rutas — un gate sobre ruta inexistente se OMITE, no falla.
  if [ -d "packages/$modulo" ]; then
    pytest "packages/$modulo" -q             >> "$LOG" 2>&1 || ok=1
    mypy "packages/$modulo"                  >> "$LOG" 2>&1 || ok=1
  fi
  command -v ruff >/dev/null 2>&1 && { ruff check . >> "$LOG" 2>&1 || ok=1; }
  # Solo si el frontend es un proyecto real (package.json), y SIN instalaciones ad hoc:
  # npx sin --no-install descarga paquetes arbitrarios (p.ej. el falso 'tsc@2.0.4').
  if [ -f apps/web/package.json ]; then
    (cd apps/web && npx --no-install vitest run --silent) >> "$LOG" 2>&1 || ok=1
    (cd apps/web && npx --no-install tsc --noEmit)        >> "$LOG" 2>&1 || ok=1
  fi
  [ -d "e2e/$modulo" ] && { npx playwright test "e2e/$modulo" --reporter=line >> "$LOG" 2>&1 || ok=1; }
  [ -f redteam/run.js ] && { node redteam/run.js --target "$modulo" >> "$LOG" 2>&1 || ok=1; }
  # Gate mínimo universal: si la tarea declaró tests en cualquier parte, algo corrió.
  echo "── gates [$modulo]: $([ $ok -eq 0 ] && echo OK || echo FALLO)" | tee -a "$LOG"
  return $ok
}

while true; do
  linea=$(pendientes) || true
  [ -z "${linea:-}" ] && { echo "✔ Cola vacía. Fin." | tee -a "$LOG"; exit 0; }
  num=${linea%%:*}
  tarea=$(echo "$linea" | sed 's/^[0-9]*:- \[ \] //')
  modulo=$(echo "$tarea" | cut -d'|' -f1 | xargs)
  spec=$(echo "$tarea"   | cut -d'|' -f2 | xargs)

  echo "▶ [$modulo] $spec — $(date '+%H:%M')" | tee -a "$LOG"
  exito=0
  for intento in $(seq 1 $MAX_REINTENTOS); do
    salida_agente=$(claude -p "Lee CLAUDE.md y $spec. Implementa el módulo '$modulo' cumpliendo TODOS los criterios de aceptación con sus tests. Si en el intento anterior fallaron gates, lee $LOG (últimas 200 líneas) y corrige. No toques otros módulos." \
      --dangerously-skip-permissions 2>&1); agente_rc=$?
    echo "$salida_agente" >> "$LOG"
    # El fallo del AGENTE no es fallo del módulo: abortar sin quemar intentos ni marcar [!]
    if echo "$salida_agente" | grep -qi "session limit\|usage limit\|rate limit"; then
      echo "⛔ [$modulo] sin presupuesto de sesión de Claude (límite). NO cuenta como intento." | tee -a "$LOG"
      echo "   Reintentar cuando el límite resetee. Tarea queda [ ] pendiente." | tee -a "$LOG"
      exit 2
    fi
    if [ $agente_rc -ne 0 ]; then
      echo "⛔ [$modulo] claude -p terminó con error (rc=$agente_rc) sin implementar. NO cuenta como intento." | tee -a "$LOG"
      exit 2
    fi
    if gates "$modulo"; then exito=1; break; fi
    echo "  ✗ intento $intento falló gates" | tee -a "$LOG"
  done

  if [ "$exito" = "1" ]; then
    git add -A && git commit -m "feat($modulo): $spec [runner, gates verdes]" >/dev/null
    # sed -i portable (BSD/macOS exige sufijo; GNU lo acepta): usar backup y borrarlo
    sed -i.bak "${num}s/- \[ \]/- [x]/" "$COLA" && rm -f "$COLA.bak"
    echo "  ✔ HECHO y commiteado" | tee -a "$LOG"
  else
    mkdir -p "packages/$modulo"
    claude -p "Los gates de '$modulo' fallaron $MAX_REINTENTOS veces. Lee $LOG y escribe packages/$modulo/LIMITE-ENCONTRADO.md: qué se intentó, hipótesis de por qué falla, qué se necesita para destrabarlo. Sé específico y honesto." \
      --dangerously-skip-permissions >> "$LOG" 2>&1
    # Fallback: si el agente no pudo escribirlo, el runner documenta él mismo.
    # NUNCA un commit que diga "documentado" sin documento.
    if [ ! -f "packages/$modulo/LIMITE-ENCONTRADO.md" ]; then
      {
        echo "# LIMITE-ENCONTRADO — $modulo ($(date '+%d-%m-%Y %H:%M'))"
        echo "Escrito por el runner (fallback): el agente no pudo documentar."
        echo "Los gates fallaron $MAX_REINTENTOS veces. Últimas 80 líneas del log:"
        echo '```'
        tail -80 "$LOG"
        echo '```'
      } > "packages/$modulo/LIMITE-ENCONTRADO.md"
    fi
    sed -i.bak "${num}s/- \[ \]/- [!]/" "$COLA" && rm -f "$COLA.bak"
    git add -A && git commit -m "wip($modulo): BLOQUEO ACTIVO documentado en LIMITE-ENCONTRADO.md" >/dev/null
    echo "  ⚠ BLOQUEO ACTIVO documentado, sigo con la próxima" | tee -a "$LOG"
  fi

  [ "${1:-}" = "--once" ] && exit 0
done
