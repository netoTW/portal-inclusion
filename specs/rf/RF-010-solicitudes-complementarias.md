# RF-010 — Solicitudes complementarias (multi-caso)

**Módulo:** solicitudes
**Prioridad:** alta
**Depende de:** RF-006, RF-012, ficha-estudiante
**Inferencia:** del dato duro del cap. 1: el 22,7% de las solicitudes son
COMPLEMENTARIAS de estudiantes que ya tienen un caso abierto — el multi-caso no es un
borde, es un quinto de la operación. (El bloque del cap. 7 no lo nombra como ítem;
lo especificamos como RF propio porque cruza todo el módulo. Reconciliar numeración
con doc extendido.)

## Descripción
Un estudiante con caso abierto puede crear solicitudes adicionales —otro tipo de apoyo,
o una ampliación— sin repetir lo ya entregado. Cada solicitud es un caso independiente
con su ciclo completo, pero el expediente los muestra juntos y la evaluación ve el
contexto: qué tiene, qué pide, qué se le aprobó antes.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | crear complementarias; ver TODOS sus casos juntos con estado de cada uno |
| Sede (DAE) | ver los casos de su sede del estudiante, vinculados |
| Jefatura de Escuela | ver adecuaciones vigentes consolidadas (no las solicitudes) |
| Docente | ver adecuaciones vigentes consolidadas de sus asignados |
| Secretaría General | ver el contexto completo al resolver |
| Equipo nacional GDI | ver todo el expediente multi-caso |
| Rectoría/Vicerrectorías | nada individual |

## Datos que toca
- Entidades: vínculo estudiante↔casos (N), marca de complementaria (referencia al
  caso base opcional), datos reusados (identificación, consentimiento).
- ¿Datos clínicos? Reusa los del expediente; documentos nuevos siguen RF-005.

## Flujo principal
1. Estudiante con caso(s) entra a "Nueva solicitud": ve sus casos vigentes y elige
   tipo nuevo (RF-001).
2. La plataforma reusa identificación (RF-004) y consentimiento vigente (RF-008); el
   checklist solo pide lo que NO esté vigente en el expediente (un certificado válido
   ya entregado no se pide de nuevo — regla del catálogo por documento).
3. El envío crea caso propio (folio propio, RF-006) marcado complementario; el
   evaluador lo ve CON el contexto del expediente.

## Flujos alternos / casos borde
- Misma solicitud dos veces (mismo tipo, caso abierto en curso): aviso "ya tienes una
  solicitud de este tipo en curso (folio X)" — puede continuar solo si declara qué
  cambia (evita duplicados accidentales sin bloquear casos legítimos).
- Renovaciones NO son complementarias: las crea el motor (recurrencia, [S-05]) —
  distinción visible en el expediente.
- Caso base anulado o cerrado no bloquea complementarias (cada caso es independiente).
- Reuso documental con documento vencido: se pide de nuevo (vigencia manda).

## Criterios de aceptación
- [ ] CA-1: estudiante con caso abierto crea complementaria de otro tipo → caso nuevo
      con folio propio, sin re-pedir consentimiento ni certificado vigente ya entregado.
- [ ] CA-2: la vista del evaluador muestra el expediente (casos previos, adecuaciones
      vigentes) junto a la solicitud nueva.
- [ ] CA-3 (negativo): el contexto de expediente para DAE excluye casos de otras sedes
      del mismo estudiante (scoping por caso, no por persona); Docente/Jefatura no ven
      solicitudes, solo el consolidado de adecuaciones vigentes.
- [ ] CA-4 (accesibilidad): "Mis solicitudes" con N casos es navegable por teclado,
      estados con icono+texto; axe 0.

## Propiedades (fuzzing)
- P1: casos de un estudiante son independientes: ninguna transición de uno altera el
  estado de otro (el vínculo es de lectura).
- P2: el reuso documental jamás sirve un documento vencido ni uno de otro estudiante.

## Fuera de alcance
- Renovaciones (motor de recurrencia, workflow.md).
- La vista integradora completa (specs/ficha-estudiante.md).

## Dudas abiertas
- Regla real de reuso documental entre casos (¿todos los tipos lo permiten?) —
  catálogo por documento, confirmar en levantamiento.
- El scoping de DAE ante estudiante con casos en DOS sedes (¿se da en la práctica,
  ej. cambio de sede?): hoy cada caso pertenece a su sede y no se cruzan.
