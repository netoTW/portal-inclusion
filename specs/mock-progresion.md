# Mock Progresión — retención/avance/titulación simulados

**Vive en:** `/mocks/progresion` · **Sirve a:** ProgresionAdapter (contracts).
Integración del cap. 9 del PDF: "relacionar los apoyos otorgados con permanencia,
avance académico y titulación". Qué sistema real la alimenta: DUDA (junto a [S-06]).

## Superficie mínima
Por estudiante (id opaco) y período: {estado: vigente | retirado | egresado |
titulado, avance curricular (%), promedio rango}. SOLO lo agregable — este adapter
alimenta INDICADORES, no expedientes.

## Reglas
- **Consumidor único: el módulo reportes** (specs/reportes-dashboards.md), para los
  indicadores longitudinales "apoyos vs permanencia/titulación". Los datos de
  progresión NO entran a la ficha ni al expediente (no son datos del caso — y
  cruzar rendimiento académico con condición de salud a nivel individual es
  exactamente el tipo de correlación que la agregación con k-anonimato (ADR-002)
  debe impedir que salga: el cruce ocurre SOLO dentro del pipeline de agregación).
- Datos del seed, coherentes con la población (estudiantes con casos tienen su
  trayectoria simulada).
- OpenAPI + Prism, mismo patrón de conmutabilidad y flags de falla que mock-banner.

## Criterios de aceptación
- [ ] CA-1: reportes calcula un indicador longitudinal seed (ej. retención de
      estudiantes con apoyos vs período) contra el mock.
- [ ] CA-2 (negativo): ningún dato de progresión aparece en ficha, expediente ni
      respuestas individuales de ningún perfil; el cruce individual apoyo×progresión
      no existe fuera del pipeline agregado (vector red team de re-identificación,
      ADR-002).
- [ ] CA-3: test de contrato del ProgresionAdapter.

## Dudas
- ¿Qué sistema institucional entrega progresión/retención/titulación y con qué
  granularidad? (duda existente [S-06]/DUDAS.md).
- ¿AIEP quiere estos cruces desde el día 1 o post go-live? (alcance de enero).
