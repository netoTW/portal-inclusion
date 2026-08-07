# Módulo Adecuaciones — índice (RF-029 a RF-036)

**El módulo donde el apoyo aprobado se vuelve realidad operativa:** registros
estructurados desde la resolución, vigencias, aplicación con constancia, el panel del
docente, renovación (~mitad de la carga real) y el enforcement de "solo lo aprobado".
Motores de apoyo: workflow (recurrencia), evidencia-eventos (ADR-004), comunicaciones.
**RESUELVE EL CRUCE [S-22] (lado vigencias):** la vigencia y renovación del apoyo son
del ESTUDIANTE y no dependen de la deuda de evidencia de la sede — invariante P2 de
RF-030, con tests espejo en RF-030 CA-2, RF-034 CA-3 y RF-054 CA-3b.
**ADVERTENCIA DE INFERENCIA:** nombres y reparto inferidos (cap. 7 + módulo 4 del
cap. 4 + cap. 8 perfil Docente). Specs ancladas a capacidad, no a código.

## Los 8 RF y su orden interno de construcción
| RF | Nombre (inferido) | Prioridad | Depende de |
|---|---|---|---|
| [RF-029](rf/RF-029-registro-adecuaciones.md) | Registro asociado a la resolución | crítica | RF-022, RF-003 |
| [RF-030](rf/RF-030-vigencia-semestral.md) | Control de vigencia semestral [S-22] | crítica | RF-029 |
| [RF-031](rf/RF-031-responsables-aplicacion.md) | Responsables y tareas de aplicación | crítica | RF-029, RF-011 |
| [RF-032](rf/RF-032-aviso-docentes.md) | Aviso automático a docentes y áreas | crítica | RF-031 |
| [RF-033](rf/RF-033-panel-docente-adecuaciones.md) | Panel del docente | crítica | RF-030/032 |
| [RF-034](rf/RF-034-renovacion-semestral.md) | Renovación semestral [S-05][S-22] | crítica | RF-030, workflow |
| [RF-035](rf/RF-035-historial-adecuaciones.md) | Historial completo | alta | RF-029/034 |
| [RF-036](rf/RF-036-impedir-no-aprobadas.md) | Impedir adecuaciones no aprobadas | crítica | todo el módulo |

## Cobertura del texto del PDF
| Término (cap. 7 / cap. 4 módulo 4 / cap. 8) | RF dueño |
|---|---|
| "Asociación a resolución" / "registro asociado a la resolución" | RF-029 |
| "Control de vigencia" / "vigencia semestral" | RF-030 |
| "Responsables" / etapa 5 (tareas fechadas, acuse) | RF-031 |
| "Aviso automático a docentes" / "y áreas" | RF-032 |
| "adecuaciones vigentes y recomendaciones de aplicación" (perfil Docente) | RF-033 |
| "Renovación" / "renovación simplificada/automática" (fig. 2) | RF-034 |
| "Historial" / "historial completo" | RF-035 |
| "Impedir adecuaciones distintas a las aprobadas" | RF-036 |

Metas del cap. 11 que este módulo materializa: confirmación de recepción de sede
100% (RF-031), constancia de aviso al docente 100% (RF-032 — como INVARIANTE P1);
la fecha de aplicación 100% quedó en el circuito de eventos (ADR-004).

## Dudas del módulo elevadas a DUDAS.md
- ¿Quién confirma la renovación y exige resolución nueva o anexo? (RF-034, [S-05])
- Vigencia de apoyo otorgado a mitad de semestre (RF-030)
- Mapa tipo-de-adecuación → responsable de implementación (RF-031)
- ¿"Medida provisoria" de urgencia pre-resolución? Hoy NO existe (RF-036)
- Co-docentes/ayudantes en el panel (RF-033) · plazo de acuse docente (RF-032)
