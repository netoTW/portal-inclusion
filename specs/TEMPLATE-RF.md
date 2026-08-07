# RF-0XX — [Nombre corto del requerimiento]

**Módulo:** [solicitudes | workflow | evidencias | documentos | adecuaciones | cuidados | comunicaciones]
**Prioridad:** [crítica | alta | media]
**Depende de:** [RF-0YY, RF-0ZZ o "—"]

## Descripción
[2-5 líneas: qué hace y para quién. Redactado desde el usuario, no desde la técnica.]

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | [ver/crear/editar/nada] |
| Sede (DAE) | [solo SU sede — scoping territorial] |
| Jefatura de Escuela | [nunca antecedentes clínicos] |
| Docente | [nunca diagnósticos ni informes médicos] |
| Secretaría General | |
| Equipo nacional GDI | [acceso completo] |
| Rectoría/Vicerrectorías | [solo agregados, nunca identificables] |

## Datos que toca
- Entidades: [tablas/entidades]
- ¿Incluye datos clínicos/sensibles? [SÍ → esquema clinical + policy engine | NO]

## Flujo principal
1. ...
2. ...

## Flujos alternos / casos borde conocidos
- ¿Qué pasa si el estudiante congela/se retira a mitad del proceso?
- ¿Qué pasa al vencer el plazo/SLA?
- ¿Renovación semestral aplica? ¿Cómo?
- [otros del documento AIEP]

## Criterios de aceptación (cada uno se convierte en test)
- [ ] CA-1: Dado [contexto], cuando [acción], entonces [resultado verificable]
- [ ] CA-2: ...
- [ ] CA-3 (negativo): Dado un docente autenticado, cuando intenta [acceder al dato clínico X por cualquier vía], entonces recibe 403 y el intento queda en auditoría
- [ ] CA-3b (negativo, si aplica): Sede A no accede a casos de Sede B; Rectoría no llega a datos identificables
- [ ] CA-4 (accesibilidad): el flujo completo es operable solo con teclado y pasa axe sin violaciones

## Propiedades (para fuzzing, si aplica)
- P1: [invariante que nunca puede romperse, ej. "una solicitud tiene exactamente un estado activo"]

## Fuera de alcance de este RF
- [explícito, para que el agente no se expanda]

## Dudas abiertas
- [si hay ambigüedad en el documento fuente, listar acá — NO resolver inventando]
