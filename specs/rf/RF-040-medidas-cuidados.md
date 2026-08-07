# RF-040 — Medidas de cuidados otorgadas

**Módulo:** cuidados
**Prioridad:** crítica
**Depende de:** RF-039, RF-029/030 (patrón de registro y vigencia)
**Inferencia:** del bloque Cuidados (cap. 7: "medidas") y módulo 5 ("medidas
otorgadas"). Mismo patrón que adecuaciones (RF-029/030) con catálogo PROPIO.

## Descripción
Las medidas de cuidados otorgadas (flexibilidad de asistencia, reprogramación de
evaluaciones por emergencia de cuidado, priorización de horarios, justificación
especial) existen como registros estructurados desde la resolución, con vigencia,
responsables y modo de evidencia — la misma maquinaria de adecuaciones, catálogo
distinto. Lo que el docente ve: SOLO la medida que lo involucra ("acepta
justificación de inasistencia por cuidado"), sin contexto alguno.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | ver SUS medidas vigentes y cómo usarlas |
| Sede (DAE) | ver medidas vigentes de sus casos; gestionar las operativas de sede |
| Jefatura de Escuela | ver medidas vigentes de sus estudiantes (sin contexto de cuidado) |
| Docente | ver SOLO la medida aplicable en su sección, sin causa ("medida de apoyo institucional") |
| Secretaría General | consulta |
| Equipo nacional GDI | catálogo de medidas; todo |
| Rectoría/Vicerrectorías | conteos agregados |

## Datos que toca
- Entidades: medida otorgada {caso, resolución, tipo (catálogo propio), condiciones,
  ámbito, vigencia, modo de evidencia (ADR-004 — mayoritariamente ATESTACIÓN)}.
- ¿Datos clínicos? NO en el registro (la medida, no la situación) — misma regla que
  RF-029, con un matiz MÁS estricto: el aviso al docente de una medida de cuidados
  ni siquiera dice "cuidados" (dice "medida de apoyo institucional") — que un
  docente sepa que el estudiante es cuidador ya es información sensible de contexto
  [S-23, minimización].

## Flujo principal
1. Resolución de cuidados firmada → medidas materializadas (patrón RF-029).
2. Vigencia y renovación según su tipo (patrón RF-030; semestral por defecto).
3. Avisos a involucrados según el tipo (patrón RF-032, plantilla neutra).
4. Su implementación se acredita por el ciclo de evidencias con modo atestación
   (el responsable confirma) — mismo período y semáforo (RF-043+).

## Flujos alternos / casos borde
- Medidas de urgencia (emergencia de cuidado súbita): NO hay bypass (coherencia
  RF-036); si el levantamiento exige respuesta rápida, es proceso con SLA corto —
  misma duda de la medida provisoria.
- Medida que involucra a TODOS los docentes del estudiante (flexibilidad general):
  el aviso va a cada uno, neutro.
- Revocación (deja de ser cuidador): patrón RF-029/030, con cese avisado.

## Criterios de aceptación
- [ ] CA-1: resolución de cuidados seed → medidas materializadas con vigencia; el
      docente involucrado ve la medida neutra en su panel (RF-033) sin la palabra
      "cuidados" ni contexto.
- [ ] CA-2: la medida entra al ciclo de evidencias como atestación y cuenta en el
      semáforo de la sede como cualquier apoyo.
- [ ] CA-3 (negativo): la respuesta del panel docente para una medida de cuidados
      no contiene el tipo de proceso de origen (test de allowlist — vector red team);
      impedir medidas no aprobadas aplica igual (invariantes RF-036).
- [ ] CA-4 (accesibilidad): vistas de medidas accesibles, lenguaje claro para el
      estudiante sobre cómo ejercerlas; axe 0.

## Propiedades (fuzzing)
- P1: toda medida en cualquier vista proviene de resolución de cuidados firmada
  vigente (espejo RF-036 P1 para el proceso 2).
- P2: independencia vigencia/evidencia aplica igual que en adecuaciones ([S-22],
  espejo de RF-030 P2 — verificación cruzada).

## Fuera de alcance
- Catálogo real de medidas (levantamiento; seed: 4-5 medidas verosímiles marcadas).
- Seguimiento periódico (RF-041) y renovación (RF-042).

## Dudas abiertas
- Catálogo institucional de medidas de cuidados y cuáles involucran docentes —
  levantamiento.
