# RF-034 — Renovación semestral

**Módulo:** adecuaciones
**Prioridad:** crítica
**Depende de:** RF-030, workflow.md (recurrencia [S-05]), RF-010 (distinción con complementarias)
**Inferencia:** del bloque Adecuaciones (cap. 7: "renovación"), módulo 4
("renovación simplificada"), figura 2 ("renovación semestral automática de
adecuaciones, acompañante y accesibilidad" [S-17]). 263 renovaciones = ~mitad de la
carga real. Concilia "simplificada" y "automática" según [S-05]: el motor abre, una
persona confirma.

## Descripción
Al abrirse el ciclo del semestre, el motor crea SOLO las instancias de renovación de
todo apoyo vigente renovable, arrastrando lo aprobado (adecuaciones, condiciones,
documentos vigentes). La confirmación es mínima: el estudiante (o quien defina el
levantamiento) confirma que sigue necesitando el apoyo; sin cambios, no se re-evalúa
de cero ni se re-piden documentos vigentes. La mitad de la carga operativa del
equipo nacional pasa a ser un flujo de confirmaciones.

**Cruce [S-22]:** la renovación procede AUNQUE el caso del semestre anterior esté
incumplido de evidencias — la deuda es de la sede (RF-054), el apoyo es del
estudiante (RF-030 P2). Test espejo obligatorio.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | confirmar su renovación (1 click + declarar cambios si los hay) |
| Sede (DAE) | ver renovaciones pendientes/confirmadas de su sede; recordar |
| Jefatura de Escuela | ver renovaciones de sus estudiantes |
| Docente | recibir avisos actualizados al renovarse (RF-032) |
| Secretaría General | firmar la resolución de renovación (si el tipo la exige — ver dudas) |
| Equipo nacional GDI | configurar reglas de renovación por tipo; panorama nacional del ciclo |
| Rectoría/Vicerrectorías | agregados |

## Datos que toca
- Entidades: instancia de renovación {caso hijo (workflow), caso madre, apoyos
  arrastrados, estado: abierta → confirmada → resuelta | no_renovada}.
- ¿Datos clínicos? Reusa lo del expediente; documentos VENCIDOS al renovar se piden
  de nuevo (regla de reuso RF-010).

## Flujo principal
1. Apertura del semestre → el motor crea instancias hijas de todo apoyo renovable
   vigente (workflow.md) y notifica al estudiante: "confirma tus apoyos".
2. Estudiante confirma sin cambios → flujo abreviado: la renovación se resuelve con
   revisión mínima configurada por tipo (¿resolución nueva o anexo? — duda) y las
   vigencias se extienden; docentes re-avisados (RF-032).
3. Confirma CON cambios (necesita más/otro apoyo) → deriva a evaluación normal
   (como complementaria sobre la renovación).
4. No confirma en plazo: recordatorios; al vencer, no_renovada — el apoyo vence por
   RF-030 con registro de que se le ofreció renovar.

## Flujos alternos / casos borde
- Estudiante que ya no está matriculado al abrir el ciclo: la renovación no se abre
  (RF-004); registro del motivo.
- Renovación de caso INCUMPLIDO de evidencias: procede [S-22]; el nuevo semestre
  genera su propio checklist — la deuda vieja sigue arrastrada aparte (RF-054).
- Documento base vencido (certificado que venció en el intertanto): la renovación
  lo pide (única fricción documental legítima).
- Renovaciones ≠ complementarias (RF-010): visibles como cadena madre→hija (RF-035).

## Criterios de aceptación
- [ ] CA-1: apertura de ciclo seed → instancias hijas SOLO de apoyos vigentes
      renovables, con arrastre correcto; confirmación 1-click sin cambios resuelve
      el flujo abreviado y extiende vigencias; docentes re-avisados.
- [ ] CA-2: con cambios → evaluación normal; sin confirmación → no_renovada con
      registro y vencimiento limpio.
- [ ] CA-3 (negativo/cruce): caso incumplido renueva igual (test espejo [S-22] con
      RF-054 CA-3b y RF-030 CA-2 — las tres specs verifican el mismo invariante).
- [ ] CA-4 (accesibilidad): la confirmación del estudiante es un flujo de 1 pantalla
      operable por teclado y móvil; axe 0.

## Propiedades (fuzzing)
- P1: instancia de renovación ⇔ apoyo madre vigente y renovable al abrir el ciclo;
  nunca renovación de revocados/vencidos previos.
- P2: independencia renovación ↔ estado de evidencia del caso madre ([S-22], espejo
  de RF-030 P2).

## Fuera de alcance
- La mecánica de instancias hijas (workflow.md); el ciclo de evidencias del nuevo
  semestre (RF-043+).

## Dudas abiertas
- ¿Quién confirma la renovación? ([S-05] — hoy: el estudiante; ¿o basta continuidad
  de matrícula para renovar sin confirmación en algunos tipos?).
- ¿La renovación exige resolución nueva firmada o un anexo simplificado? (impacta
  RF-022/028 y la carga de Secretaría — levantamiento).
