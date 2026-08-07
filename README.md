# Portal de Inclusión y Cuidados

Plataforma de gestión de casos para educación superior (AIEP): administra el ciclo
completo de los apoyos a estudiantes con discapacidad, neurodivergencias y afecciones
psiquiátricas, y de las medidas de cuidados — desde la solicitud del estudiante hasta
que la sede acredita con evidencia validada que el apoyo se implementó.

**El problema que resuelve:** hoy el ciclo funciona con correos, planillas y seguimiento
manual de un equipo nacional para 25 sedes (541 solicitudes acumuladas, 153 casos de
discapacidad severa en planilla paralela). La plataforma asume ese trabajo repetitivo:
avisar, recordar, escalar, generar documentos, controlar vigencias, recolectar evidencia
y producir indicadores. Regla de oro del cliente: **sin evidencia válida cargada, el
caso no se cierra.**

## Estado actual

**Fase 0 — especificación.** El kit de arranque está auditado contra el documento fuente
del cliente (24.07.2026) y corregido. Próximo paso: draftear las specs de los 70
requerimientos funcionales (RF-001 a RF-070) en tandas revisadas una a una. No hay
código todavía; este repositorio es, por ahora, el contrato de construcción.

## Mapa del repositorio

| Ruta | Qué es |
|---|---|
| [`specs/`](specs/) | **Contrato de construcción** (fuente de verdad para los agentes que implementan) |
| [`specs/contexto-aiep.md`](specs/contexto-aiep.md) | Datos reales de la operación: volúmenes, perfiles, etapas, SLA, métricas de éxito, diagramas del PDF como texto |
| [`specs/arquitectura.md`](specs/arquitectura.md) | Monorepo, separación de datos clínicos, policy engine, motor de workflow, gates de CI, adapters |
| [`specs/authz.md`](specs/authz.md) | Policy engine ABAC: las 4 reglas de acceso "por diseño", clinical_gate, matriz en datos |
| [`specs/workflow.md`](specs/workflow.md) | Motor de workflow por metadatos: procesos como datos, versionado, renovaciones, prueba RF-020 |
| [`specs/redteam.md`](specs/redteam.md) | Gate adversarial: set de vectores congelado + agente generador; 0 exfiltraciones |
| [`specs/audit.md`](specs/audit.md) | Bitácora inmutable append-only con cadena de hashes; quién/qué/cuándo/desde dónde |
| [`specs/seed.md`](specs/seed.md) | Datos sintéticos chilenos + generador de 881 registros sucios calibrados para la migración |
| [`specs/sla-engine.md`](specs/sla-engine.md) | Motor de plazos: reloj hábil chileno, pausas, avisos, escalamiento, períodos |
| [`specs/validacion-documental.md`](specs/validacion-documental.md) | Validación en dos niveles: admisibilidad automática + decisión humana |
| [`specs/evidencia-eventos.md`](specs/evidencia-eventos.md) | Circuito de evidencia por eventos (ADR-004): evaluaciones, confirmación 1-click del docente, reprogramaciones |
| [`specs/ficha-estudiante.md`](specs/ficha-estudiante.md) | Ficha única del estudiante (vista integradora, módulo 6 del cliente) |
| [`specs/reportes-dashboards.md`](specs/reportes-dashboards.md) | Dashboards e indicadores (experiencia del perfil Rectoría, reportes de cumplimiento) |
| [`specs/design-system.md`](specs/design-system.md) | Design system: tokens AA, componentes base, patrones de accesibilidad, login dev "actuar como" |
| [`specs/rf020-proceso-severa.md`](specs/rf020-proceso-severa.md) | Guion de la prueba de parametrización: proceso NEE/Severa configurado solo por UI + manual |
| `specs/mock-*.md`, [`sso-m365`](specs/sso-m365.md), [`powerbi-export`](specs/powerbi-export.md) | Integraciones: mocks de [Banner](specs/mock-banner.md), [firma](specs/mock-firma.md) y [progresión](specs/mock-progresion.md); SSO real M365; dataset Power BI |
| [`specs/fuzzing-workflow.md`](specs/fuzzing-workflow.md), [`specs/migracion.md`](specs/migracion.md), [`specs/documentacion.md`](specs/documentacion.md) | Cierre: suite de propiedades, pipeline de migración (881 registros), 7 manuales por perfil |
| [`specs/TEMPLATE-RF.md`](specs/TEMPLATE-RF.md) | Template de spec por requerimiento funcional (Fase 0) |
| [`specs/rf/`](specs/rf/) | Una spec por requerimiento funcional (RF-001…RF-070, en tandas) |
| `specs/modulo-*.md` | Índices por módulo: orden interno de construcción y mapa de cobertura del bloque ([workflow](specs/modulo-workflow.md), [solicitudes](specs/modulo-solicitudes.md), [evidencias](specs/modulo-evidencias.md), [documentos](specs/modulo-documentos.md), [adecuaciones](specs/modulo-adecuaciones.md), [cuidados](specs/modulo-cuidados.md), [comunicaciones](specs/modulo-comunicaciones.md)) |
| [`docs/`](docs/) | Documentación viva: decisiones, arquitectura explicada, manuales |
| [`docs/decisiones/`](docs/decisiones/) | ADRs (Architecture Decision Records), uno por decisión importante |
| [`docs/CHANGELOG.md`](docs/CHANGELOG.md) | Registro de cambios por módulo/fase |
| [`SUPUESTOS.md`](SUPUESTOS.md) | Todo lo asumido sin confirmación del cliente, numerado [S-xx], con su pregunta de levantamiento |
| [`DUDAS.md`](DUDAS.md) | Preguntas abiertas priorizadas + registro de ambigüedades que encuentran los agentes |
| [`BITACORA.md`](BITACORA.md) | Control de obra: avance vs 70 RF, bloqueos activos con plan de destrabe, horas por módulo |
| [`tareas.md`](tareas.md) | Cola de construcción ordenada por dependencias |
| [`CLAUDE.md`](CLAUDE.md) | Convenciones maestras para todos los agentes |
| [`README-ARRANQUE.md`](README-ARRANQUE.md) | Protocolo de construcción (fases, runner, control de obra) |
| [`docs-fuente/`](docs-fuente/) | Documento fuente del cliente (PDF, resumen de requerimientos 24.07.2026) |
| [`scripts/`](scripts/) | `runner.sh`: ejecución autónoma de la cola de tareas con gates |

## Decisiones registradas

- [ADR-001 — Arquitectura híbrida: núcleo a medida + ecosistema M365](docs/decisiones/ADR-001-arquitectura-hibrida.md)
- [ADR-002 — K-anonimato en dashboards agregados](docs/decisiones/ADR-002-k-anonimato-dashboards.md)
- [ADR-003 — Marco normativo ampliado por el proveedor](docs/decisiones/ADR-003-marco-normativo-ampliado.md)
- [ADR-004 — Evidencia por eventos, no solo documental](docs/decisiones/ADR-004-evidencia-por-eventos.md)

## Cómo levantar el entorno

Aún no existe entorno ejecutable (Fase 0, solo especificación). Cuando exista, todo el
stack correrá con `docker compose up` sin dependencias de cloud en dev — esta sección se
actualizará en el mismo commit que lo haga posible.

## Regla de mantención de este README

Este README es la portada del repo y parte de la **definición de HECHO** de cada fase:
si el mapa del repositorio cambia (archivo nuevo, movido o eliminado), el README cambia
en el mismo commit.
