# RF-013 — Derivaciones

**Módulo:** workflow
**Prioridad:** alta
**Depende de:** RF-011, RF-012
**Inferencia:** el bloque Workflow (cap. 7) lista "derivaciones" sin definirlas; el
cap. 4 (módulo 2) habla de "derivaciones, aprobaciones y rechazos". Interpretamos
derivación = pasar el caso o una gestión puntual a otro rol/área SIN alterar la etapa
del proceso. Refuerzo de la interpretación: el PDF lista "derivaciones" Y "asignación
de responsables" como cosas SEPARADAS en el módulo 2, lo que apoya que derivación ≠
traspaso de responsabilidad. ALCANCE INFERIDO — duda en ALTA, reconciliar con doc
extendido.

## Descripción
Un responsable deriva un caso (o una gestión del caso) a otro rol para intervención:
GDI deriva a Secretaría General una consulta normativa, la sede deriva a GDI un caso
complejo, GDI deriva a un profesional del equipo una evaluación específica. La
derivación crea una tarea con destinatario, motivo y plazo opcional, sin romper la
responsabilidad de etapa (el caso no queda en tierra de nadie).

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | nada (no ve derivaciones — gestión interna) |
| Sede (DAE) | derivar casos de SU sede a GDI; responder derivaciones recibidas |
| Jefatura de Escuela | responder derivaciones recibidas |
| Docente | nada |
| Secretaría General | responder derivaciones; derivar de vuelta con observaciones |
| Equipo nacional GDI | derivar cualquier caso a cualquier rol; ver todas las derivaciones |
| Rectoría/Vicerrectorías | nada |

## Datos que toca
- Entidades: derivación (caso, **tipo** — extensible, hoy solo `interconsulta` —, de,
  hacia rol/usuario, motivo, plazo opcional, estado abierta/respondida/cancelada,
  respuesta). Si el levantamiento revela semántica de traspaso, se agrega como tipo
  nuevo que invoca la reasignación de RF-011, sin tocar el motor.
- ¿Datos clínicos? NO en la derivación misma; si la gestión exige ver antecedentes,
  el destinatario los ve según SU propio permiso (clinical_gate) — la derivación
  jamás "presta" permisos.

## Flujo principal
1. Responsable abre "Derivar" en el caso: elige destinatario (rol o usuario), motivo
   obligatorio, plazo opcional.
2. La plataforma notifica, crea la tarea en la bandeja del destinatario y registra en audit.
3. El destinatario responde (texto + adjuntos si su permiso lo permite); el derivador
   es notificado y la derivación queda respondida, visible en la historia del caso.

## Flujos alternos / casos borde
- Derivación con plazo vencido → recordatorio y escalamiento según config (RF-016/017).
- Caso transita de etapa o se anula con derivaciones abiertas → se cancelan con
  notificación al destinatario (configurable por proceso: cancelar o mantener).
- Derivación a rol sin usuarios activos → mismo tratamiento que RF-011 (nunca en silencio).

## Criterios de aceptación
- [ ] CA-1: DAE deriva caso propio a GDI con motivo → tarea en bandeja GDI, notificación,
      audit; la respuesta cierra el ciclo y queda en la historia del caso.
- [ ] CA-2: la derivación no cambia etapa ni responsable de etapa del caso.
- [ ] CA-3 (negativo): derivar NO otorga accesos: un destinatario Jefatura no ve
      antecedentes clínicos del caso derivado (403 + audit si lo intenta).
- [ ] CA-3b (negativo): DAE no puede derivar casos de otra sede (403).
- [ ] CA-4 (accesibilidad): formulario de derivación y bandeja operables por teclado, axe 0.

## Propiedades (fuzzing)
- P1: toda derivación abierta referencia un caso no-terminal y un destinatario resoluble.

## Fuera de alcance
- Comunicación con el estudiante (eso es solicitud de antecedentes, RF-014).
- Espacio de comunicación interna general del caso (bloque comunicaciones).

## Dudas abiertas
- **[ALTA en DUDAS.md]** Definición real de "derivación" en el doc extendido: ¿traspaso
  de caso, interconsulta, o ambos? (hoy: interconsulta que no altera la etapa; un
  traspaso sería tipo nuevo sobre RF-011).
- ¿Derivaciones hacia fuera de la plataforma (ej. red de salud externa)?
