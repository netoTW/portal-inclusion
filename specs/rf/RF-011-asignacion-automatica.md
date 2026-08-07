# RF-011 — Asignación automática de responsables

**Módulo:** workflow
**Prioridad:** crítica
**Depende de:** RF-012 (motor de estados), authz, audit
**Inferencia:** nombre y alcance inferidos del bloque Workflow (cap. 7: "asignación…
automáticos") y de la etapa 2 del PDF ("asigna responsable"). Reconciliar con doc extendido.

## Descripción
Cuando un caso entra a una etapa, la plataforma asigna responsable sin intervención
humana, según la regla configurada para esa etapa del proceso. El equipo nacional deja
de repartir casos a mano para 25 sedes.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | ver la etapa en que está su caso (no la identidad del responsable — notas de gestión) |
| Sede (DAE) | ver y reasignar asignaciones DENTRO de su sede (scoping territorial) |
| Jefatura de Escuela | ver sus tareas asignadas |
| Docente | ver sus tareas asignadas |
| Secretaría General | ver su cola de resoluciones pendientes |
| Equipo nacional GDI | configurar reglas de asignación por etapa, reasignar cualquier caso |
| Rectoría/Vicerrectorías | nada (solo agregados vía reportes) |

## Datos que toca
- Entidades: asignación (caso, etapa, usuario/rol, regla aplicada, timestamp), reglas de asignación (config del proceso).
- ¿Datos clínicos? NO.

## Flujo principal
1. El caso transita a una etapa con regla de asignación configurada.
2. El motor evalúa la regla: por sede del estudiante (ej. Evidencia → DAE de su sede),
   por rol (Resolución → cola de Secretaría), por reparto de carga, o manual.
3. Asigna, notifica al asignado (vía comunicaciones) y registra en audit.
4. El caso aparece en la bandeja del responsable con su plazo SLA visible.

## Flujos alternos / casos borde
- Sin candidato (sede sin usuario DAE activo): tarea de asignación manual a GDI + alerta;
  el caso NUNCA queda huérfano en silencio.
- Reasignación manual (GDI, o DAE dentro de su sede): motivo opcional, auditada,
  notifica al nuevo y al anterior.
- Usuario desactivado con casos asignados: sus casos pasan a re-asignación (regla o GDI).
- Caso anulado: asignaciones y tareas pendientes se cancelan (workflow.md).

## Criterios de aceptación
- [ ] CA-1: caso entra a etapa Evidencia → queda asignado al equipo DAE de la sede del
      estudiante, notificado y auditado, sin intervención humana.
- [ ] CA-2: sin candidato disponible → tarea manual a GDI + alerta; el caso figura
      "pendiente de asignación", nunca invisible.
- [ ] CA-3 (negativo): DAE de sede A intenta reasignar un caso de sede B → 403 + audit.
- [ ] CA-4 (accesibilidad): bandeja y diálogo de reasignación operables por teclado, axe 0.

## Propiedades (fuzzing)
- P1: todo caso en etapa con responsable requerido tiene exactamente una asignación
      activa o está en "pendiente de asignación" visible para GDI.

## Fuera de alcance
- Contenido de las notificaciones (comunicaciones, RF-063+).
- Cálculo del plazo del asignado (RF-015).

## Dudas abiertas
- ¿Existe reparto por carga real entre varios usuarios DAE de una misma sede, o un pozo común por sede?
