# RF-007 — Guardado en borrador

**Módulo:** solicitudes
**Prioridad:** alta
**Depende de:** RF-002, RF-005
**Inferencia:** del bloque Solicitudes (cap. 7: "borradores") y módulo 1 ("guardado en
borrador"). Un estudiante que junta certificados médicos no completa el trámite en
una sentada — el borrador es la diferencia entre terminar y abandonar.

## Descripción
El estudiante guarda su solicitud a medio llenar —incluidos documentos ya cargados—
y la retoma cuando quiera, desde cualquier dispositivo. El borrador es privado, no
genera caso ni folio, y no es visible para ningún otro perfil.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | guardar, retomar, eliminar SUS borradores |
| Sede (DAE) | NADA — los borradores no existen para gestión |
| Jefatura de Escuela | nada |
| Docente | nada |
| Secretaría General | nada |
| Equipo nacional GDI | ver MÉTRICA agregada de borradores (cuántos, antigüedad) sin contenido; nunca el detalle |
| Rectoría/Vicerrectorías | nada |

## Datos que toca
- Entidades: borrador (estudiante, tipo, respuestas parciales, documentos staging,
  fecha de último guardado, versión del formulario).
- ¿Datos clínicos? SÍ: respuestas sensibles y documentos médicos de un borrador viven
  en `clinical` desde el primer guardado (la sensibilidad no espera al envío).

## Flujo principal
1. "Guardar borrador" disponible en todo momento del formulario; además autoguardado
   periódico silencioso (indicador "guardado a las HH:mm").
2. Al volver, "Continuar mi solicitud" retoma exactamente donde quedó, con sus
   documentos ya validados en verde.
3. Al enviar, el borrador se convierte en solicitud (RF-006) y desaparece como borrador.

## Flujos alternos / casos borde
- Formulario cambió de versión con borrador abierto: al retomar, se migra lo migrable,
  se avisa qué cambió y qué debe re-responder. Nunca se envía contra una versión obsoleta.
- Tipo deshabilitado (RF-001) con borrador existente: aviso al retomar; puede
  descartarlo o consultar a su sede.
- Un borrador por tipo por estudiante (evita confusión de duplicados); intentar un
  segundo ofrece retomar el existente.
- Expiración: borradores sin actividad se eliminan a los N meses con aviso previo
  (N=6 provisional — ver dudas); la eliminación queda auditada.
- Estudiante pierde matrícula vigente con borrador guardado: el borrador persiste;
  el ENVÍO valida matrícula (RF-004).

## Criterios de aceptación
- [ ] CA-1: guardar a medio llenar (con un documento cargado), cerrar sesión, retomar
      → todo está, incluido el documento en verde.
- [ ] CA-2: autoguardado recupera lo escrito tras cierre abrupto del navegador
      (test e2e).
- [ ] CA-3 (negativo): ningún perfil distinto del dueño accede a un borrador por
      ninguna ruta (ni GDI al detalle) → 403/404 + audit.
- [ ] CA-4 (accesibilidad): el estado de guardado es perceptible sin vista (aria-live);
      retomar es alcanzable por teclado desde el inicio del portal estudiante; axe 0.

## Propiedades (fuzzing)
- P1: un borrador nunca produce caso sin pasar la validación de envío completa (RF-005).
- P2: borrador y solicitud enviada jamás coexisten para el mismo flujo (la conversión
  es atómica).

## Fuera de alcance
- Solicitudes complementarias sobre casos ya enviados (RF-010).
- Notas del evaluador o borradores de resolución (otros módulos).

## Dudas abiertas
- Plazo de expiración de borradores y política de aviso (hoy: 6 meses, aviso a los 5).
