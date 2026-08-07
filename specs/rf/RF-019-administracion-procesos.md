# RF-019 — Administración de procesos (panel GDI)

**Módulo:** workflow
**Prioridad:** crítica
**Depende de:** RF-012, RF-015, design-system (wizard admin)
**Inferencia:** del bloque Workflow (cap. 7) y cap. 8 (GDI: "configuración,
parametrización, creación de formularios y flujos"). Es la UI del motor de
specs/workflow.md; RF-020 es su prueba máxima.

## Descripción
El Equipo nacional GDI administra los procesos desde un panel: etapas, transiciones,
formularios (constructor JSON Schema), SLA, avisos, escalamientos, catálogos
documentales y plantillas de documentos — todo sin deploy ni desarrollo. Editar un
proceso es trabajo funcional, no un ticket a TI.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | nada |
| Sede (DAE) | nada |
| Jefatura de Escuela | nada |
| Docente | nada |
| Secretaría General | nada (consulta definiciones vigentes si lo necesita, solo lectura) |
| Equipo nacional GDI | crear, editar, publicar, deshabilitar procesos; TODO el panel |
| Rectoría/Vicerrectorías | nada |

## Datos que toca
- Entidades: definiciones de proceso versionadas (workflow.md), catálogos, config SLA,
  historial de publicaciones.
- ¿Datos clínicos? NO.

## Flujo principal
1. GDI abre el panel → lista de procesos con versión vigente y casos en vuelo por versión.
2. Editar crea un BORRADOR (la versión publicada sigue operando).
3. El wizard guía: etapas → transiciones → formularios por etapa (constructor con
   vista previa del formulario dinámico) → SLA y avisos → escalamientos → documentos
   generables → checklist documental.
4. "Validar" corre la validación de definiciones (workflow.md: inalcanzables,
   transiciones rotas, guardas contra campos inexistentes) con errores señalando el paso.
5. "Publicar" crea la versión nueva: casos nuevos la usan; casos en vuelo conservan la
   suya. Publicación auditada con diff.

## Flujos alternos / casos borde
- Publicación con errores de validación: imposible (botón deshabilitado con motivos).
- Deshabilitar un proceso: no admite casos nuevos; los en vuelo terminan su ciclo.
- Edición concurrente de dos usuarios GDI: control optimista (aviso de conflicto,
  nunca sobrescritura silenciosa).
- DISTINCIÓN DE NIVELES que ningún constructor puede confundir: (a) saltar la guarda
  de evidencia en un CASO concreto es imposible para todo rol, incluido GDI
  (workflow.md, regla de oro); (b) editar la DEFINICIÓN de un proceso no-seed para no
  exigir evidencia es posible, con confirmación explícita y auditada; (c) el proceso
  seed 1 NO admite esa edición — requisito del cliente.

## Criterios de aceptación
- [ ] CA-1: GDI edita el proceso seed (agrega un aviso al 80% en Evaluación), publica,
      y un caso nuevo lo exhibe mientras un caso en vuelo no cambia.
- [ ] CA-2: definición inválida (etapa inalcanzable) no se puede publicar; el error
      indica dónde.
- [ ] CA-3 (negativo): cualquier perfil no-GDI recibe 403 en TODA ruta del panel
      (API y UI) + audit del intento.
- [ ] CA-4 (accesibilidad): el wizard completo (incluido el constructor de formularios)
      es operable 100% por teclado; axe 0. Textos del panel en chileno claro.

## Propiedades (fuzzing)
- P1: publicar nunca deja el sistema con un proceso vigente inválido (toda versión
  publicada pasa la validación).
- P2: para cualquier secuencia de ediciones/publicaciones, los casos en vuelo siempre
  referencian una versión publicada existente e inmutable.

## Fuera de alcance
- Crear un proceso NUEVO completo de punta a punta (RF-020 lo cubre como prueba).
- Edición de la matriz de permisos (panel de authz.md, mismo patrón).
- Plantillas de documentos en sí (RF-021+; aquí solo se asocian).

## Dudas abiertas
- ¿AIEP querrá roles intermedios de administración (editar catálogos sin poder tocar
  flujos)? Hoy: panel completo solo GDI, granularidad fina post-levantamiento.
