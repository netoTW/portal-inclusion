# RF-035 — Historial completo de adecuaciones

**Módulo:** adecuaciones
**Prioridad:** alta
**Depende de:** RF-029/030/034, audit
**Inferencia:** del bloque Adecuaciones (cap. 7: "historial") y módulo 4
("historial completo").

## Descripción
Toda la trayectoria de apoyos de un estudiante es consultable: qué se le otorgó,
cuándo, con qué resolución, qué se renovó semestre a semestre, qué venció o se
revocó y por qué. La cadena madre→hijas de renovaciones es navegable. Para la
evaluación de un caso nuevo, el evaluador ve el contexto completo sin arqueología.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | ver SU historial completo de apoyos |
| Sede (DAE) | historial de estudiantes con caso en su sede |
| Jefatura de Escuela | historial de adecuaciones de sus estudiantes (sin antecedentes) |
| Docente | NO — solo vigentes (RF-033); el historial no es asunto docente |
| Secretaría General | historial al resolver |
| Equipo nacional GDI | todo |
| Rectoría/Vicerrectorías | nada individual |

## Datos que toca
- Entidades: LEE registros de RF-029/030/034 + audit (deriva, no duplica); vista de
  línea de tiempo por estudiante y por caso.
- ¿Datos clínicos? NO en el historial de adecuaciones (ajustes, no causas); el
  historial CLÍNICO es otra cosa (expediente, gate).

## Flujo principal
1. Desde la ficha del estudiante o el caso: "Historial de apoyos" — línea de tiempo
   por semestre con cada adecuación, su estado y su resolución de origen (link).
2. Cadena de renovaciones navegable (madre → hijas → estado actual).
3. Filtros: por tipo de apoyo, por estado, por período.

## Flujos alternos / casos borde
- Historial migrado (541 casos históricos): aparece con marca de origen
  pre-plataforma y los huecos reales visibles ("sin fecha de resolución registrada")
  — la migración no inventa trazabilidad que nunca existió.
- Revocaciones y anulaciones: visibles con motivo (nada desaparece).
- Estudiante con casos en más de una sede (histórico): DAE ve solo la parte de su
  sede (scoping por caso, RF-010).

## Criterios de aceptación
- [ ] CA-1: estudiante seed con 3 semestres de trayectoria (otorgamiento →
      renovación → renovación con cambio) → línea de tiempo completa y cadena
      navegable.
- [ ] CA-2: los datos migrados muestran su marca de origen y sus huecos honestos.
- [ ] CA-3 (negativo): docente no accede al historial (403); jefatura ve
      adecuaciones históricas pero no antecedentes; DAE limitado a su sede.
- [ ] CA-4 (accesibilidad): línea de tiempo como lista semántica ordenada, filtros
      por teclado; axe 0.

## Propiedades (fuzzing)
- P1: el historial es derivación pura de los registros + audit (sin almacenamiento
  propio que pueda divergir — mismo patrón RF-018).

## Fuera de alcance
- Historial del CASO (RF-018/RF-027) — este es el eje apoyo/estudiante.
- Indicadores longitudinales (reportes/ProgresionAdapter).

## Dudas abiertas
- Ninguna propia (hereda las de RF-034 y migración).
