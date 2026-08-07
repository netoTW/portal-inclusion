# RF-068 — Espacio de comunicación del caso

**Módulo:** comunicaciones
**Prioridad:** crítica
**Depende de:** RF-065/066, authz (participantes del caso)
**Inferencia:** del pedido EXPLÍCITO de las sedes (cap. 2): "las sedes solicitaron…
un espacio de comunicación dentro del sistema, en lugar de la gestión por correo".
La sobrecarga de correos es LA barrera nº1 — este RF la ataca de frente.

## Descripción
Cada caso tiene su hilo de comunicación: los participantes autorizados conversan
SOBRE el caso EN el caso (consultas de la sede a GDI, respuestas al estudiante,
coordinación operativa), con todo el contexto a la vista y registro automático.
El correo de gestión ("¿en qué va el caso de…?") muere: la conversación vive donde
está el expediente.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | conversar en el hilo CON él (mensajes dirigidos al estudiante); no ve el hilo interno |
| Sede (DAE) | hilo interno de sus casos + hilo con el estudiante |
| Jefatura de Escuela | participar donde se le convoque (derivación/mención) |
| Docente | NO participa (sus interacciones son atestaciones y avisos — mantenerlo simple y sin riesgo de fuga en chat) |
| Secretaría General | hilo interno donde resuelve |
| Equipo nacional GDI | todos los hilos |
| Rectoría/Vicerrectorías | nada |

## Datos que toca
- Entidades: hilo del caso {interno | con-estudiante}, mensaje {autor, texto,
  adjuntos (régimen documental del caso), timestamp, menciones}.
- ¿Datos clínicos? El hilo INTERNO puede rozar contexto sensible → vive bajo el
  régimen del caso: en cuidados, hilo interno solo GDI/Secretaría [S-23]; en
  inclusión, DAE participa sin contenido clínico (la spec de UI advierte activamente:
  "no pegues diagnósticos en el chat" + patrón de detección básica — ver dudas).
  El hilo con el estudiante es visible para él SIEMPRE (nada de "notas ocultas" ahí;
  lo oculto va en RF-069).

## Flujo principal
1. En el caso, pestaña "Comunicación": hilo interno + hilo con el estudiante,
   claramente separados (bordes visuales y de permisos).
2. Mensaje nuevo → notificación a los participantes (RF-063/065, agrupable).
3. Mención a un rol (@jefatura) lo incorpora con su recorte de siempre.
4. Todo mensaje inmutable y en el expediente (RF-027) — la conversación ES registro.

## Flujos alternos / casos borde
- Mensaje enviado por error: no se edita ni borra; rectificación como mensaje nuevo
  (patrón audit); casos extremos (dato sensible pegado) → GDI puede REDACTAR con
  marca visible "contenido redactado por GDI" + motivo auditado (el original queda
  en clinical, accesible por gate).
- Caso cerrado/anulado: hilos en solo lectura.
- El estudiante escribe fuera de horario/espera respuesta: expectativa visible
  ("te responderemos en X días hábiles" — SLA configurable de respuesta, RF-016).

## Criterios de aceptación
- [ ] CA-1: DAE consulta a GDI en el hilo interno seed → notificación, respuesta,
      todo en el expediente; el estudiante no ve nada de ese hilo.
- [ ] CA-2: hilo con estudiante completo y visible para él; menciones incorporan
      con recorte correcto.
- [ ] CA-3 (negativo): docente no accede a ningún hilo (403); en un caso de
      cuidados, DAE no accede al hilo interno (solo GDI/Secretaría [S-23]); la
      redacción de GDI deja marca y auditoría.
- [ ] CA-4 (accesibilidad): hilo navegable por teclado, mensajes con autor y hora
      anunciables, campo de texto accesible; axe 0.

## Propiedades (fuzzing)
- P1: todo mensaje pertenece a exactamente un hilo de un caso y es inmutable; los
  lectores de cada hilo ⊆ participantes autorizados por authz.

## Fuera de alcance
- Mensajería general fuera de casos (no pedida; el sistema no es un chat).
- Comunicaciones formales con documento (RF-023).

## Dudas abiertas
- ¿Detección activa de datos sensibles pegados en hilos con participación DAE
  (patrones RUT/diagnóstico) o basta advertencia + redacción GDI? Hoy: advertencia +
  redacción; detección automática como mejora (valor agregado).
- ¿SLA institucional de respuesta al estudiante en el hilo? (seed: 3dh informativo).
