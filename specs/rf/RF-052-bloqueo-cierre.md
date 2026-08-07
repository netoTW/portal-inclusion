# RF-052 — Bloqueo de cierre sin evidencia validada (regla de oro)

**Módulo:** evidencias
**Prioridad:** crítica (es el compromiso nº3 del cliente, "el desafío institucional
más urgente")
**Depende de:** RF-049, RF-051, workflow.md (guarda de cierre)
**Inferencia:** EXPLÍCITO en el PDF, tres veces: compromiso nº3 ("ningún caso se
cierra sin evidencia de implementación cargada y validada"), bloque del cap. 7
("bloqueo de cierre sin evidencia") y figura 3.2 ("Regla de oro: sin evidencia válida
cargada, el caso no se cierra").

## Descripción
El cierre de un caso (etapa 7) tiene una guarda inviolable: exige evidencia VALIDADA
[S-21]. No es una advertencia que se acepta, no es un permiso especial — la
transición no existe sin la condición. Este RF es la materialización en evidencias de
la guarda genérica de workflow.md (CA-4/P3): aquí se especifica su semántica exacta.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | ver su caso "en acreditación" mientras espera cierre |
| Sede (DAE) | ver qué falta para que el caso pueda cerrar (deep link al checklist) |
| Jefatura de Escuela | ver estado |
| Docente | nada |
| Secretaría General | ejecutar el cierre administrativo [S-09] — que también respeta esta guarda para el cierre del CASO |
| Equipo nacional GDI | NADA especial: la guarda aplica a GDI igual (workflow.md) |
| Rectoría/Vicerrectorías | nada |

## Datos que toca
- Entidades: guarda de transición (metadatos del proceso), evento de habilitación de
  cierre (emitido por RF-051 al acreditar).
- ¿Datos clínicos? NO.

## Flujo principal
1. Caso acreditado (RF-049/051) → se habilita la transición de cierre; el cierre
   automático de la etapa 7 procede (vigencia, renovación, indicadores).
2. Caso NO acreditado → la transición de cierre no está disponible para NADIE; la UI
   muestra por qué ("faltan 2 evidencias por validar") con deep link.

## Flujos alternos / casos borde
- Caso ANULADO (workflow.md [S-19]): NO pasa por esta guarda — anulación ≠ cierre; el
  caso no completó su ciclo y las métricas lo cuentan aparte. La anulación
  administrativa post-resolución de un caso solo para esquivar la evidencia sería
  visible: motivo obligatorio + auditoría + aparece en reportes de anulaciones.
- Procesos sin evidencia exigida (`requiere_evidencia_para_cierre=false`, ej. algunos
  flujos de Cuidados): la guarda no aplica — es configuración del proceso (RF-019,
  con la distinción de niveles: el proceso seed 1 no admite esa edición).
- Reversión de validación post-cierre (RF-049): hallazgo de auditoría, no reapertura
  (el cierre es estable) — duda registrada en RF-049.
- Excepción institucional: NO existe en el diseño. Si el levantamiento revela que AIEP
  la necesita, se diseña como decisión formal de alto nivel con registro reforzado —
  duda MEDIA ya registrada en DUDAS.md (Tanda 0).

## Criterios de aceptación
- [ ] CA-1: caso acreditado cierra automáticamente su etapa 7 (vigencias, renovación
      e indicadores actualizados); caso no acreditado NO ofrece cierre en UI ni acepta
      la transición por API para NINGÚN rol, GDI incluido (403/422 + audit).
- [ ] CA-2: la UI del caso no acreditado explica exactamente qué falta, con link al
      checklist.
- [ ] CA-3 (negativo — el ataque obvio): intentar cerrar vía manipulación de eventos,
      transición directa en BD de test, o edición de definición del proceso seed →
      todas las vías fallan (cubre CA-4 de workflow.md y suma vectores al red team).
- [ ] CA-3b (negativo): anulación administrativa post-resolución queda contada y
      visible en reportes (no es un cierre disfrazado).
- [ ] CA-4 (accesibilidad): el mensaje de bloqueo es texto claro asociado a la acción
      deshabilitada (no un botón muerto sin explicación); axe 0.

## Propiedades (fuzzing)
- P1 (= P3 de workflow.md, con semántica de evidencias): ninguna secuencia de eventos
  lleva un caso con `requiere_evidencia_para_cierre` a "cerrado" sin estado acreditado
  estable al momento del cierre.
- P2: anulados y cerrados son conjuntos disjuntos en toda métrica (nunca se suman como
  "casos terminados" sin distinción).

## Fuera de alcance
- El cómputo de acreditación (RF-049/051).
- Métricas y semáforo del cumplimiento (Tanda 4).

## Dudas abiertas
- **[TRANSVERSAL, MEDIA en DUDAS.md]** Ciclo de vida del caso NO acreditado
  post-cierre: queda abierto indefinidamente por esta regla. Cruce a resolver
  explícitamente entre la fiscalización (RF-053+, Tanda 4) y las vigencias/renovación
  (RF-029+, Tanda 6): acumulación de casos eternos por sede incumplidora vs.
  estudiante que pierde el apoyo por incumplimiento administrativo ajeno.
- Las otras dos relevantes ya están: excepción institucional (Tanda 0) y reversión
  post-cierre (RF-049).
