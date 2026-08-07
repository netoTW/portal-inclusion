# RF-062 — Indicadores de evidencia en línea

**Módulo:** evidencias
**Prioridad:** alta
**Depende de:** RF-049/051/054/056/058; lo consume specs/reportes-dashboards.md
**Inferencia:** de la etapa 7 del PDF ("actualiza indicadores en línea"), el cap. 11
(las metas medibles) y la síntesis del cap. 12 ("producir indicadores"). Es el
CONTRATO DE DATOS entre el módulo evidencias y la reportería institucional.

## Descripción
El módulo evidencias expone sus indicadores calculados en vivo, como fuente única
para el módulo de reportes/dashboards y el dataset de Power BI: cumplimiento, metas
del cap. 11, arrastres, gestión directa, tasas de reversión del muestreo. "En línea"
significa que el indicador refleja el estado actual sin consolidación manual — el
reporte institucional que hoy toma días, permanente.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| (todos) | NADIE consume estos indicadores directamente: se sirven a través del módulo reportes (con sus reglas por perfil) y de RF-057 |
| Equipo nacional GDI | ver el diccionario de indicadores y su trazabilidad de cálculo |

## Datos que toca
- Entidades: definiciones de indicador {clave, fórmula documentada, fuente, corte},
  expuestos vía contracts al módulo reportes (interfaz tipada, no acceso a tablas).
- ¿Datos clínicos? NO: todos los indicadores son conteos/porcentajes operativos.

## Indicadores mínimos (las metas del cap. 11 primero — cada uno con test contra seed)
| Indicador | Meta cliente | Hoy |
|---|---|---|
| % casos con evidencia cargada y VALIDADA | ≥95% | 78,3% solo declarada |
| Sedes bajo 70% de cumplimiento (con casos) | 0 | 5 de 21 |
| % confirmación de recepción de sede | 100% | 9,6% |
| % constancia de aviso al docente | 100% | 6,7% |
| % casos con fecha de aplicación registrada | 100% | 0% |
| Recordatorios manuales del equipo nacional | 0 | todos |
Más los operativos del ciclo: arrastrados (N, antigüedad, sobre umbral de instancia
formal), % gestión directa (hoy 6,4%), regularizaciones fuera de plazo, tasa de
reversión de muestreo [RF-048, solo documental], tiempo medio de subsanación.
Y los de EVENTOS (ADR-004, en tiempo real): % evaluaciones confirmadas, tiempo medio
confirmación, reprogramaciones vivas, % fecha de aplicación CAPTURADA (la meta 100%
del cap. 11 se cumple por diseño en modo evento — este indicador lo DEMUESTRA), y
desglose de cumplimiento por modo.
(Los indicadores de recepción/aviso se COMPUTAN aquí pero sus datos nacen en la etapa
de Aplicación — módulos adecuaciones/comunicaciones, Tandas 6/8; la fecha de
aplicación ahora nace en el circuito de eventos.)

## Flujo principal
1. Cada indicador tiene UNA definición (fórmula versionada y documentada — el
   diccionario es consultable por GDI: qué mide, cómo, desde qué fuente).
2. El módulo reportes consume vía contracts; Power BI recibe el MISMO dataset
   (reportes-dashboards CA-4: una sola fuente).
3. Cortes: en vivo (estado actual) y congelados por período (RF-051/059).

## Flujos alternos / casos borde
- Indicador cuyo dato de origen aún no existe (fecha de aplicación antes de Tanda 6):
  el indicador existe con valor "sin datos" explícito — nunca 0% falso ni 100% vacío
  (un denominador de cero se muestra como tal).
- Cambio de fórmula: versión nueva del indicador; los congelados guardan con qué
  versión se calcularon.
- Metas configurables [RF-061]: la meta es dato del indicador, comparable en el
  dashboard (valor vs meta).

## Criterios de aceptación
- [ ] CA-1: con seed calibrado, cada indicador de la tabla reproduce exactamente los
      valores "hoy" del PDF (78,3 / 5 de 21 / 9,6 / 6,7 / 0 / 45,8 en su equivalente)
      — el seed ES la línea base.
- [ ] CA-2: el diccionario documenta fórmula y fuente de cada indicador; el valor
      servido a reportes cuadra con el cómputo directo (test de consistencia).
- [ ] CA-3 (negativo): la interfaz de indicadores no expone microdatos (folios, RUT)
      — solo agregados tipados; el acceso directo a tablas del módulo desde reportes
      no existe (imports prohibidos por arquitectura, verificado por lint de
      dependencias).
- [ ] CA-4 (accesibilidad): n/a directo (contrato de datos); las vistas que lo
      consumen cumplen lo suyo (reportes-dashboards CA-5).

## Propiedades (fuzzing)
- P1: para cualquier población seed generada, indicador servido = recomputación
  independiente de referencia (oráculo del generador).
- P2: congelado un período, sus indicadores congelados son inmutables.

## Fuera de alcance
- Visualización (reportes-dashboards) y k-anonimato (ADR-002 — aplica en la capa de
  reportes; estos agregados de sede no llevan datos personales).
- Indicadores predictivos (valor agregado, cap. 12 — fase posterior).

## Dudas abiertas
- Lista definitiva de indicadores institucionales (el cap. 11 es el piso; el doc
  extendido puede traer más).
