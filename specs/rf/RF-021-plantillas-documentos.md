# RF-021 — Plantillas de documentos administrables

**Módulo:** documentos
**Prioridad:** crítica
**Depende de:** RF-019 (patrón de panel), workflow.md (documentos_generables)
**Inferencia:** del bloque Documentos (cap. 7: "generación automática de resoluciones
y cartas") — la generación exige plantillas, y el principio del sistema exige que
sean ADMINISTRABLES por GDI, no código (mismo patrón que formularios y flujos).

## Descripción
GDI mantiene las plantillas de todos los documentos generables (resoluciones, cartas
de aprobación y rechazo, solicitudes de antecedentes, informes) desde el panel:
texto con campos de combinación ({{estudiante}}, {{folio}}, {{adecuaciones}}...),
versionadas y asociadas a los procesos que las generan. Cambiar el texto de una
resolución es trabajo funcional, no un deploy.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | nada |
| Sede (DAE) | nada |
| Jefatura de Escuela | nada |
| Docente | nada |
| Secretaría General | consultar plantillas vigentes (los documentos que firmará) |
| Equipo nacional GDI | crear, editar, versionar, publicar plantillas |
| Rectoría/Vicerrectorías | nada |

## Datos que toca
- Entidades: plantilla {clave, tipo de documento, contenido con campos, versión,
  vigente}, catálogo de campos de combinación disponibles por proceso (tipado desde
  contracts — un campo inexistente no compila la plantilla).
- ¿Datos clínicos? Las plantillas NO deben combinar campos clínicos: el catálogo de
  campos disponibles EXCLUYE el esquema clinical por construcción — una resolución
  dice el apoyo aprobado, jamás el diagnóstico (los destinatarios incluyen jefaturas
  y docentes: regla 1 y 2).

## Flujo principal
1. GDI edita en borrador con vista previa (datos de un caso seed de ejemplo).
2. La validación verifica campos existentes y ausencia de campos clínicos.
3. Publica → versión nueva; los documentos ya generados conservan la versión con que
   se generaron (inmutables, RF-025).

## Flujos alternos / casos borde
- Plantilla usada por un proceso no se puede eliminar (solo versionar o deshabilitar
  si el proceso deja de referenciarla).
- Campos vacíos al generar (dato opcional ausente): la plantilla declara
  comportamiento por campo (omitir sección / texto alternativo), nunca "{{campo}}"
  crudo en un documento oficial.

## Criterios de aceptación
- [ ] CA-1: GDI edita la plantilla de resolución seed, publica, y el siguiente
      documento generado la usa; los anteriores no cambian.
- [ ] CA-2: plantilla con campo inexistente o clínico no publica (error señalando el
      campo).
- [ ] CA-3 (negativo): roles no-GDI reciben 403 en el panel de plantillas + audit.
- [ ] CA-4 (accesibilidad): editor y vista previa operables por teclado; axe 0.

## Propiedades (fuzzing)
- P1: ningún documento generado contiene marcadores sin resolver ni campos del
  esquema clinical (se fuzzea generando contra casos aleatorios del seed).

## Fuera de alcance
- La generación misma (RF-022/023), firma (RF-024), versionado de documentos (RF-025).

## Dudas abiertas
- Formatos institucionales reales de resolución/carta (logo, estructura, pie legal) —
  llegan con levantamiento; seed usa formato provisional marcado.
