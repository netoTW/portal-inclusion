# ARRANQUE — El experimento

**Pregunta de investigación:** ¿puede una persona + agentes construir el sistema
completo (70 RF) sin equipo, quedando el equipo humano para mejorar/integrar/operar?

**Criterio de éxito:** ≥90% de los RF funcionales con datos simulados, todos los
gates verdes (tests, e2e, axe, redteam, fuzzing). Los módulos que fallen 3 veces
quedan documentados en LIMITE-ENCONTRADO.md → ese es el mapa de límites (también
es resultado válido del experimento).

## Día 0 — antes de todo
1. Crear /docs-fuente y dejar ahí el PDF de AIEP (Portal_de_Inclusion_y_Cuidados).
2. Primera instrucción al agente arquitecto: "Lee /docs-fuente/*.pdf completo y
   specs/contexto-aiep.md; confirma que el contexto refleja el PDF y reporta
   cualquier discrepancia antes de draftear nada."
3. Cuando llegue el documento EXTENDIDO (37 págs, bajo NDA): va al mismo lugar
   y se re-auditan las specs contra él ANTES de seguir construyendo.

## Día 1-3 — FASE 0 (la única que no se delega)
1. Volcar los 70 RF del documento AIEP a specs usando specs/TEMPLATE-RF.md.
   Método rápido: sesión con agente arquitecto que draftee 10 specs por tanda,
   TÚ las revisas y corriges línea por línea. ~3 tandas/día = 2-3 días.
2. Escribir specs/authz.md, workflow.md, redteam.md, seed.md, audit.md
   (el agente arquitecto las draftea desde arquitectura.md; tú apruebas).
3. Agrupar RF por módulo en specs/modulo-*.md (índice + orden interno).

REGLA: ninguna spec entra a la cola sin tu lectura completa. Acá se gana o
se pierde el experimento.

## Día 3-4 — cimientos supervisados
- Correr scaffold + contracts + authz + redteam CONTIGO mirando (no nocturno):
  son las decisiones estructurales. Runner con --once, revisas cada una.
- Crear tenant M365 Developer Program (manual, 20 min, gratis).

## Día 4 en adelante — modo fábrica
- Día: worktrees en paralelo (2-3 sesiones Claude Code simultáneas en módulos
  independientes), tú integrando y revisando fronteras.
- Noche: ./scripts/runner.sh sobre la cola. En la mañana: leer runner.log,
  revisar [x] por encima, atacar los [!] a mano o re-especificar.

## Métricas del experimento (llevar en BITACORA.md, un par de líneas al día)
- RF completados / 70 (con gates verdes, no "parece que anda")
- Horas humanas invertidas vs estimación original del bloque (5.100 base)
- LIMITE-ENCONTRADO: cuáles, por qué, patrón
- Retrabajos por spec ambigua (mide calidad de Fase 0)

## Recordatorios estratégicos
- Esto es TU IP: repo tuyo, cuenta tuya, previo a contrato/sociedad formalizada.
- Construir genérico donde salga gratis (motor workflow/evidencias sirve para
  CG Control y cualquier institución) — es producto, no proyecto.
- El resultado NO baja el precio de venta: baja tu costo y sube tu margen y tu
  posición. El precio es por valor del sistema operando en 25 sedes.
