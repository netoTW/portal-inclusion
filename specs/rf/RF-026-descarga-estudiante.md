# RF-026 — Descarga de documentos por el estudiante

**Módulo:** documentos
**Prioridad:** alta
**Depende de:** RF-022/024/025
**Inferencia:** EXPLÍCITO: "descarga por el estudiante" (cap. 7) y cap. 8 (perfil
Estudiante: "descargar resoluciones").

## Descripción
El estudiante descarga desde su portal sus documentos oficiales: resoluciones
firmadas, cartas, y los documentos que él mismo subió. Sin pedirle nada a nadie, sin
correos. Cada descarga queda registrada (constancia de que el documento le fue
puesto a disposición — valor probatorio para AIEP).

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | descargar SUS documentos: resoluciones/cartas firmadas y sus propias cargas |
| Sede (DAE) | descargar documentos operativos de sus casos |
| Jefatura de Escuela | descargar resoluciones de sus estudiantes |
| Docente | nada (recibe adecuaciones vía su panel, no documentos) |
| Secretaría General | descargar lo que resuelve |
| Equipo nacional GDI | todo |
| Rectoría/Vicerrectorías | nada |

## Datos que toca
- Entidades: registro de descargas {documento+versión, quién, cuándo, desde dónde}.
- ¿Datos clínicos? Las descargas del estudiante incluyen SUS documentos clínicos
  (son suyos — clinical_gate lo permite para self); las de otros perfiles siguen su
  régimen.

## Flujo principal
1. En "Mis documentos" (y en cada caso), el estudiante ve sus documentos disponibles
   con nombre claro, fecha y estado ("Resolución N° X — firmada el DD-MM-YYYY").
2. Descarga directa (PDF); la entrega se registra.
3. Un documento pendiente de firma NO aparece como disponible (RF-024 CA-3).

## Flujos alternos / casos borde
- Enlace de descarga desde notificaciones (correo): lleva al portal CON
  autenticación — jamás un enlace público al archivo (el correo avisa, el documento
  vive en la plataforma; coherente con authz y con no filtrar documentos por
  reenvíos de correo).
- Estudiante egresado/sin matrícula: CONSERVA acceso a sus documentos históricos
  (derecho sobre sus datos) — el login institucional post-egreso es duda de
  levantamiento (¿cuánto dura la cuenta M365?).
- Documento marcado erróneo (RF-025): desaparece de la vista del estudiante con
  aviso si ya lo había descargado.

## Criterios de aceptación
- [ ] CA-1: resolución firmada seed → visible y descargable por su estudiante; la
      descarga queda registrada; la versión descargada es la firmada (hash coincide).
- [ ] CA-2: pendiente de firma → no listada para el estudiante.
- [ ] CA-3 (negativo): estudiante A no descarga documentos de estudiante B (ni por
      URL directa ni por id adivinado: 403/404 + audit); docente no descarga
      resoluciones.
- [ ] CA-4 (accesibilidad): "Mis documentos" navegable por teclado, nombres de
      archivo descriptivos, PDFs estructurados; axe 0.

## Propiedades (fuzzing)
- P1: toda descarga servida corresponde a un documento cuyo dueño/perfil pasa authz
  (no existe ruta de bypass de storage — hereda el principio de RF-047/RF-050).

## Fuera de alcance
- La notificación que avisa del documento (comunicaciones).
- Expediente completo y su organización (RF-027).

## Dudas abiertas
- **[MEDIA en DUDAS.md]** ¿Qué canal tendrá el ex-estudiante para acceder a su
  expediente y descargar sus resoluciones una vez expirada su cuenta institucional?
  Cruza el derecho de acceso de la Ley 21.719 (ADR-003) con la vigencia de cuentas
  M365; si la respuesta implica acceso alternativo, afecta el diseño del
  IdentityAdapter.
