# ARRANQUE — Protocolo de construcción

**Objetivo:** construir el sistema REAL y funcional del Portal de Inclusión y Cuidados —
el que se presentará en la licitación y debe poder evolucionar a producción. Meta:
los 70 RF operando de punta a punta con datos simulados, todos los gates verdes
(tests, e2e, axe, redteam, fuzzing), demo-able ante el cliente.

**Regla de calidad:** la velocidad no relaja la calidad. Lo que se construye ahora es
la base que se reconciliará con el documento extendido y evolucionará a producción.
NADA se escribe como desechable.

**Bloqueos:** un módulo que falla 3 veces sus gates se documenta en
LIMITE-ENCONTRADO.md, pero eso NO es un resultado: es un **BLOQUEO ACTIVO**. Cada
bloqueo exige plan de destrabe (re-especificar, cambiar enfoque técnico, o escalar la
decisión a Pablo) y se registra en BITACORA.md hasta quedar resuelto.

## Día 0 — antes de todo
1. Crear /docs-fuente y dejar ahí el PDF de AIEP (Portal_de_Inclusion_y_Cuidados). ✔
2. Primera instrucción al agente arquitecto: "Lee /docs-fuente/*.pdf completo y
   specs/contexto-aiep.md; confirma que el contexto refleja el PDF y reporta
   cualquier discrepancia antes de draftear nada." ✔ (auditoría 07-08-2026)
3. Cuando llegue el documento EXTENDIDO (37 págs, bajo NDA): va al mismo lugar
   y se re-auditan las specs (y los ADRs) contra él ANTES de seguir construyendo.

## Día 1-3 — FASE 0 (la única que no se delega)
1. Volcar los 70 RF del documento AIEP a specs usando specs/TEMPLATE-RF.md.
   Método: tandas de ~10 specs por módulo en el orden de dependencias de tareas.md
   (plan de tandas 0-9 aprobado el 07-08-2026); Pablo revisa y corrige cada tanda
   línea por línea antes de la siguiente. ~3 tandas/día = 3-4 días.
2. Escribir specs/authz.md, workflow.md, redteam.md, seed.md, audit.md
   (el agente arquitecto las draftea desde arquitectura.md; Pablo aprueba). [Tanda 0]
3. Agrupar RF por módulo en specs/modulo-*.md (índice + orden interno).

REGLA: ninguna spec entra a la cola sin lectura completa de Pablo. Acá se gana o
se pierde el proyecto.

## Día 3-4 — cimientos supervisados
- Correr scaffold + contracts + authz + redteam CON Pablo mirando (no nocturno):
  son las decisiones estructurales. Runner con --once, revisión una a una.
- Crear tenant M365 Developer Program (manual, 20 min, gratis).

## Día 4 en adelante — modo fábrica
- Día: worktrees en paralelo (2-3 sesiones Claude Code simultáneas en módulos
  independientes), Pablo integrando y revisando fronteras.
- Noche: ./scripts/runner.sh sobre la cola. En la mañana: leer runner.log,
  revisar [x] por encima, y para cada [!]: definir plan de destrabe y registrarlo
  como bloqueo activo en BITACORA.md. Ningún [!] queda sin plan.

## Control de obra (BITACORA.md, un par de líneas al día)
- Avance: RF completados / 70 (con gates verdes, no "parece que anda")
- Bloqueos abiertos, cada uno con su plan de destrabe y responsable
- Decisiones pendientes de Pablo (con qué se necesita para decidir)
- Horas humanas reales por módulo (dato de gestión: alimenta la propuesta comercial)
- Retrabajos por spec ambigua (mide calidad de Fase 0 y dispara corrección de la spec)

## Recordatorios estratégicos
- Esto es IP de Pablo: repo propio, cuenta propia, previo a contrato/sociedad formalizada.
- Construir genérico donde salga gratis (motor workflow/evidencias sirve para
  CG Control y cualquier institución) — es producto, no proyecto.
- El costo de construcción no baja el precio de venta: baja el costo, sube el margen
  y la posición. El precio es por valor del sistema operando en 25 sedes.
