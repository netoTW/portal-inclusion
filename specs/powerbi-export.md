# PowerBI export — dataset de indicadores para la analítica institucional

**Vive en:** `/packages/reportes` (PowerBIAdapter en contracts) · Integración cap. 9:
"exponer todos los indicadores para su consumo desde la analítica institucional".
Decisión marco: ADR-001 (Power BI es el destino de analítica del ecosistema híbrido).

## Diseño
- **Una sola fuente:** el dataset expone LOS MISMOS indicadores del contrato RF-062
  y del módulo reportes, YA agregados con k-anonimato (ADR-002). Power BI consume el
  resultado del pipeline — JAMÁS microdatos ni tablas crudas (regla dura: no existe
  conexión directa de Power BI a la base).
- **Dev:** endpoint(s) HTTP autenticados que sirven el dataset en JSON/CSV con
  esquema versionado y documentado (el "contrato de datos" para el equipo de BI de
  AIEP). **Prod:** el MISMO dataset vía el mecanismo institucional (push dataset /
  dataflow — se define con el tenant real; el adapter conmuta).
- Autenticación de consumo: credencial de servicio dedicada, con registro de cada
  extracción (patrón RF-060: quién consumió qué y cuándo).
- Cortes: en vivo y congelados por período (RF-051/059) — la analítica institucional
  puede reconstruir series históricas estables.

## Criterios de aceptación
- [ ] CA-1: el dataset expone los indicadores del cap. 11 + operativos (RF-062) y
      sus valores COINCIDEN con el dashboard del módulo reportes (misma fuente —
      reportes-dashboards CA-4).
- [ ] CA-2 (negativo): el dataset no contiene identificadores (RUT, nombre, folio)
      ni celdas bajo el umbral k (ADR-002) — test de contenido sobre el export
      completo con seed; no existe ruta de Power BI a microdatos.
- [ ] CA-3: esquema versionado: un cambio de esquema es versión nueva documentada
      (el BI institucional no se rompe en silencio).
- [ ] CA-4: cada extracción queda registrada.

## Dudas
- Mecanismo exacto de ingesta del Power BI institucional (workspace, gateway,
  frecuencia) — levantamiento con TI de AIEP (dependencia declarada de ADR-001).
