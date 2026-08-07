# RF-050 — Archivo de evidencias en el expediente

**Módulo:** evidencias
**Prioridad:** alta
**Depende de:** RF-047, RF-049, StorageAdapter, ficha-estudiante
**Inferencia:** del módulo 7 del cap. 4 ("archivo en el expediente") y figura 3.2
(paso 5: "cierre del período y archivo digital"). El dolor de origen: hoy los
respaldos viven en correos, SharePoint suelto y carpetas locales de sede (cap. 2).

## Descripción
Toda evidencia queda archivada EN el expediente digital del caso: los archivos del
modo documental con sus versiones y validaciones, Y los REGISTROS ESTRUCTURADOS de
los modos evento y atestación (confirmaciones con fecha capturada, reprogramaciones,
autores — ADR-004), que son evidencia de primera clase en el legajo, no metadatos. Ante una fiscalización (Leyes 20.422/21.091) o la acreditación CNA, el
respaldo de un caso se encuentra en un lugar, completo, en segundos.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | nada directo (ver duda de transparencia en RF-045) |
| Sede (DAE) | consultar el archivo de evidencias de sus casos |
| Jefatura de Escuela | nada (ve estados, no archivos) |
| Docente | nada |
| Secretaría General | consultar al resolver/cerrar |
| Equipo nacional GDI | consultar todo; armar el legajo de un caso para auditoría |
| Rectoría/Vicerrectorías | nada |

## Datos que toca
- Entidades: vínculo evidencia↔expediente (la evidencia YA vive en el caso desde
  RF-047; este RF garantiza permanencia, orden y recuperabilidad), legajo exportable
  por caso.
- ¿Datos clínicos? Las evidencias marcadas sensibles siguen su régimen (RF-047);
  el legajo respeta el perfil de quien lo genera.

## Flujo principal
1. Cada evidencia cargada queda ligada al caso y al período, con metadatos completos
   (versión, validación, autores, fechas).
2. Al cerrar el período (RF-051), el conjunto se sella como "archivo del ciclo" del
   caso: inmutable, con las versiones y la historia.
3. Desde el caso (o la ficha), "ver evidencias" muestra el archivo por ciclo; GDI
   puede generar el legajo (PDF/ZIP índice + archivos) para un requerimiento externo.

## Flujos alternos / casos borde
- Storage en producción = SharePoint (StorageAdapter): la ruta/permiso institucional
  no puede romper la garantía — el acceso SIEMPRE pasa por la plataforma (authz), el
  repositorio es backend, no canal alternativo (nota para sso-m365/despliegue).
- Regularización tardía (post-cierre): se archiva en el ciclo con su marca fuera de
  plazo — el sello registra la adición, no se reescribe la historia.
- Caso anulado con evidencias parciales: el archivo se conserva igual (audit.md: nada
  se borra).

## Criterios de aceptación
- [ ] CA-1: cerrado el período seed, el caso muestra su archivo del ciclo completo
      (evidencias, versiones, validaciones) y el legajo exportado por GDI contiene
      exactamente eso, con índice.
- [ ] CA-2: la adición tardía queda registrada sobre el sello sin alterar lo sellado
      (verificable por la cadena de audit).
- [ ] CA-3 (negativo): el legajo generado por un actor respeta su perfil (un legajo
      pedido "como DAE" no incluye material clínico [S-20]); URL directa de storage
      sin authz no sirve nada.
- [ ] CA-4 (accesibilidad): la vista de archivo por ciclo es navegable por teclado,
      cada archivo con nombre descriptivo (no "scan0001.pdf" a secas: nombre + tipo +
      fecha); axe 0.

## Propiedades (fuzzing)
- P1: toda evidencia referenciada por un checklist existe en storage y viceversa
  (sin huérfanos bidireccional, refuerza P1 de RF-047).
- P2: el contenido sellado de un ciclo es inmutable: re-generar el legajo produce
  bytes equivalentes (mismo índice, mismos archivos).

## Fuera de alcance
- Exportación MASIVA para auditoría (RF-060, Tanda 4 — esto es el legajo por caso).
- Histórico multi-ciclo comparado (RF-059, Tanda 4).
- Políticas de retención documental a largo plazo (misma duda que audit.md).

## Dudas abiertas
- Formato requerido por fiscalizadores/CNA para legajos (¿estructura específica?) —
  levantamiento.
