# Contexto operativo AIEP — datos reales del documento (24.07.2026)

Este archivo existe para que TODO agente dimensione con la realidad, no con supuestos.
Fuente: "Portal de Inclusión y Cuidados — Resumen de requerimientos" (PDF en /docs-fuente).
Los tres diagramas del PDF (figuras 1, 2 y 3.2) están volcados como texto al final de
este archivo: ningún agente de módulo necesita leer el PDF.
Todo dato externo al PDF o inferido lleva marca [S-xx] → ver /SUPUESTOS.md.
Ambigüedades pendientes de levantamiento → /DUDAS.md.

## La misión en una frase (síntesis textual del cliente)
"AIEP no busca un sistema para administrar formularios. Busca una plataforma que asuma
el trabajo repetitivo que hoy sostiene un equipo para 25 sedes: avisar, recordar, escalar,
generar documentos, controlar vigencias, recolectar evidencia y producir indicadores.
Si al final el equipo nacional sigue persiguiendo evidencias por correo, el proyecto
no cumplió su objetivo."

## Los 3 compromisos no negociables
1. Operativa enero 2027 (el proceso se concentra al inicio de cada semestre)
2. Trazabilidad total: toda acción (quién/qué/cuándo) registrada; nada crítico fuera de la plataforma
3. Evidencia: ningún caso se cierra sin evidencia de implementación cargada y VALIDADA

## Volúmenes reales (corte 23-07-2026)
| Período | Solicitudes | Aprobadas | % aprobación | Sedes |
|---|---|---|---|---|
| 2024 (piloto) | 59 | 29 | 49,2 % | 17 |
| 2025 (despliegue nacional) | 221 | 164 | 74,2 % | 25 |
| 2026 (al 23-07) | 261 | 198 | 75,9 % | 25 |
| **Total acumulado** | **541** | **391** | **72,3 %** | 25 |

- Creció 4,4x en 2,5 años; 2026 ya superó a 2025 con el segundo semestre por delante
- 153 casos Discapacidad Severa (2025-2026) en planilla paralela → tercer proceso a configurar
- 187 registros de seguimiento de evidencias (ciclo 2024-2025)
- 22,7% son solicitudes COMPLEMENTARIAS de estudiantes con caso ya abierto → multi-caso por estudiante
- 263 renovaciones: ~mitad de la carga es MANTENER VIGENTE lo ya otorgado, cada semestre
- 85,8% adecuaciones menores
- Estacionalidad: pico fuerte al inicio de cada semestre (marzo/agosto es inferencia
  nuestra sobre el calendario académico chileno; el PDF solo dice "inicio de cada semestre" [S-03])
- Escala: 25 sedes, 7 escuelas. Universo de estudiantes ~85.000: cifra institucional
  pública de AIEP, EXTERNA al PDF — verificar en levantamiento [S-01]
El generador de /packages/seed DEBE calibrar también la TASA DE APROBACIÓN por año
(tabla de arriba), no solo los volúmenes.

## Estado de la trazabilidad hoy (calibración del generador de datos sucios)
- 45,8% tiene fecha de resolución registrada
- 9,6% confirmación de recepción de sede
- 6,7% constancia de aviso al docente
- 0% fecha de aplicación efectiva del ajuste
- 32 variantes de nombre para 25 sedes · 16 variantes para 7 escuelas
- 41 categorías de "causa principal" en TEXTO LIBRE
El generador de /packages/seed DEBE reproducir estas proporciones y suciedades.

## Evidencias 2024-2025 (el dolor central)
- Universo del ciclo con seguimiento: 187 casos en **21 sedes** (no 25 — solo 21 tuvieron
  casos con seguimiento en ese ciclo). Las métricas por sede usan ese denominador.
- 73,3% "recibida" (= la sede DECLARÓ enviar algo; sin validación de formato/fecha/coherencia)
- 20,3% pendiente sin ningún antecedente (38 casos; **31 de los 38 son de 2025**)
- 6,4% gestión directa del equipo nacional
- Cumplimiento global 78,3% con dispersión brutal: **12 sedes al 100%, 8 parciales**
  (Viña del Mar 7,7%, Valparaíso 42,9%, Online 64%) **y 1 en cero** (Temuco 0%)
- El ciclo 2026 (261 casos) AÚN NO SE INICIA: es el volumen que la plataforma absorbe sola
- Riesgo institucional: fiscalización Superintendencia (Leyes 20.422 y 21.091), acreditación CNA

## Las 7 etapas del proceso con SLA (seed del motor de workflow)
| # | Etapa | Responsable | Plazo |
|---|---|---|---|
| 1 | Solicitud | Estudiante | — |
| 2 | Recepción (nº caso, validación docs, acuse, asignación) | Plataforma | Inmediato |
| 3 | Evaluación (si faltan antecedentes: los pide SOLA y deja en espera) | Equipo GDI | 5 días hábiles |
| 4 | Resolución (genera y firma resolución, asocia adecuaciones) | GDI + Secretaría General | 5 días hábiles |
| 5 | Aplicación (tareas fechadas, acuse sede, aviso efectivo a cada docente) | Sede, Escuela, docentes | 3 días hábiles |
| 6 | Evidencia (checklist por caso, carga, validación formato/fecha/coherencia) | Sede (DAE) | Período definido |
| 7 | Cierre y datos (vigencia, renovación, indicadores en línea) | Plataforma | Automático |
Días hábiles = calendario chileno con feriados. Devolución automática cuando faltan antecedentes.
Renovación semestral automática de **adecuaciones, acompañante y accesibilidad** (figura 2
del PDF — estos tres son tipos de apoyo del catálogo, no solo adecuaciones).
OJO — hay DOS cierres distintos en el modelo [S-09]: el cierre ADMINISTRATIVO del proceso
(lo ejecuta Secretaría General, cap. 8 del PDF) y el cierre DEL CASO (lo ejecuta la
plataforma en la etapa 7, solo tras evidencia validada). No confundirlos.

## Evidencias — mecánica exigida (RF-043 a RF-062, el bloque MÁS GRANDE: 20 RF)
Apertura automática de período · checklist por caso · carga y validación · estados ·
recordatorios D-15 / D-7 / D-1 · escalamiento · semáforo por sede · BLOQUEO de cierre
sin evidencia · histórico · exportación para auditoría.
Cadena de escalamiento si la sede no carga (figura 3.2 del PDF, actúa SOLA):
recordatorios D-15/D-7/D-1 → caso marcado en rojo en el tablero de la sede →
**escalamiento a Dirección de Sede** (destinatario de notificaciones, sin login propio [S-08])
→ alerta a GDI + reporte de incumplimiento.
Regla de oro: **sin evidencia válida cargada, el caso no se cierra.**

## Los 7 perfiles EXACTOS y sus restricciones (base del policy engine)
| Perfil | Puede | NO puede ver |
|---|---|---|
| Estudiante | crear solicitudes, ver estado, subir docs, descargar resoluciones, ver sus medidas | notas internas de gestión |
| Sede (DAE) | gestionar casos de SU sede, observar, seguimiento, cargar evidencias, sus indicadores | casos de OTRAS sedes |
| Jefatura de Escuela | ver sus estudiantes, adecuaciones vigentes, resoluciones, tareas; registrar aviso a docentes | antecedentes clínicos |
| Docente | ver SOLO estudiantes asignados, adecuaciones vigentes, recomendaciones de aplicación | diagnósticos e informes médicos |
| Secretaría General | revisar antecedentes, emitir y FIRMAR resoluciones, cerrar procesos | — |
| Equipo nacional GDI | acceso completo: configuración, parametrización, formularios, flujos, reportes | — |
| Rectoría/Vicerrectorías | dashboard ejecutivo AGREGADO | datos IDENTIFICABLES; no gestionan casos |

REGLAS TRANSVERSALES "POR DISEÑO" (las 4, no solo la primera — el red team ataca las 4):
1. Docente jamás accede a información clínica (imposible por arquitectura)
2. Jefatura de Escuela jamás ve antecedentes clínicos
3. Sede (DAE) jamás ve casos de otra sede (scoping territorial en toda query)
4. Rectoría jamás llega a datos identificables — solo agregación. (El umbral de
   k-anonimato es decisión de diseño nuestra, no exigencia del RFP → docs/decisiones/ADR-002)

## Los 8 módulos del PDF y sus rangos RF (para specs y cola)
| Módulo (nº del PDF) | RF | Nota |
|---|---|---|
| 1. Solicitudes | RF-001–010 | formularios dinámicos, catálogos controlados, identificación automática del estudiante, número único de caso, borradores, consentimiento, NUEVOS FORMULARIOS SIN DESARROLLO |
| 2. Workflow | RF-011–020 | motor configurable, SLA, escalamiento, CREACIÓN DE FLUJOS SIN DESARROLLO (RF-020) |
| 3. Documentos | RF-021–028 | resoluciones/cartas automáticas, versionamiento, firma electrónica, expediente |
| 4. Adecuaciones | RF-029–036 | vigencia semestral, aviso automático a docentes Y ÁREAS, renovación, IMPEDIR adecuaciones no aprobadas |
| 5. Cuidados | RF-037–042 | flujo propio configurable (reusar motor Ley 21.790 de Pablo — aporte nuestro, ver ADR-003) |
| 6. Ficha única del estudiante | **sin rango RF propio** | vista integradora sobre los demás módulos: datos personales, historial, resoluciones, adecuaciones, medidas, documentos, bitácora, comunicaciones, responsables y estado actual. Sus RF probablemente viven repartidos en los otros bloques [S-02] → specs/ficha-estudiante.md |
| 7. Evidencias | RF-043–062 | PRIORITARIO y el más grande (20 RF) |
| 8. Comunicaciones | RF-063–070 | plantillas administrables por equipo funcional; "el correo avisa, el trabajo ocurre en la plataforma" |

Módulo ADICIONAL del kit (no numerado en el PDF, pero exigido por sus caps. 8 y 11):
**Reportes/Dashboards** — dashboard ejecutivo de Rectoría (solo agregados), reportes de
cumplimiento, indicadores en línea, exportación para auditoría y dataset para Power BI
→ specs/reportes-dashboards.md. El semáforo de evidencias le expone datos, pero el
módulo es aparte.

## Los TRES procesos del motor (prueba de parametrización)
1. Solicitudes de apoyo (regular) — el principal
2. Portal de Cuidados — flujo propio
3. Exploración e identificación NEE / Discapacidad Severa (153 casos) — DEBE configurarse
   sin desarrollo adicional: "es la mejor prueba de la parametrización exigida".
   → El test RF-020: un agente-funcionario lo crea usando SOLO la UI de admin + manual.
   El PDF no trae flujo ni RF de este proceso: etapas inferidas hasta el doc extendido [S-11].

## Métricas de éxito del cliente (cap. 11) → convertir en tests e2e del sistema
- Evidencia cargada y VALIDADA ≥ 95% (hoy 78,3% solo declarada)
- 0 sedes bajo 70% de cumplimiento (hoy 5 de 21 sedes con seguimiento 2024-25)
- Confirmación de recepción de sede: 100% (hoy 9,6%)
- Constancia de aviso al docente: 100% (hoy 6,7%)
- Fecha de aplicación registrada: 100% (hoy 0%)
- Tiempo de resolución medible: 100% (hoy 45,8%)
- Recordatorios manuales del equipo nacional: 0 (hoy todos)
- Reporte institucional: en línea (hoy días de trabajo manual)
Además (mismo capítulo): plataforma operativa en enero 2027, todos los módulos
implementados, integraciones funcionando, dashboards en tiempo real, sedes gestionando
sus propios procesos y trazabilidad completa de cada caso.

## Cronograma comprometido del proyecto (cap. 10 del PDF)
| Fase | Plazo |
|---|---|
| Inicio y levantamiento funcional | Agosto 2026 |
| Diseño funcional y técnico (arquitectura, prototipos, integraciones) | Agosto – Septiembre 2026 |
| Desarrollo de módulos, automatizaciones e integraciones | Septiembre – Noviembre 2026 |
| Pruebas funcionales y corrección de incidencias | Noviembre – Diciembre 2026 |
| Piloto en sedes definidas por AIEP | Diciembre 2026 |
| Migración de datos históricos y capacitación | Diciembre 2026 – Enero 2027 |
| **Puesta en producción nacional** | **Enero 2027 (obligatorio)** |
| Estabilización y soporte intensivo | Enero – Marzo 2027 |
Metodología ágil, con entregas parciales, demostraciones y validación continua con AIEP.

## Migración de datos históricos (cap. 10)
- 541 registros de solicitudes **"o más"** + 153 discapacidad severa + 187 seguimientos
  de evidencia + documentación asociada = base de **881 registros** (asumimos sin solape
  entre las tres fuentes [S-12])
- Los datos de origen requieren NORMALIZACIÓN previa: nombres de sede y escuela
  (32 y 16 variantes), categorías de condición en texto libre (41), campos de
  trazabilidad vacíos. El pipeline de migración se prueba contra el generador de
  datos sucios de /packages/seed calibrado con estas cifras.

## Lo que pidieron las sedes (UX no negociable)
La sobrecarga de correos es LA barrera nº1. Quieren: notificaciones automáticas de cambio
de estado + espacio de comunicación DENTRO del sistema. Diseñar minimizando fricción:
las atestaciones críticas deben resolverse en segundos y en 1 click (ej. el registro de
la fecha de aplicación efectiva — QUIÉN la registra es supuesto fuerte nuestro [S-04];
pregunta prioritaria de levantamiento en /DUDAS.md).

## Estructura de la propuesta que el sistema debe poder alimentar (cap. 12)
Matriz RF-001–070 respondida (nativo/configurable/desarrollo/no cubierto), prototipos,
arquitectura, integraciones con supuestos, cronograma a enero, migración, valor agregado
(constructor de formularios y flujos, alertas inteligentes, indicadores predictivos, API abierta).

---

## Los tres diagramas del PDF, como texto (para agentes que no leen PDF)

### Figura 1 — Arquitectura funcional (cap. 5.1), cuatro capas
1. **Quién usa la plataforma:** Estudiante · Sede (DAE) · Escuela y docentes ·
   Secretaría General · Equipo GDI · Rectoría y Vicerrectorías.
2. **El núcleo: motor de procesos** ("lo que hoy se hace a mano"): workflow y reglas de
   negocio · plazos, alertas y escalamientos · resoluciones y cartas automáticas ·
   vigencia y renovaciones · gestión de evidencias.
3. **Un solo lugar para los datos:** expediente digital del estudiante · documentos
   versionados · bitácora de auditoría (quién, qué, cuándo) · perfiles y datos sensibles.
4. **Integraciones (API abierta):** Banner/sistema académico · progresión, retención y
   titulación · Microsoft 365 (SSO y correo) · firma electrónica y Power BI.

### Figura 2 — Flujo de un caso de principio a fin (cap. 5.2)
Las 7 etapas en cadena (Solicitud → Recepción → Evaluación → Resolución → Aplicación →
Evidencia → Cierre), cada una con responsable, plazo (SLA), recordatorio automático y
registro en bitácora (detalle en la tabla de etapas de arriba). Dos bucles:
- **Devolución automática:** "faltan antecedentes → el sistema los pide solo"
  (de Evaluación de vuelta al Estudiante, caso queda en espera).
- **Renovación semestral automática** de adecuaciones, acompañante y accesibilidad
  (del Cierre de vuelta a Solicitud, cada semestre).

### Figura 3.2 — Cómo debe funcionar el ciclo de evidencias
Flujo feliz en 6 pasos: (1) apertura automática del período → (2) cada sede ve qué le
falta y de qué caso → (3) la sede carga la evidencia en el caso → (4) el sistema valida
formato y coherencia → (5) cierre del período y archivo digital → (6) reporte de
cumplimiento por sede.
**Si la sede no carga — el sistema actúa solo, sin que el equipo nacional persiga a nadie:**
recordatorios D-15 / D-7 / D-1 → caso marcado en rojo en su tablero → escalamiento a
Dirección de Sede → alerta a GDI y reporte de incumplimiento.
**Regla de oro: sin evidencia válida cargada, el caso no se cierra.**
