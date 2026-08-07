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
| MEDIA | ¿Quién confirma la renovación semestral? ¿Existe renovación 100% automática? | ~50% de la carga real son renovaciones | [S-05](SUPUESTOS.md) |
| MEDIA | ¿El doc extendido asigna RF a la Ficha única (módulo 6)? | Define si la ficha es solo vista o tiene requisitos propios | [S-02](SUPUESTOS.md) |
| MEDIA | Distinción de los dos cierres (administrativo por Secretaría vs caso por plataforma): confirmar semántica | Modelo de estados del motor | [S-09](SUPUESTOS.md) |
| MEDIA | Alcance/momento/texto del consentimiento de datos | Zona sensible (datos de salud, Ley 21.719 si se valida ADR-003) | [S-10](SUPUESTOS.md) |
| MEDIA | ¿Solape entre los 541 solicitudes / 187 seguimientos / 153 severa? ¿Volumen real a la fecha de migración? | Dimensiona la migración ("541 o más") | [S-12](SUPUESTOS.md) |
| MEDIA | Catálogo real de tipos de apoyo y requisitos documentales por tipo | Alimenta formularios dinámicos y validación documental | [S-15](SUPUESTOS.md), [S-17](SUPUESTOS.md) |
| MEDIA | ¿El reloj SLA se pausa en "espera de antecedentes"? | Semántica del motor de plazos | [S-16](SUPUESTOS.md) |
| BAJA | ¿Dirección de Sede necesita login o solo recibe notificaciones? | Cadena de escalamiento de evidencias | [S-08](SUPUESTOS.md) |
| BAJA | ¿Qué "áreas" (además de docentes) reciben el aviso automático de adecuaciones? (módulo 4, cap. 4) | Destinatarios de comunicaciones | — |
| BAJA | Verificar universo de estudiantes (~85.000, cifra pública externa al PDF) | Dimensionamiento de carga | [S-01](SUPUESTOS.md) |
| BAJA | Meses/pico reales de estacionalidad y ventanas de apertura | Planificación de capacidad y períodos | [S-03](SUPUESTOS.md) |
| BAJA | Validar marco normativo ampliado (Leyes 21.790 y 21.719) contra el doc extendido | [ADR-003](docs/decisiones/ADR-003-marco-normativo-ampliado.md) | [S-14](SUPUESTOS.md) |

## 2. Registro corriente de agentes

Formato: `- [fecha] [módulo/spec] — duda concreta (qué dice la spec, qué falta para decidir)`.
GDI de este repo (Pablo) revisa y resuelve: la respuesta se incorpora a la spec o a
SUPUESTOS.md en el mismo commit que la resuelve.

_(vacío — aún no parte la construcción)_
