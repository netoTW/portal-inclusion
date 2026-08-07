# RF-057 — Reportes de cumplimiento

**Módulo:** evidencias
**Prioridad:** alta
**Depende de:** RF-051/054/055/056
**Inferencia:** del módulo 7 del cap. 4 ("reportes de cumplimiento") y figura 3.2
(paso 6: "reporte de cumplimiento por sede"; y "alerta a GDI y reporte de
incumplimiento"). Hoy cada reporte se arma consolidando planillas a mano (cap. 2).

## Descripción
Los reportes operativos del ciclo de evidencias, generados por la plataforma sin
consolidación manual: cumplimiento por sede/escuela/período, detalle de incumplidos y
arrastrados, reportes de incumplimiento emitidos (RF-055), y resultado de rondas de
muestreo (RF-048). Con corte en vivo o al cierre, exportables y con registro de quién
generó qué.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | nada |
| Sede (DAE) | generar los reportes de SU sede |
| Jefatura de Escuela | reporte de cumplimiento de SUS estudiantes (estados, sin documentos) |
| Docente | nada |
| Secretaría General | reportes nacionales de consulta |
| Equipo nacional GDI | todos los reportes, todos los cortes |
| Rectoría/Vicerrectorías | nada aquí (su vista es el dashboard agregado de reportes-dashboards) |

## Datos que toca
- Entidades: definiciones de reporte (parámetros), registro de generaciones (quién,
  qué, cuándo, alcance — auditado).
- ¿Datos clínicos? NO: cumplimiento, folios, estados. Jamás diagnóstico ni contenido
  de evidencia.

## Flujo principal
1. El usuario elige reporte, alcance (período/sede/escuela) y corte (vivo o cierre).
2. La plataforma lo genera desde los mismos datos de tableros y semáforo (una sola
   fuente); pantalla + exportación (CSV y PDF con formato institucional).
3. La generación queda registrada (alimenta la trazabilidad de "qué se informó y
   cuándo" ante auditorías).

## Reportes mínimos del ciclo
| Reporte | Contenido | Audiencia |
|---|---|---|
| Cumplimiento por sede | % acreditado, N, arrastrados, semáforo, desglose por MODO de evidencia (evento/atestación/documental — ADR-004) | GDI, DAE (propio) |
| Confirmación de eventos | evaluaciones confirmadas/pendientes/reprogramadas por sede y docente, en tiempo real | GDI, DAE (propio) |
| Detalle de incumplidos | folios, antigüedad, ítems pendientes, escalamientos | GDI, DAE (propio) |
| Incumplimiento (formal) | el reporte que emite RF-055 al escalar | GDI, Dirección de Sede (correo) |
| Rondas de muestreo | rondas, tamaños, tasas de reversión [RF-048] | GDI |
| Resultado del período | el congelado de RF-051, comparado contra el anterior | GDI, Secretaría |

## Flujos alternos / casos borde
- Reporte en vivo vs congelado: el corte queda IMPRESO en el reporte (fecha-hora y
  tipo de corte) — dos personas con el mismo reporte del mismo corte ven lo mismo.
- Exportación masiva histórica → RF-060 (auditoría); esto es operación corriente.
- Período sin cerrar: el reporte "resultado del período" no existe aún (solo en vivo).

## Criterios de aceptación
- [ ] CA-1: cada reporte mínimo se genera con seed y cuadra exactamente con
      tablero/semáforo del mismo corte.
- [ ] CA-2: exportaciones CSV y PDF válidas, con corte impreso y registro de generación.
- [ ] CA-3 (negativo): DAE genera solo su sede (parámetro sede forzado por scoping,
      no elegible); Jefatura solo sus estudiantes y sin documentos; los reportes no
      contienen datos clínicos (test de contenido).
- [ ] CA-4 (accesibilidad): reportes en pantalla como tablas semánticas; los PDF
      generados con estructura (encabezados reales, no imagen); axe 0.

## Propiedades (fuzzing)
- P1: mismo (reporte, alcance, corte congelado) ⇒ mismo contenido, siempre
  (determinismo de reportes).

## Fuera de alcance
- Dashboard ejecutivo e indicadores institucionales (reportes-dashboards, que CONSUME
  estos cómputos).
- Exportación de auditoría completa (RF-060).

## Dudas abiertas
- Formato institucional del PDF (logo, firmas) — llega con la marca (design system,
  fuera de alcance dev).
