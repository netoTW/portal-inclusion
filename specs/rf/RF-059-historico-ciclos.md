# RF-059 — Histórico de ciclos de evidencia

**Módulo:** evidencias
**Prioridad:** alta
**Depende de:** RF-051, RF-056
**Inferencia:** del bloque Evidencias (cap. 7: "histórico"). El cliente necesita
demostrar TRAYECTORIA (CNA evalúa mejora continua): de 78,3% declarado a ≥95%
validado, período a período.

## Descripción
Todos los períodos cerrados quedan consultables y comparables: resultado por sede y
nacional, semáforos congelados, arrastres, gestión directa y regularizaciones de cada
ciclo. La pregunta "¿cómo veníamos y cómo vamos?" se responde con datos, no con
memoria institucional.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | nada |
| Sede (DAE) | su propia serie histórica (sus períodos, su evolución) |
| Jefatura de Escuela | nada |
| Docente | nada |
| Secretaría General | serie nacional de consulta |
| Equipo nacional GDI | todo el histórico, todas las sedes, comparaciones libres |
| Rectoría/Vicerrectorías | evolución agregada vía reportes-dashboards |

## Datos que toca
- Entidades: LEE los congelados de RF-051/056 (no computa de nuevo — los históricos
  son los sellos, garantía de que "lo informado" no muta).
- ¿Datos clínicos? NO.

## Flujo principal
1. Vista de histórico: períodos cerrados en serie (tabla + tendencia), nacional y por
   sede.
2. Comparación entre períodos: qué sedes mejoraron/empeoraron, evolución de
   arrastres, % de gestión directa y regularizaciones por ciclo.
3. Los datos históricos MIGRADOS (ciclo 2024-25: 187 seguimientos, 73,3/20,3/6,4)
   entran como "ciclo histórico pre-plataforma" con marca de origen — la serie parte
   con la línea base real, comparable pero distinguible.

## Flujos alternos / casos borde
- Regularizaciones posteriores a un ciclo: el histórico muestra el congelado Y una
  columna "regularizado después" (las dos verdades, separadas — RF-058).
- Sedes que abren/cierran entre ciclos: la serie muestra "sin casos" o "no existía",
  nunca ceros falsos.
- Cambios de umbral de semáforo entre ciclos: cada ciclo con los umbrales de SU época
  (registrados junto al congelado).

## Criterios de aceptación
- [ ] CA-1: cerrados dos períodos seed, la vista compara correctamente y las
      tendencias cuadran con los congelados.
- [ ] CA-2: el ciclo histórico pre-plataforma (seed calibrado 2024-25) aparece como
      línea base con marca de origen y sus números exactos (73,3/20,3/6,4, 21 sedes).
- [ ] CA-3 (negativo): DAE ve solo su serie; los congelados no son editables por
      nadie (no existe la ruta) — intento API 403/404 + audit.
- [ ] CA-4 (accesibilidad): las tendencias tienen SIEMPRE alternativa en tabla (el
      gráfico no es la única representación); axe 0.

## Propiedades (fuzzing)
- P1: la serie histórica es append-only: ciclos cerrados nunca cambian de contenido
  (solo se les puede ANEXAR el dato de regularización posterior).

## Fuera de alcance
- La migración misma del ciclo 2024-25 (specs/migracion.md; aquí se define cómo se
  muestra).
- Indicadores institucionales cruzados (reportes-dashboards).

## Dudas abiertas
- ¿AIEP quiere la serie 2024-25 visible como línea base oficial o solo interna? Hoy:
  visible para GDI/Secretaría, marca de origen.
