# ADR-002 — K-anonimato en dashboards agregados

**Fecha:** 07-08-2026
**Estado:** aceptada
**Decisores:** Pablo Herrera

## Contexto

El RFP exige que Rectoría/Vicerrectorías consulten "el dashboard ejecutivo con
información agregada" y no lleguen a "datos identificables" (cap. 8). El PDF **no
define** qué cuenta como agregación segura. Con 25 sedes, 7 escuelas y condiciones de
salud como dimensiones, un agregado ingenuo re-identifica: "casos de esquizofrenia en
sede Temuco, escuela X, 2026 = 1" señala a una persona concreta aunque no muestre
nombre ni RUT.

## Decisión

Todo indicador expuesto a perfiles sin derecho a datos identificables (Rectoría/
Vicerrectorías, y cualquier exportación externa como el dataset de Power BI) pasa por
un pipeline único de agregación con **k-anonimato: los grupos con menos de k
observaciones se suprimen o se funden en una categoría superior** ("otras condiciones",
sede agrupada por región, etc.).

- Default: **k = 5**, configurable por GDI a nivel de plataforma (nunca por consulta).
- Una sola implementación en el módulo de reportes: no existen dos caminos hacia el
  mismo indicador. El PowerBIAdapter consume el dataset YA agregado.
- El red team incluye vectores de re-identificación por combinación de filtros.

Esto es **decisión de diseño nuestra, no exigencia del RFP**: el cliente pidió
"agregada", nosotros definimos el estándar técnico que lo hace verificable.

## Consecuencias

- (+) La regla nº4 "por diseño" (Rectoría jamás llega a datos identificables) se vuelve
  testeable: es un umbral, no un juicio caso a caso.
- (+) Defensa sólida ante fiscalización y ante la Ley 21.719 si se confirma
  ([ADR-003](ADR-003-marco-normativo-ampliado.md), [S-14](../../SUPUESTOS.md)).
- (−) En sedes chicas, celdas legítimas desaparecen del dashboard ejecutivo (se
  muestran fundidas); hay que explicarlo en el manual de Rectoría para que no parezca
  un dato faltante.
- Pendiente: validar k=5 y las reglas de fusión con AIEP en el levantamiento.
