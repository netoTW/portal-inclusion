# Módulo Cuidados — índice (RF-037 a RF-042) + prueba Severa

**El proceso 2 del motor** (Portal de Cuidados, marco Ley 21.790 → ADR-003), atendido
por el estudiante-CUIDADOR. Reusa el motor de gestión 21.790 existente de Pablo
(lógica y catálogos) montado como CONFIGURACIÓN del workflow — cero código propio de
cuidados en el motor. Junto a él, [specs/rf020-proceso-severa.md](rf020-proceso-severa.md):
el guion de la prueba de parametrización con el proceso 3 (153 casos NEE/Severa).
**EL DISEÑO SENSIBLE DE LA TANDA — datos de terceros [S-23]:** los antecedentes
pueden contener datos de salud de la PERSONA CUIDADA (no usuaria, no puede
consentir): declaración responsable del cuidador + minimización (acreditación
administrativa antes que informes médicos) + acceso solo GDI/Secretaría con
propósito + derechos del tercero vía GDI. Materializado en RF-037/038; pendiente
validación jurídica AIEP (duda MEDIA de Tanda 0).
**ADVERTENCIA DE INFERENCIA:** el flujo propio exacto es configuración; etapas seed
calcan las genéricas hasta el levantamiento. Specs ancladas a capacidad.

## Los 6 RF y su orden interno de construcción
| RF | Nombre (inferido) | Prioridad | Depende de |
|---|---|---|---|
| [RF-037](rf/RF-037-solicitud-cuidados.md) | Solicitud de cuidados (flujo propio) | crítica | workflow, RF-001..008 |
| [RF-038](rf/RF-038-antecedentes-cuidados.md) | Antecedentes de cuidados (terceros [S-23]) | crítica | RF-037, authz |
| [RF-039](rf/RF-039-evaluacion-resolucion-cuidados.md) | Evaluación y resolución | crítica | RF-038, RF-022/024 |
| [RF-040](rf/RF-040-medidas-cuidados.md) | Medidas otorgadas | crítica | RF-039, patrón RF-029/030 |
| [RF-041](rf/RF-041-seguimiento-cuidados.md) | Seguimiento de medidas | alta | RF-040 |
| [RF-042](rf/RF-042-renovacion-cuidados.md) | Renovación de cuidados | alta | RF-040/041, patrón RF-034 |

## Cobertura del texto del PDF (cap. 7 / cap. 4 módulo 5)
| Término | RF dueño |
|---|---|
| "Solicitudes… con flujo propio" / "flujo propio y configurable: solicitud" | RF-037 |
| "Antecedentes" | RF-038 |
| "Evaluación, resolución" | RF-039 |
| "Medidas" / "medidas otorgadas" | RF-040 |
| "Seguimiento" (cap. 4) | RF-041 |
| "Renovaciones" | RF-042 |
| "Un noveno proceso a considerar" (NEE/Severa, cap. 4) | rf020-proceso-severa.md (prueba de RF-020) |

## Reglas transversales del módulo
- Todo antecedente de cuidados = esquema clinical, acceso GDI/Secretaría con
  propósito (fijado en authz.md desde Tanda 0; DAE gestiona SIN contenido [S-20]).
- El docente que recibe una medida de cuidados NO sabe que es de cuidados
  ("medida de apoyo institucional" — minimización de contexto, RF-040).
- Decisión humana obligatoria (doble hard-stop: datos sensibles + terceros).
- [S-22] aplica también a medidas de cuidados (verificación cruzada en RF-040 P2 y
  RF-042 P2).

## Dudas del módulo elevadas a DUDAS.md
- Validación jurídica de la declaración responsable [S-23] (MEDIA, ya registrada).
- ¿Solicitud por situación de cuidado o por persona cuidada? (RF-037)
- Criterios de elegibilidad (¿RSH, tramos?) y catálogo real de medidas (RF-039/040)
- ¿Quién ejecuta el seguimiento y con qué periodicidad? (RF-041)
- Cuidado entre estudiantes AIEP (RF-038) · renovación: mismas 2×ALTA de RF-034 (RF-042)
