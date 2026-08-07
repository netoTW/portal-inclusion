# RF-047 — Carga de evidencias en el caso (modo DOCUMENTAL)

**Módulo:** evidencias
**Prioridad:** crítica
**Depende de:** RF-045, RF-046, StorageAdapter, design-system (componente de carga)
**Alcance por ADR-004:** este RF cubre el modo DOCUMENTAL (residual). Los modos
EVENTO y ATESTACIÓN no cargan archivos: sus ítems se satisfacen con confirmaciones
estructuradas (specs/evidencia-eventos.md).
**Inferencia:** de la figura 3.2 (paso 3: "la sede carga la evidencia en el caso") y
el bloque del cap. 7 ("carga y validación"). Hoy la carga es un correo con adjuntos
cuando el equipo nacional lo pide; esto la vuelve un acto de 30 segundos en el caso.

## Descripción
La sede carga la evidencia directamente en el ítem del checklist del caso: arrastra el
archivo, declara la fecha del registro si no es extraíble, y listo. La carga queda en
el expediente del caso (no en una carpeta paralela), con autor, fecha y hora.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | nada |
| Sede (DAE) | cargar, reemplazar (antes de validada) y anotar evidencias de SUS casos |
| Jefatura de Escuela | nada (ver dudas: ¿carga delegada en escuela?) |
| Docente | nada (ver dudas) |
| Secretaría General | nada |
| Equipo nacional GDI | cargar en cualquier caso (gestión directa — el 6,4% actual; formalizada en RF-058) |
| Rectoría/Vicerrectorías | nada |

## Datos que toca
- Entidades: evidencia {ítem de checklist, archivo (StorageAdapter), fecha del
  registro declarada/extraída, autor de carga, observación opcional}.
- ¿Datos clínicos? Normalmente NO (la evidencia acredita implementación pedagógica:
  registro de evaluación con tiempo extra, acta, pantallazo de plataforma). PERO puede
  contener datos del estudiante → tratamiento como documento del expediente con acceso
  por perfil; si una evidencia contiene información clínica, se marca sensible y cae a
  clinical (mismo mecanismo RF-002/RF-005).

## Flujo principal
1. Desde el tablero (RF-046) o el caso, la sede abre el ítem y carga el archivo
   (componente del design system: arrastrar/seleccionar, progreso, validación en línea).
2. Admisibilidad inmediata (formato/tamaño, RF-048 nivel estructural).
3. Declara fecha del registro si el sistema no la extrae, y opcionalmente una
   observación ("aplicado en las 3 evaluaciones del semestre").
4. El ítem pasa a "cargada" y entra a validación (RF-048/RF-049); todo auditado.

## Flujos alternos / casos borde
- Reemplazo: mientras el ítem no esté validado, la sede puede reemplazar el archivo
  (versiones anteriores quedan en el historial, nada se pierde).
- Una evidencia que acredita VARIOS ítems (un acta que cubre dos apoyos): se carga una
  vez y se vincula a N ítems (sin duplicar archivo).
- Carga fuera de plazo (período cerrado): imposible por la vía normal; existe la
  regularización tardía con marca "fuera de plazo" (afecta métricas de cumplimiento,
  no las maquilla) — la habilita GDI, RF-058/Tanda 4.
- Archivo enorme/conexión de sede lenta: carga reanudable o al menos progreso claro y
  reintento sin perder el formulario.

## Criterios de aceptación
- [ ] CA-1: DAE carga un PDF válido en un ítem → estado "cargada", archivo en el
      expediente del caso vía StorageAdapter, evento en audit con autor y hora.
- [ ] CA-2: reemplazo pre-validación conserva historial de versiones; post-validación
      está bloqueado (el camino es la subsanación, RF-049).
- [ ] CA-3 (negativo): DAE de sede A no puede cargar en casos de sede B (403 + audit);
      descarga directa por URL de storage sin sesión/authz no sirve nada.
- [ ] CA-4 (accesibilidad): flujo completo de carga por teclado, progreso y resultado
      anunciados; axe 0.

## Propiedades (fuzzing)
- P1: toda evidencia pertenece a ≥1 ítem de checklist de un caso del período; no
  existen archivos huérfanos en storage.
- P2: el historial de versiones de un ítem nunca pierde una carga previa.

## Fuera de alcance
- Validación de contenido (RF-048) y estados/subsanación (RF-049).
- Recordatorios por no carga (RF-053, Tanda 4).

## Dudas abiertas
- ¿Escuela/docentes cargan evidencia directamente (etapa 5 los involucra) o SOLO la
  sede (etapa 6 dice Sede DAE)? Hoy: solo DAE + GDI; si el levantamiento suma actores,
  es matriz de permisos, no rediseño.
