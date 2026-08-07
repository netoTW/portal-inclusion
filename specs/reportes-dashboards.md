# Reportes y dashboards — módulo adicional del kit

**Origen:** no es uno de los 8 módulos numerados del PDF, pero lo exigen sus caps. 8
(perfil Rectoría = "consultar el dashboard ejecutivo con información agregada"), 11
("reporte institucional en línea", "dashboards en tiempo real") y la figura 3.2
("reporte de cumplimiento por sede"). Es la experiencia COMPLETA del perfil
Rectoría/Vicerrectorías y la reportería operativa de GDI y sedes.

## Qué entrega, por audiencia
| Audiencia | Vista | Regla de acceso |
|---|---|---|
| Rectoría/Vicerrectorías | dashboard ejecutivo: volúmenes, tasas de aprobación, cumplimiento de evidencias, SLA, tendencias | SOLO agregados; k-anonimato según ADR-002; jamás datos identificables ni drill-down a caso |
| Equipo nacional GDI | reportes nacionales completos: cumplimiento por sede (semáforo), casos por estado/etapa, SLA vencidos, exportación para auditoría/CNA | acceso completo |
| Sede (DAE) | sus indicadores: semáforo propio, casos por estado, evidencias pendientes | SOLO su sede (scoping territorial) |
| Auditoría/CNA (vía GDI) | exportaciones históricas (RF-062 y trazabilidad) | genera GDI |
| Power BI institucional | dataset de indicadores vía PowerBIAdapter | mismo pipeline de agregación — Power BI NUNCA recibe microdatos identificables, consume el dataset ya agregado |

## Indicadores mínimos (las metas del cap. 11 son la lista base — cada uno con test e2e)
- % casos con evidencia cargada y VALIDADA (meta ≥95%)
- Sedes bajo 70% de cumplimiento (meta 0; denominador = sedes con casos en el ciclo)
- % confirmación de recepción de sede · % constancia de aviso a docente ·
  % fecha de aplicación registrada · % tiempo de resolución medible (metas 100%)
- Tiempos por etapa vs SLA; casos atrasados y escalados
- Volúmenes por período/sede/escuela/tipo de apoyo; tasa de aprobación
- Renovaciones del semestre: abiertas / completadas

## Principios
- "En línea" = los indicadores se calculan de los datos vivos, sin consolidación manual.
  (Materialización/caché es decisión de implementación, no de spec.)
- El módulo LEE de los demás módulos vía contracts; no escribe datos de negocio.
- Toda vista agregada pasa por el mismo pipeline de agregación con k-anonimato (ADR-002):
  no hay dos caminos para el mismo indicador.
- Exportaciones quedan registradas en audit (quién exportó qué y cuándo).

## Criterios de aceptación transversales (se detallan en Fase 0)
- [ ] CA-1: el dashboard de Rectoría muestra los indicadores del cap. 11 con datos seed
      y coincide con el cálculo de referencia del generador.
- [ ] CA-2 (negativo): ninguna respuesta de API para rol Rectoría contiene identificadores
      (RUT, nombre, nº de caso); grupos bajo el umbral k se suprimen/agrupan (ADR-002).
- [ ] CA-3 (negativo): DAE de sede A no obtiene indicadores de sede B ni el nacional desagregado.
- [ ] CA-4: el dataset PowerBIAdapter expone los mismos valores que el dashboard (una sola fuente).
- [ ] CA-5 (accesibilidad): dashboards navegables por teclado, axe 0 violaciones; los
      gráficos tienen alternativa en tabla.

## Fuera de alcance
- Semáforo operativo dentro del flujo de evidencias (vive en /packages/evidencias;
  este módulo lo consume/reexpone, no lo reimplementa).
- Indicadores predictivos ("valor agregado" del cap. 12) — fase posterior.

## Dudas abiertas
- Umbral k exacto y reglas de supresión → ADR-002 fija default; validar con AIEP.
- Cruce con progresión/retención/titulación (ProgresionAdapter): qué indicadores pide AIEP.
