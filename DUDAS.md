# DUDAS — preguntas abiertas para el levantamiento con AIEP

Dos secciones: (1) las preguntas priorizadas para el levantamiento (agosto 2026, cap. 10
del PDF) y (2) el registro corriente donde CUALQUIER agente anota ambigüedades que
encuentre (regla de CLAUDE.md: ante spec ambigua, NO inventar — registrar aquí y seguir
con lo no-ambiguo).

## 1. Preguntas de levantamiento, priorizadas

| Prioridad | Pregunta | Por qué importa | Supuesto vigente |
|---|---|---|---|
| **ALTA** | ¿Quién registra la fecha de aplicación efectiva del ajuste (docente, jefatura, sede)? | Meta cap. 11 = 100% (hoy 0%); define la atestación de 1 click y la vista del docente | [S-04](SUPUESTOS.md) |
| **ALTA** | Flujo real del proceso NEE/Discapacidad Severa (etapas, responsables, plazos) | Es la prueba de parametrización RF-020; 153 casos a migrar | [S-11](SUPUESTOS.md) |
| **ALTA** | Fechas/duración del período de evidencias; ¿nacional o por sede? | Corazón del módulo prioritario (RF-043–062) | [S-13](SUPUESTOS.md) |
| **ALTA** | Sistema académico real ("Banner o equivalente") y APIs disponibles; sistema de progresión/retención/titulación | Resuelve de raíz la calidad de datos (32 variantes de sede) | [S-06](SUPUESTOS.md) |
| **ALTA** | Mecanismo institucional de firma electrónica (proveedor, tipo simple/avanzada, firmantes) | Bloquea el diseño fino de documentos (RF-021–028) | [S-07](SUPUESTOS.md) |
| **ALTA** | ¿El equipo DAE de sede requiere acceso a antecedentes clínicos para gestionar sus casos? | Hoy: DENY conservador en el clinical_gate; un "sí" es solo configuración + test (specs/authz.md) | [S-20](SUPUESTOS.md) |
| **ALTA** | Definición real de "derivación" (bloque Workflow): ¿interconsulta, traspaso de caso, o ambos? | Hoy: interconsulta sin herencia de permisos; campo `tipo` extensible deja el traspaso como agregado sin tocar el motor ([RF-013](specs/rf/RF-013-derivaciones.md)) | — |
| MEDIA | ¿Decisión única por caso o aprobaciones/rechazos parciales? | Asumida decisión única (respaldo: 391/541 binario + complementarias como mecanismo de apoyos adicionales); impacta Adecuaciones RF-029+ ([RF-012](specs/rf/RF-012-estados-transiciones.md)) | — |
| MEDIA | ¿Plazo máximo de espera de antecedentes del estudiante y consecuencia al vencer? | Hoy: solo alerta a GDI, nunca anulación automática ([RF-014](specs/rf/RF-014-solicitud-antecedentes.md)) | — |
| MEDIA | ¿Cómo se maneja el consentimiento de estudiantes menores de 18 (consiente el estudiante, el apoderado, o ambos)? | AIEP tiene matrícula de 16-17 años; la Ley 21.719 trata distinto el consentimiento de menores (marco [ADR-003](docs/decisiones/ADR-003-marco-normativo-ampliado.md)) ([RF-008](specs/rf/RF-008-consentimiento-datos.md)) | [S-14](SUPUESTOS.md) |
| MEDIA | Retiro del consentimiento con casos activos/cerrados: efectos y plazo | NO diseñado por decisión explícita — choca con conservación de expedientes; pregunta jurídica para AIEP ([RF-008](specs/rf/RF-008-consentimiento-datos.md)) | — |
| MEDIA | ¿Pueden solicitar estudiantes SIN matrícula vigente (postulantes, congelados, en proceso de matrícula)? | Hoy: no pueden enviar ([RF-004](specs/rf/RF-004-identificacion-automatica.md)) | — |
| BAJA | Vigencia documental: ¿se evalúa a fecha de envío o de evaluación? | Hoy: envío (regla justa para el estudiante) ([RF-005](specs/rf/RF-005-validacion-documental-ingreso.md)) | — |
| BAJA | Regla de reuso documental entre casos (¿qué tipos lo permiten?) y taxonomía real de condiciones | Reuso configurable por documento; catálogo de condiciones se definirá desde las 41 categorías ([RF-010](specs/rf/RF-010-solicitudes-complementarias.md), [RF-003](specs/rf/RF-003-catalogos-controlados.md)) | — |
| BAJA | Expiración de borradores (hoy: 6 meses, aviso a los 5) | ([RF-007](specs/rf/RF-007-borradores.md)) | — |
| BAJA | Cadenas de escalamiento seed para etapas 3-5 (el PDF solo detalla la de evidencias) | Propuesto: +2dh supervisor directo, +5dh GDI ([RF-017](specs/rf/RF-017-escalamiento.md)) | — |
| BAJA | Agrupación anti-spam de avisos (digest): frecuencia máxima tolerable por usuario | La sobrecarga de correos es la barrera nº1 de las sedes ([RF-016](specs/rf/RF-016-alertas-plazos.md)) | — |
| MEDIA | ¿Quién confirma la renovación semestral? ¿Existe renovación 100% automática? | ~50% de la carga real son renovaciones | [S-05](SUPUESTOS.md) |
| MEDIA | ¿El doc extendido asigna RF a la Ficha única (módulo 6)? | Define si la ficha es solo vista o tiene requisitos propios | [S-02](SUPUESTOS.md) |
| MEDIA | Distinción de los dos cierres (administrativo por Secretaría vs caso por plataforma): confirmar semántica | Modelo de estados del motor | [S-09](SUPUESTOS.md) |
| MEDIA | Alcance/momento/texto del consentimiento de datos | Zona sensible (datos de salud, Ley 21.719 si se valida ADR-003) | [S-10](SUPUESTOS.md) |
| MEDIA | ¿Solape entre los 541 solicitudes / 187 seguimientos / 153 severa? ¿Volumen real a la fecha de migración? | Dimensiona la migración ("541 o más") | [S-12](SUPUESTOS.md) |
| MEDIA | Catálogo real de tipos de apoyo y requisitos documentales por tipo | Alimenta formularios dinámicos y validación documental | [S-15](SUPUESTOS.md), [S-17](SUPUESTOS.md) |
| MEDIA | ¿El reloj SLA se pausa en "espera de antecedentes"? | Semántica del motor de plazos | [S-16](SUPUESTOS.md) |
| MEDIA | ¿Existe alguna excepción institucional a la regla de oro (cerrar caso sin evidencia validada)? Si existe, ¿quién la autoriza y cómo queda registrada? | El motor la implementa como guarda SIN bypass (specs/workflow.md); una excepción no prevista obligaría a rediseño | — |
| MEDIA | Alcance de Jefatura de Escuela: ¿sus estudiantes son los de su escuela a nivel NACIONAL o escuela+sede? | Define el scoping de authz para ese perfil (specs/authz.md) | — |
| MEDIA | Portal de Cuidados: consentimiento y tratamiento de datos de salud de la PERSONA CUIDADA (tercero no-usuario que no puede consentir en la plataforma) bajo el marco de [ADR-003](docs/decisiones/ADR-003-marco-normativo-ampliado.md) | Los antecedentes de Cuidados se tratan como esquema clinical desde ya (specs/authz.md); el diseño fino va en specs/modulo-cuidados.md (Tanda 7) | [S-14](SUPUESTOS.md) |
| MEDIA | Anulación de casos: ¿hasta qué momento puede desistir el estudiante y qué pasa con adecuaciones ya otorgadas al anular un caso post-resolución? | Diseño conservador vigente en specs/workflow.md | [S-19](SUPUESTOS.md) |
| BAJA | ¿Dirección de Sede necesita login o solo recibe notificaciones? | Cadena de escalamiento de evidencias | [S-08](SUPUESTOS.md) |
| BAJA | Formato institucional del número de caso y catálogo oficial de sedes/escuelas | Folio visible en resoluciones y reportes; catálogos base de toda la plataforma | [S-18](SUPUESTOS.md) |
| BAJA | Política de retención y archivado de la bitácora de auditoría | Dimensiona almacenamiento y cumplimiento (specs/audit.md) | — |
| BAJA | ¿Qué "áreas" (además de docentes) reciben el aviso automático de adecuaciones? (módulo 4, cap. 4) | Destinatarios de comunicaciones | — |
| BAJA | Verificar universo de estudiantes (~85.000, cifra pública externa al PDF) | Dimensionamiento de carga | [S-01](SUPUESTOS.md) |
| BAJA | Meses/pico reales de estacionalidad y ventanas de apertura | Planificación de capacidad y períodos | [S-03](SUPUESTOS.md) |
| BAJA | Validar marco normativo ampliado (Leyes 21.790 y 21.719) contra el doc extendido | [ADR-003](docs/decisiones/ADR-003-marco-normativo-ampliado.md) | [S-14](SUPUESTOS.md) |

## 2. Registro corriente de agentes

Formato: `- [fecha] [módulo/spec] — duda concreta (qué dice la spec, qué falta para decidir)`.
GDI de este repo (Pablo) revisa y resuelve: la respuesta se incorpora a la spec o a
SUPUESTOS.md en el mismo commit que la resuelve.

_(vacío — aún no parte la construcción)_
