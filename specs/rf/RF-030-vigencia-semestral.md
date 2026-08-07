# RF-030 — Control de vigencia semestral

**Módulo:** adecuaciones
**Prioridad:** crítica
**Depende de:** RF-029, calendario semestral (seed/contracts)
**Inferencia:** del bloque Adecuaciones (cap. 7: "control de vigencia") y módulo 4
("control de vigencia semestral"). Resuelve el lado VIGENCIAS del cruce [S-22].

## Descripción
Toda adecuación otorgada tiene vigencia acotada al semestre (u otra ventana que su
tipo declare). La plataforma controla sola el ciclo: vigente → por vencer (aviso) →
vencida o renovada (RF-034). Nadie mantiene planillas de "qué sigue vigente" — hoy
263 renovaciones/año se rastrean a mano.

**Cruce [S-22] — regla explícita de este RF:** la vigencia del apoyo es del
ESTUDIANTE y no depende de la deuda de evidencia de la sede. Una adecuación vigente
sigue vigente y es renovable aunque el caso esté "incumplido" o arrastrado
(RF-054); la deuda administrativa vive en el caso y en el semáforo de la sede, jamás
recorta el apoyo. Recíproco: el vencimiento de la vigencia NO extingue la deuda de
evidencia (el checklist arrastrado acredita el semestre en que ESTUVO vigente).

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | ver vigencia de sus apoyos en claro ("vigente hasta el término del 2°S 2026") |
| Sede (DAE) | ver vigencias de sus casos y próximos vencimientos |
| Jefatura de Escuela | ver vigencias de sus estudiantes |
| Docente | ver SOLO adecuaciones VIGENTES de sus asignados (las vencidas desaparecen de su panel) |
| Secretaría General | consulta |
| Equipo nacional GDI | configurar reglas de vigencia por tipo; ver panorama nacional de vencimientos |
| Rectoría/Vicerrectorías | agregados |

## Datos que toca
- Entidades: vigencia {adecuación, desde, hasta (fin de semestre por defecto),
  estado: vigente → por_vencer → vencida | renovada | revocada}; calendario
  semestral institucional (datos, editable GDI — fechas reales: levantamiento).
- ¿Datos clínicos? NO.

## Flujo principal
1. Al materializarse (RF-029), la vigencia se calcula según el tipo y el calendario
   semestral.
2. Próximo al término del semestre: estado por_vencer + disparo del ciclo de
   renovación (RF-034) para tipos renovables.
3. Sin renovación confirmada al vencer: vencida — desaparece del panel docente y de
   los checklists futuros; el historial queda (RF-035).

## Flujos alternos / casos borde
- Apoyo otorgado a mitad de semestre: vigencia hasta el fin del semestre EN CURSO
  (no 6 meses corridos) [regla inferida — duda].
- Tipos con vigencia distinta (anual, permanente-mientras-dure-la-condición): el
  catálogo la declara; "semestral" es el default del PDF.
- Caso incumplido con apoyo vigente: NINGÚN efecto sobre la vigencia [S-22] — test
  espejo del CA-3b de RF-054.
- Cambio del calendario semestral: recalcula solo vigencias FUTURAS (auditado).

## Criterios de aceptación
- [ ] CA-1: adecuación seed vigente → por_vencer al acercarse el fin de semestre →
      vencida si no renueva; el panel docente refleja cada transición.
- [ ] CA-2 (cruce [S-22]): caso arrastrado/incumplido → sus adecuaciones vigentes NO
      cambian de estado ni se excluyen de renovación (test espejo de RF-054 CA-3b).
- [ ] CA-3 (negativo): nadie "extiende" una vigencia a mano sin renovación o
      resolución (no existe la acción; GDI corrige solo errores materiales,
      auditado).
- [ ] CA-4 (accesibilidad): fechas y estados de vigencia en texto claro (icono+texto);
      axe 0.

## Propiedades (fuzzing)
- P1: toda adecuación está en exactamente un estado de vigencia; las transiciones
  siguen el grafo declarado.
- P2: estado de vigencia y estado de evidencia del caso son independientes (ninguna
  secuencia de eventos de evidencia altera vigencias, y viceversa) — la propiedad
  que fija [S-22].

## Fuera de alcance
- El ciclo de renovación (RF-034); los avisos de vencimiento (RF-032/016).

## Dudas abiertas
- ¿Vigencia de un apoyo otorgado a mitad de semestre (hasta fin del semestre en
  curso — hoy — o un semestre completo desde el otorgamiento)?
- Fechas reales del calendario semestral AIEP [S-03].
