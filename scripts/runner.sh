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
  docker compose up -d >/dev/null 2>&1
  local ok=0
  pytest "packages/$modulo" -q               >> "$LOG" 2>&1 || ok=1
  (cd apps/web && npx vitest run --silent)   >> "$LOG" 2>&1 || ok=1
  ruff check . && mypy "packages/$modulo"    >> "$LOG" 2>&1 || ok=1
  (cd apps/web && npx tsc --noEmit)          >> "$LOG" 2>&1 || ok=1
  npx playwright test "e2e/$modulo" --reporter=line >> "$LOG" 2>&1 || ok=1
  node redteam/run.js --target "$modulo"     >> "$LOG" 2>&1 || ok=1
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
    claude -p "Lee CLAUDE.md y $spec. Implementa el módulo '$modulo' cumpliendo TODOS los criterios de aceptación con sus tests. Si en el intento anterior fallaron gates, lee $LOG (últimas 200 líneas) y corrige. No toques otros módulos." \
      --dangerously-skip-permissions >> "$LOG" 2>&1
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
    sed -i.bak "${num}s/- \[ \]/- [!]/" "$COLA" && rm -f "$COLA.bak"
    git add -A && git commit -m "wip($modulo): límite encontrado, documentado" >/dev/null
    echo "  ⚠ LÍMITE-ENCONTRADO documentado, sigo con la próxima" | tee -a "$LOG"
  fi

  [ "${1:-}" = "--once" ] && exit 0
done
