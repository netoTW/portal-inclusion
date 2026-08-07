# Módulo Documentos — índice (RF-021 a RF-028)

**Motores de apoyo:** RF-021 (plantillas) + FirmaAdapter [S-07] + StorageAdapter
(MinIO dev / SharePoint prod) + audit. El post-decisión de punta a punta
(validacion-documental.md) atraviesa este módulo entero: click de decisión →
resolución → firma → notificación con documento → Aplicación.
**ADVERTENCIA DE INFERENCIA:** nombres y reparto inferidos del bloque del cap. 7 y
módulo 3 del cap. 4. RF-028 es el más inferido (capacidad institucional implícita).
Specs ancladas a capacidad, no a código.

## Los 8 RF y su orden interno de construcción
| RF | Nombre (inferido) | Prioridad | Depende de |
|---|---|---|---|
| [RF-021](rf/RF-021-plantillas-documentos.md) | Plantillas administrables | crítica | RF-019 |
| [RF-025](rf/RF-025-versionamiento-documentos.md) | Versionamiento de documentos | alta | StorageAdapter |
| [RF-022](rf/RF-022-generacion-resoluciones.md) | Generación automática de resoluciones | crítica | RF-021, RF-012 |
| [RF-024](rf/RF-024-firma-electronica.md) | Firma electrónica | crítica | RF-022, FirmaAdapter |
| [RF-028](rf/RF-028-folio-registro-resoluciones.md) | Folio y registro oficial de resoluciones | alta | RF-024 |
| [RF-023](rf/RF-023-cartas-comunicaciones-formales.md) | Cartas y comunicaciones formales | alta | RF-021/022 |
| [RF-026](rf/RF-026-descarga-estudiante.md) | Descarga por el estudiante | alta | RF-024/025 |
| [RF-027](rf/RF-027-expediente-digital.md) | Expediente digital del caso | crítica | RF-025, RF-050 |

Orden: plantillas y versionado son el piso; encima el ciclo de la resolución
(generar → firmar → registrar), luego cartas, descarga y el expediente que integra
todo.

## Cobertura del texto del PDF
| Término (cap. 7 / cap. 4 módulo 3) | RF dueño |
|---|---|
| "Generación automática de resoluciones" | RF-022 (sobre RF-021) |
| "cartas de aprobación y rechazo, solicitudes de antecedentes e informes" | RF-023 |
| "Versionamiento" | RF-025 |
| "firma electrónica" | RF-024 |
| "Descarga por el estudiante" | RF-026 |
| "Expediente digital" | RF-027 |
| Plantillas administrables (condición de la generación, principio RF-020) | RF-021 |
| Numeración/registro oficial (capacidad institucional implícita) | RF-028 |

## Reglas transversales del módulo
- NINGÚN documento generado contiene campos clínicos (RF-021 lo hace imposible por
  catálogo; test de corpus en RF-022/023) — las resoluciones circulan a jefaturas.
- Documento firmado = inmutable, con efectos solo post-firma (RF-024).
- Nada se borra: versiones (RF-025) + marca "erróneo" con motivo.

## Dudas del módulo elevadas a DUDAS.md
- Resolución modificatoria post-firma: ¿existe como figura institucional? (RF-022)
- Subrogancia de firma de Secretaría General (RF-024, se suma a [S-07])
- Formato institucional de resolución/carta y correlativo oficial (RF-021/028)
- Acceso del estudiante a sus documentos post-egreso (RF-026)
