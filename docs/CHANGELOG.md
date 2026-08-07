# CHANGELOG

Registro de cambios por fase/módulo. Cada tarea HECHA agrega su entrada aquí
(definición de HECHO, CLAUDE.md). Formato: fecha DD-MM-YYYY, módulo, qué cambió.

## Fase 0 — especificación

- **07-08-2026 · kit** — Auditoría cruzada del kit contra el PDF del cliente
  (24.07.2026): restituido el módulo Ficha única, creado el módulo Reportes/Dashboards,
  agregados adapters Power BI y Progresión, calibraciones de seed (tasas de aprobación,
  universo 21 sedes), diagramas del PDF volcados como texto, cronograma cap. 10.
- **07-08-2026 · docs** — Creados `SUPUESTOS.md` (S-01..S-17) y `DUDAS.md` (preguntas
  de levantamiento priorizadas). Estándar de documentación: README raíz, `/docs/`,
  ADRs 001 (arquitectura híbrida), 002 (k-anonimato), 003 (marco normativo ampliado).
- **07-08-2026 · specs (Tanda 0)** — Specs de infraestructura aprobadas: `authz.md`
  (ABAC, 4 invariantes duras, clinical_gate, DAE como celda editable [S-20], datos
  clínicos de terceros en Cuidados), `workflow.md` (procesos como datos, versionado,
  dos cierres + anulación [S-19], regla de oro sin bypass), `redteam.md` (definición
  operativa de exfiltración, 7 familias de vectores, canario), `audit.md` (append-only
  con cadena de hashes, registro transaccional), `seed.md` (seed limpio + generador
  de 881 sucios calibrados). Supuestos nuevos S-18..S-20.
- **07-08-2026 · specs (Tanda 1)** — Módulo Workflow especificado: RF-011 a RF-020 en
  `specs/rf/` + índice `specs/modulo-workflow.md` (orden interno de construcción y
  mapa de cobertura del bloque). Nombres de RF inferidos del bloque del cap. 7,
  marcados para reconciliación con el doc extendido. Decisiones de revisión:
  derivación = interconsulta con campo `tipo` extensible (duda ALTA), decisión única
  por caso (respaldo cap. 1), distinción de tres niveles en la guarda de evidencia
  (caso/definición/proceso seed). UI en paralelo: specs/design-system.md y tareas
  ui-shell/ui-admin en la cola.
- **07-08-2026 · specs (Tanda 2)** — Módulo Solicitudes especificado: RF-001 a RF-010
  + índice `specs/modulo-solicitudes.md`. Decisiones de revisión: RF-010 multi-caso
  con código propio (specs ancladas a capacidad, no a código); clasificación
  `sensible` obligatoria en el constructor de formularios con vector red-team
  post-seed; vigencia documental a fecha de envío (regla justa al estudiante);
  re-aceptación de consentimiento sin cortar casos en curso; retiro de consentimiento
  NO diseñado por decisión; reuso documental configurable entre casos; herramienta de
  fusión de catálogos compartida con migración. Duda nueva MEDIA: consentimiento de
  menores de 18.
