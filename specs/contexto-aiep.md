# Contexto operativo AIEP — datos reales del documento (24.07.2026)

Este archivo existe para que TODO agente dimensione con la realidad, no con supuestos.
Fuente: "Portal de Inclusión y Cuidados — Resumen de requerimientos" (PDF en /docs-fuente).

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
- 541 solicitudes acumuladas (2024: 59 · 2025: 221 · 2026 parcial: 261) — creció 4,4x en 2,5 años
- 153 casos Discapacidad Severa (2025-2026) en planilla paralela → tercer proceso a configurar
- 187 registros de seguimiento de evidencias (ciclo 2024-2025)
- 22,7% son solicitudes COMPLEMENTARIAS de estudiantes con caso ya abierto → multi-caso por estudiante
- 263 renovaciones: ~mitad de la carga es MANTENER VIGENTE lo ya otorgado, cada semestre
- 85,8% adecuaciones menores
- Estacionalidad: pico fuerte al inicio de cada semestre (marzo/agosto)
- Escala usuarios: 25 sedes, 7 escuelas, ~85.000 estudiantes potenciales

## Estado de la trazabilidad hoy (calibración del generador de datos sucios)
- 45,8% tiene fecha de resolución registrada
- 9,6% confirmación de recepción de sede
- 6,7% constancia de aviso al docente
- 0% fecha de aplicación efectiva del ajuste
- 32 variantes de nombre para 25 sedes · 16 variantes para 7 escuelas
- 41 categorías de "causa principal" en TEXTO LIBRE
El generador de /packages/seed DEBE reproducir estas proporciones y suciedades.

## Evidencias 2024-2025 (el dolor central)
- 73,3% "recibida" (= la sede DECLARÓ enviar algo; sin validación de formato/fecha/coherencia)
- 20,3% pendiente sin ningún antecedente · 6,4% gestión directa del equipo nacional
- Dispersión brutal: 12 sedes al 100%, Viña del Mar 7,7%, Valparaíso 42,9%, Online 64%, Temuco 0%
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
Renovación semestral automática de adecuaciones vigentes.

## Evidencias — mecánica exigida (RF-043 a RF-062, el bloque MÁS GRANDE: 20 RF)
Apertura automática de período · checklist por caso · carga y validación · estados ·
recordatorios D-15 / D-7 / D-1 · escalamiento · semáforo por sede · BLOQUEO de cierre
sin evidencia · histórico · exportación para auditoría.

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
4. Rectoría jamás llega a datos identificables (solo agregación; k-anonimato en dashboards)

## Los 8 módulos y sus rangos RF (para specs y cola)
| Módulo | RF | Nota |
|---|---|---|
| Solicitudes | RF-001–010 | formularios dinámicos, catálogos controlados, borradores, consentimiento, NUEVOS FORMULARIOS SIN DESARROLLO |
| Workflow | RF-011–020 | motor configurable, SLA, escalamiento, CREACIÓN DE FLUJOS SIN DESARROLLO (RF-020) |
| Documentos | RF-021–028 | resoluciones/cartas automáticas, versionamiento, firma electrónica, expediente |
| Adecuaciones | RF-029–036 | vigencia semestral, aviso a docentes, renovación, IMPEDIR adecuaciones no aprobadas |
| Cuidados | RF-037–042 | flujo propio configurable (reusar motor Ley 21.790 de Pablo) |
| Evidencias | RF-043–062 | PRIORITARIO y el más grande (20 RF) |
| Comunicaciones | RF-063–070 | plantillas administrables por equipo funcional; "el correo avisa, el trabajo ocurre en la plataforma" |

## Los TRES procesos del motor (prueba de parametrización)
1. Solicitudes de apoyo (regular) — el principal
2. Portal de Cuidados — flujo propio
3. Exploración e identificación NEE / Discapacidad Severa (153 casos) — DEBE configurarse
   sin desarrollo adicional: "es la mejor prueba de la parametrización exigida".
   → El test RF-020: un agente-funcionario lo crea usando SOLO la UI de admin + manual.

## Métricas de éxito del cliente (cap. 11) → convertir en tests e2e del sistema
- Evidencia cargada y VALIDADA ≥ 95% (hoy 78,3% solo declarada)
- 0 sedes bajo 70% de cumplimiento (hoy 5)
- Confirmación de recepción de sede: 100% (hoy 9,6%)
- Constancia de aviso al docente: 100% (hoy 6,7%)
- Fecha de aplicación registrada: 100% (hoy 0%)
- Tiempo de resolución medible: 100% (hoy 45,8%)
- Recordatorios manuales del equipo nacional: 0 (hoy todos)
- Reporte institucional: en línea (hoy días de trabajo manual)

## Lo que pidieron las sedes (UX no negociable)
La sobrecarga de correos es LA barrera nº1. Quieren: notificaciones automáticas de cambio
de estado + espacio de comunicación DENTRO del sistema. Diseñar minimizando fricción:
las atestaciones críticas (ej. docente confirma aplicación) deben resolverse en segundos.

## Estructura de la propuesta que el sistema debe poder alimentar (cap. 12)
Matriz RF-001–070 respondida (nativo/configurable/desarrollo/no cubierto), prototipos,
arquitectura, integraciones con supuestos, cronograma a enero, migración, valor agregado
(constructor de formularios y flujos, alertas inteligentes, indicadores predictivos, API abierta).
