# RF-028 — Folio y registro oficial de resoluciones

**Módulo:** documentos
**Prioridad:** alta
**Depende de:** RF-022, RF-024
**Inferencia:** el bloque del cap. 7 no lo nombra como ítem; es condición implícita
de "generación automática de resoluciones" en una institución: toda resolución lleva
número oficial correlativo y existe un registro consultable. (Décimo... octavo hueco
del bloque de 8 RF cubierto con la capacidad institucional obvia — RECONCILIAR con
doc extendido: si RF-028 real es otra cosa, esta spec se renumera.)

## Descripción
Cada resolución firmada recibe su número oficial correlativo institucional
(independiente del folio del caso: una resolución por año correlativa, formato
provisional `RES-GDI-AAAA-NNN` [S-18 ampliado]) y queda inscrita en el registro de
resoluciones: consultable, exportable, con verificación de integridad. Secretaría
General (ministro de fe) tiene su libro al día sin llevarlo a mano.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | ver el número de SU resolución |
| Sede (DAE) | consultar el registro filtrado a su sede |
| Jefatura de Escuela | ver números de resoluciones de sus estudiantes |
| Docente | nada |
| Secretaría General | el registro completo: consulta, exportación (su función de fe) |
| Equipo nacional GDI | registro completo |
| Rectoría/Vicerrectorías | conteos agregados vía reportes |

## Datos que toca
- Entidades: registro de resoluciones {número oficial, resolución (RF-022), caso,
  fecha de firma, firmante, hash del documento}.
- ¿Datos clínicos? NO.

## Flujo principal
1. Al FIRMARSE la resolución (RF-024) se asigna el número correlativo (la numeración
   es de resoluciones efectivamente firmadas — sin huecos por borradores).
2. El registro inscribe la entrada con hash; el documento exhibe su número.
3. Consulta del registro por número/caso/fecha/firmante; exportación con registro de
   quién exportó.

## Flujos alternos / casos borde
- Concurrencia de firmas (lote RF-024): números únicos y correlativos (unicidad en BD).
- Resolución sobre caso anulado después: la resolución NO desaparece del registro
  (histórico institucional); el registro muestra el estado posterior del caso.
- Verificación: dado un PDF, el hash permite confirmar contra el registro que es la
  resolución auténtica y vigente.

## Criterios de aceptación
- [ ] CA-1: dos resoluciones firmadas seed → números correlativos correctos del año;
      el documento y el registro coinciden (número y hash).
- [ ] CA-2: la consulta y exportación del registro funcionan por los filtros
      declarados; la exportación queda registrada.
- [ ] CA-3 (negativo): el número se asigna SOLO al firmar (no existe pre-asignación
      manipulable); DAE consulta solo su sede; nadie edita el registro (append-only,
      mismo régimen que audit).
- [ ] CA-4 (accesibilidad): el registro es tabla semántica consultable por teclado;
      axe 0.

## Propiedades (fuzzing)
- P1: números oficiales únicos, correlativos por año, asignados solo a resoluciones
  firmadas; registro append-only.

## Fuera de alcance
- La generación y firma (RF-022/024) — aquí nace el número y el asiento.
- Repositorio institucional externo de resoluciones (si existe, se exporta hacia él —
  levantamiento).

## Dudas abiertas
- Formato y dueño institucional del correlativo (¿Secretaría General lleva hoy un
  libro de resoluciones? ¿numeración por año, por proceso?) — levantamiento.
- Si el doc extendido asigna RF-028 a otra capacidad, esta spec se re-etiqueta
  (anclada a capacidad, no a código).
