# Módulo Solicitudes — índice (RF-001 a RF-010)

**Motor de apoyo:** specs/validacion-documental.md (checklists y admisibilidad) +
formularios del motor de workflow. Estas specs son el contrato de aceptación de la
puerta de entrada del ciclo.
**ADVERTENCIA DE INFERENCIA:** nombres y reparto de RF-001..010 inferidos del bloque
del cap. 7 y el módulo 1 del cap. 4. Reconciliar con doc extendido al llegar.
Las specs están ANCLADAS A CAPACIDAD, no a código: si el extendido usa un código para
otra cosa (ej. RF-010), se renumera la etiqueta y la spec sobrevive.

## Los 10 RF y su orden interno de construcción
| RF | Nombre (inferido) | Prioridad | Depende de |
|---|---|---|---|
| [RF-003](rf/RF-003-catalogos-controlados.md) | Catálogos controlados | crítica | contracts/BannerAdapter |
| [RF-004](rf/RF-004-identificacion-automatica.md) | Identificación automática del estudiante | crítica | BannerAdapter, RF-003 |
| [RF-001](rf/RF-001-tipos-de-solicitud.md) | Tipos de solicitud configurables | crítica | RF-019, validación documental |
| [RF-002](rf/RF-002-formularios-dinamicos.md) | Formularios dinámicos | crítica | RF-001, design-system |
| [RF-005](rf/RF-005-validacion-documental-ingreso.md) | Validación documental en el ingreso | crítica | RF-001, RF-002 |
| [RF-008](rf/RF-008-consentimiento-datos.md) | Consentimiento de datos | crítica | RF-002, audit |
| [RF-006](rf/RF-006-numero-caso-acuse.md) | Número único de caso y acuse | crítica | RF-005, RF-012 |
| [RF-007](rf/RF-007-borradores.md) | Guardado en borrador | alta | RF-002, RF-005 |
| [RF-009](rf/RF-009-historial-cambios.md) | Historial de cambios | alta | RF-002, audit |
| [RF-010](rf/RF-010-solicitudes-complementarias.md) | Solicitudes complementarias (multi-caso) | alta | RF-006, ficha |

Orden = cimiento de datos (catálogos, identidad) → configuración (tipos, formularios)
→ el acto de solicitar (validación, consentimiento, envío) → capacidades encima
(borradores, historial, multi-caso).

## Cobertura del texto del bloque (cap. 7) y módulo 1 (cap. 4)
| Término del PDF | RF dueño |
|---|---|
| "Tipos de solicitud configurables" | RF-001 |
| "Formularios dinámicos" | RF-002 |
| "con catálogos controlados" | RF-003 |
| "Identificación automática del estudiante" (cap. 4) | RF-004 |
| "Validación documental automática" / "carga y validación de documentos obligatorios" | RF-005 |
| "Número de caso" / "número único de caso" | RF-006 |
| "Borradores" / "guardado en borrador" | RF-007 |
| "Consentimiento de datos" | RF-008 |
| "Historial de cambios" | RF-009 |
| Multi-caso (22,7% complementarias, cap. 1) | RF-010 |
| "Nuevos formularios sin desarrollo" (cap. 4) | RF-001 + RF-002, con la maquinaria de RF-019/RF-020 |
| "Ingreso por el estudiante" (cap. 4) | RF-002 + RF-005 (etapa 1 del flujo) |
| "Consultar estado" (cap. 8, perfil Estudiante) | RF-018 (historia) + ficha-estudiante.md |

## Dudas del módulo elevadas a DUDAS.md
- ¿Pueden solicitar estudiantes sin matrícula vigente (postulantes, congelados)? (RF-004)
- Retiro del consentimiento con casos activos; menores de edad (RF-008)
- Vigencia documental: ¿se evalúa a fecha de envío o de evaluación? (RF-005)
- Regla de reuso documental entre casos y taxonomía real de condiciones (RF-010, RF-003)
- Expiración de borradores (RF-007) — menor
