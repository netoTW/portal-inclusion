# Módulo Workflow — índice (RF-011 a RF-020)

**Motor:** specs/workflow.md (diseño) + specs/sla-engine.md (plazos). Estas specs RF
son el contrato de aceptación sobre ese motor.
**ADVERTENCIA DE INFERENCIA:** el PDF breve solo trae la descripción del bloque
(cap. 7); los NOMBRES y el REPARTO de los RF-011..020 son inferencia nuestra. Al
llegar el documento extendido se reconcilia RF por RF: renombrar/reordenar specs es
esperable, el contenido debería sobrevivir casi entero.

## Los 10 RF y su orden interno de construcción
| RF | Nombre (inferido) | Prioridad | Depende de |
|---|---|---|---|
| [RF-012](rf/RF-012-estados-transiciones.md) | Estados y cambio de estado automático | crítica | — (base) |
| [RF-011](rf/RF-011-asignacion-automatica.md) | Asignación automática de responsables | crítica | RF-012 |
| [RF-015](rf/RF-015-sla-por-etapa.md) | Plazos (SLA) por etapa | crítica | RF-012, sla-engine |
| [RF-018](rf/RF-018-registro-acciones.md) | Registro de acciones del caso | crítica | RF-012, audit |
| [RF-014](rf/RF-014-solicitud-antecedentes.md) | Solicitud automática de antecedentes | crítica | RF-012, validación documental |
| [RF-016](rf/RF-016-alertas-plazos.md) | Alertas de plazos | alta | RF-015 |
| [RF-017](rf/RF-017-escalamiento.md) | Escalamiento por vencimiento | alta | RF-015, RF-016 |
| [RF-013](rf/RF-013-derivaciones.md) | Derivaciones | alta | RF-011, RF-012 |
| [RF-019](rf/RF-019-administracion-procesos.md) | Administración de procesos (panel GDI) | crítica | RF-012, RF-015 |
| [RF-020](rf/RF-020-flujos-sin-desarrollo.md) | Creación de flujos sin desarrollo | crítica | RF-019 + módulo completo |

Orden de construcción = orden de la tabla (no numérico): la base de estados primero,
la maquinaria de plazos encima, el panel al final y RF-020 como prueba de todo.

## Cobertura del texto del bloque (cap. 7 del PDF)
"Asignación (RF-011) y cambio de estado automáticos (RF-012), derivaciones (RF-013),
solicitud automática de antecedentes (RF-014), SLA por etapa (RF-015), alertas
(RF-016), escalamiento (RF-017), registro de acciones (RF-018) y creación de flujos
sin desarrollo (RF-019 el panel, RF-020 la prueba)." — Cada término del bloque tiene
exactamente un RF dueño; nada del texto queda sin cubrir.

Además, del cap. 4 (módulo 2): **"aprobaciones y rechazos"** vive REPARTIDO entre
RF-012 (la transición de decisión en el motor) y specs/validacion-documental.md (la
decisión humana de 1 click: el sistema recomienda, GDI decide, Secretaría firma).
Que la reconciliación con el doc extendido no lo dé por faltante.

## Dudas del módulo elevadas a DUDAS.md
- Alcance real de "derivaciones" (RF-013 — la inferencia más débil del módulo).
- ¿Decisiones parciales por caso (aprobar unas adecuaciones y rechazar otras)? (RF-012).
- Plazo máximo de espera de antecedentes y su consecuencia (RF-014).
- Cadenas de escalamiento seed para etapas 3-5 (RF-017) y agrupación anti-spam de
  avisos (RF-016).
