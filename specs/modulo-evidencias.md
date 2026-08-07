# Módulo Evidencias — índice (RF-043 a RF-062)

**El bloque PRIORITARIO del cliente y el más grande (20 RF).** Compromiso nº3:
"ningún caso se cierra sin evidencia de implementación cargada y validada — el
desafío institucional más urgente". Motores de apoyo: sla-engine (períodos),
RF-016/017 (maquinaria de avisos/escalamiento), audit.
**ADVERTENCIA DE INFERENCIA:** nombres y reparto inferidos del bloque del cap. 7,
módulo 7 del cap. 4 y figura 3.2. El corte Tanda 3/Tanda 4 en RF-052/053 es
provisional por rango. Specs ancladas a capacidad, no a código — reconciliar con doc
extendido.
**Supuestos estructurales del módulo:** [S-21] (qué significa "validada" — acotado al
modo documental) y [S-22] (caso no acreditado: arrastre + renovación no bloqueada +
umbral de instancia institucional).
**MODELO DE EVIDENCIA ([ADR-004](../docs/decisiones/ADR-004-evidencia-por-eventos.md)):**
la evidencia es primariamente el REGISTRO ESTRUCTURADO del evento de aplicación.
Tres modos por tipo de apoyo: EVENTO (evaluativos — confirmación 1-click del docente,
cruce automático, fecha CAPTURADA; circuito en specs/evidencia-eventos.md),
ATESTACIÓN (confirmación estructurada del responsable) y DOCUMENTAL (residual:
carga + validación estructural + muestreo). Condición de adopción del modo evento:
dudas ALTA en DUDAS.md (exigencia a docentes; fechas desde Banner).

## Los 20 RF y su orden interno de construcción

### Ciclo operativo (Tanda 3)
| RF | Nombre (inferido) | Prioridad |
|---|---|---|
| [RF-043](rf/RF-043-periodos-evidencia.md) | Períodos de evidencia | crítica |
| [RF-044](rf/RF-044-apertura-automatica.md) | Apertura automática del período | crítica |
| [RF-045](rf/RF-045-checklist-por-caso.md) | Checklist de evidencias por caso | crítica |
| [RF-046](rf/RF-046-tablero-sede.md) | Tablero de evidencias de la sede | crítica |
| [RF-047](rf/RF-047-carga-evidencias.md) | Carga de evidencias en el caso | crítica |
| [RF-048](rf/RF-048-validacion-automatica.md) | Validación automática + rondas de muestreo | crítica |
| [RF-049](rf/RF-049-estados-evidencia.md) | Estados de la evidencia y subsanación | crítica |
| [RF-050](rf/RF-050-archivo-expediente.md) | Archivo en el expediente | alta |
| [RF-051](rf/RF-051-cierre-periodo.md) | Cierre automático del período | crítica |
| [RF-052](rf/RF-052-bloqueo-cierre.md) | Bloqueo de cierre sin evidencia (regla de oro) | crítica |

### Fiscalización y visibilidad (Tanda 4)
| RF | Nombre (inferido) | Prioridad |
|---|---|---|
| [RF-053](rf/RF-053-recordatorios-periodo.md) | Recordatorios D-15/D-7/D-1 | crítica |
| [RF-054](rf/RF-054-casos-incumplidos.md) | Casos incumplidos: rojo y arrastre [S-22] | crítica |
| [RF-055](rf/RF-055-escalamiento-periodo.md) | Escalamiento (Dirección de Sede → GDI) | crítica |
| [RF-056](rf/RF-056-semaforo-por-sede.md) | Semáforo de cumplimiento por sede | crítica |
| [RF-057](rf/RF-057-reportes-cumplimiento.md) | Reportes de cumplimiento | alta |
| [RF-058](rf/RF-058-gestion-directa-regularizacion.md) | Gestión directa GDI y regularización tardía | alta |
| [RF-059](rf/RF-059-historico-ciclos.md) | Histórico de ciclos | alta |
| [RF-060](rf/RF-060-exportacion-auditoria.md) | Exportación para auditoría | alta |
| [RF-061](rf/RF-061-configuracion-ciclo.md) | Configuración del ciclo | alta |
| [RF-062](rf/RF-062-indicadores-en-linea.md) | Indicadores en línea (contrato de datos) | alta |

Orden de construcción: 043→044→045→047→048→049 (el ciclo mínimo carga-válida),
luego 046 (tablero) y 051/052 (cierre y regla de oro), después la fiscalización
053→054→055→056, y encima 057/058/059/060/061/062. RF-061 se construye
INCREMENTALMENTE (cada RF que define un parámetro lo agrega al panel).

## Cobertura del texto del PDF
| Término del PDF | RF dueño |
|---|---|
| "Apertura y cierre automáticos" (cap. 7) / "apertura automática de períodos" (cap. 4) | RF-043, RF-044, RF-051 |
| "Checklist por caso" | RF-045 |
| "Carga y validación" | RF-047, RF-048 |
| "Estados" | RF-049 |
| "Recordatorios D-15/D-7/D-1" / "recordatorios escalados" | RF-053 |
| "Escalamiento" | RF-055 (sobre RF-017) |
| "Semáforo por sede" | RF-056 |
| "Bloqueo de cierre sin evidencia" / regla de oro (fig. 3.2) | RF-052 |
| "Histórico" | RF-059 |
| "Exportación para auditoría" | RF-060 |
| "Reportes de cumplimiento" (cap. 4) / "reporte de cumplimiento por sede" (fig. 3.2) | RF-057 |
| "Archivo en el expediente" (cap. 4) | RF-050 |
| "Caso marcado en rojo en su tablero" (fig. 3.2) | RF-054 |
| "Cada sede ve qué le falta y de qué caso" (fig. 3.2) | RF-046 |
| Gestión directa del equipo nacional (6,4%, cap. 3.1) | RF-058 |
| "Actualiza indicadores en línea" (etapa 7) | RF-062 |
| Parametrización del ciclo (principio RF-020 aplicado) | RF-061 |

## Dudas del módulo (las principales, todas en DUDAS.md)
- [S-21] Definición institucional de "validada" (ALTA).
- [S-22] Arrastre indefinido + renovación no bloqueada; ¿tope de arrastre? (MEDIA,
  transversal con Tanda 6).
- "Cierre excepcional documentado" como tercera categoría (RF-058, cruza con la
  excepción a la regla de oro de Tanda 0).
- Quién carga evidencia además de DAE (RF-047) · reversión post-cierre (RF-049) ·
  D-X corridos vs hábiles (RF-053) · umbral verde y anonimato relativo del semáforo
  (RF-056) · formatos CNA/Superintendencia (RF-050/060).
