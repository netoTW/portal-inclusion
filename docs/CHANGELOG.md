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
