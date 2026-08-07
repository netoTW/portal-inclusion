# RF-063 — Catálogo de eventos de notificación

**Módulo:** comunicaciones
**Prioridad:** crítica
**Depende de:** workflow (eventos), RF-019/061 (patrón de configuración)
**Inferencia:** del bloque Comunicaciones (cap. 7: "avisos automáticos de TODO el
ciclo mediante plantillas administrables"). "Todo el ciclo" exige una matriz
configurable evento→aviso, no avisos cableados por código.

## Descripción
Qué se avisa, a quién y con qué plantilla es CONFIGURACIÓN: la matriz de
notificaciones asocia cada evento del sistema (transición de etapa, asignación,
devolución, resolución firmada, apertura de período, escalamiento, renovación…) con
sus destinatarios (roles/actores del caso) y su plantilla (RF-064). Un aviso nuevo o
un cambio de destinatarios es trabajo de GDI en el panel.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| (usuarios) | reciben según la matriz; no la ven |
| Equipo nacional GDI | editar la matriz completa (versionada, patrón RF-019) |
| (resto) | nada; Secretaría consulta |

## Datos que toca
- Entidades: regla de notificación {evento (catálogo tipado desde contracts),
  destinatarios (rol relativo al caso: estudiante, responsable de etapa, DAE de la
  sede, docentes de las secciones…), plantilla, canal(es), clase: crítica |
  agrupable (RF-070)}. La clase CRÍTICA activa además el ciclo de reintento de
  acuse (RF-066: recordatorio a 5dh, tarea al DAE a +5dh) y la emisión por DOBLE
  CANAL de correo cuando el estudiante tiene ambos (RF-065).
- ¿Datos clínicos? NO; las reglas no pueden seleccionar campos clínicos como
  contenido (el catálogo de campos disponibles es el de RF-021 — misma exclusión).

## Flujo principal
1. Un evento del sistema se emite (workflow/evidencias/documentos…).
2. El motor busca reglas activas para ese evento, resuelve destinatarios CONTRA EL
   CASO (rol relativo → personas concretas) y encola el envío (RF-065).
3. GDI edita la matriz con validación (evento existente, plantilla compatible,
   destinatario resoluble) y publicación versionada.

## Flujos alternos / casos borde
- Evento sin regla: no se avisa (silencio configurado ≠ silencio accidental: el
  panel muestra qué eventos del catálogo no tienen regla).
- Reglas obligatorias NO desactivables: los avisos exigidos por el proceso (acuse de
  recibo RF-006, aviso a docente RF-032, escalamientos con peldaño GDI) están
  marcados de sistema — GDI edita plantilla y copia, no puede apagarlos.
- Destinatario irresoluble en un caso (sin docente asignado): mismo patrón RF-011
  (alerta, nunca silencio).

## Criterios de aceptación
- [ ] CA-1: los avisos seed de todo el ciclo (solicitud→cierre, período de
      evidencias, renovación) salen según la matriz; cambiar un destinatario en el
      panel altera el siguiente envío sin deploy.
- [ ] CA-2: reglas de sistema no se pueden desactivar (validación); eventos sin
      regla visibles en el panel.
- [ ] CA-3 (negativo): la matriz no puede seleccionar contenido clínico (validación
      de plantilla/campos, hereda RF-021); no-GDI recibe 403 en el panel.
- [ ] CA-4 (accesibilidad): panel de matriz operable por teclado; axe 0.

## Propiedades (fuzzing)
- P1: todo aviso emitido proviene de una regla activa cuya versión queda registrada
  en el envío (trazabilidad de POR QUÉ se avisó).

## Fuera de alcance
- Plantillas (RF-064), envío (RF-065), registro (RF-066).

## Dudas abiertas
- Catálogo institucional de avisos del doc extendido (la matriz seed cubre los del
  PDF; reconciliar).
