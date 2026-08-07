# RF-020 — Creación de flujos sin desarrollo

**Módulo:** workflow
**Prioridad:** crítica (es LA prueba de parametrización que exige el RFP)
**Depende de:** RF-019 (y todo el módulo workflow operativo)
**Inferencia:** código y exigencia EXPLÍCITOS en el PDF: "creación de flujos sin
desarrollo" (cap. 7) y "el noveno proceso… debe poder configurarse en la plataforma
como un tercer proceso, sin desarrollo adicional: es la mejor prueba de la
parametrización exigida" (cap. 4).

## Descripción
Un funcionario GDI —no un desarrollador— crea un proceso completamente NUEVO usando
solo el panel de administración y el manual: etapas, formularios, plazos, avisos,
documentos y checklist. El proceso queda operativo de inmediato: recibe casos, transita,
avisa, escala y cierra. Cero deploy, cero código, cero intervención del proveedor.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | usar el proceso nuevo (crear solicitudes) apenas publicado |
| Sede (DAE) | gestionar casos del proceso nuevo en su sede |
| Jefatura de Escuela | según lo configure el proceso |
| Docente | según lo configure el proceso |
| Secretaría General | resolver/firmar si el proceso la incluye |
| Equipo nacional GDI | crear el proceso completo vía UI + manual |
| Rectoría/Vicerrectorías | ver el proceso nuevo aparecer en agregados |

## Datos que toca
- Entidades: las mismas del motor (definiciones, casos) — NINGUNA tabla nueva: si crear
  un proceso requiriera una migración, este RF está FALLADO.
- ¿Datos clínicos? Los que el proceso nuevo configure (sus documentos sensibles caen
  al esquema clinical por el flujo estándar de carga).

## Flujo principal (es también el guion del test de aceptación del sistema)
1. Un agente-funcionario (rol GDI, sin acceso al código ni a la base) recibe el manual
   de administración y la descripción funcional del proceso de Exploración e
   identificación NEE / Discapacidad Severa [S-11].
2. Crea el proceso completo vía RF-019: etapas inferidas del proceso real, formulario
   de derivación, checklist documental, SLA, avisos, resolución generable.
3. Publica. Un estudiante seed crea un caso; el caso recorre el flujo completo con los
   actores correctos hasta cerrar.
4. El proceso aparece en bandejas, ficha, reportes y auditoría como cualquier otro.

## Flujos alternos / casos borde
- El funcionario se equivoca (etapa inalcanzable): la validación de RF-019 lo guía;
  si el manual no alcanza para resolverlo, ESO es un hallazgo (mejorar manual o UI,
  registrar en BITACORA).
- Proceso nuevo que quiere reusar formularios/checklists de otro: duplicar desde
  existente (copy) — sin referencia compartida que acople procesos.

## Criterios de aceptación
- [ ] CA-1 (LA prueba): partiendo de una instalación con los procesos seed, un
      agente-funcionario con SOLO UI + manual deja operativo el proceso Severa y un
      caso lo recorre de punta a punta. Sin commits, sin migraciones, sin tocar código
      (verificado: git diff vacío y esquema de BD sin cambios).
- [ ] CA-2: el tiempo de la creación queda medido y documentado (dato para la
      propuesta: "un proceso nuevo toma X horas de un funcionario").
- [ ] CA-3 (negativo): el proceso nuevo respeta las 4 reglas por diseño sin
      configuración extra (un docente en el proceso nuevo tampoco ve datos clínicos —
      el red team corre sus vectores contra el proceso creado).
- [ ] CA-4 (accesibilidad): el flujo del proceso nuevo hereda los componentes del
      design system → axe 0 sin trabajo adicional (se verifica, no se asume).

## Propiedades (fuzzing)
- P1: cualquier proceso creado vía panel que pase la validación es ejecutable: existe
  al menos un camino de etapa inicial a terminal (se fuzzea con definiciones generadas).

## Fuera de alcance
- El contenido real del proceso Severa (llega con el doc extendido [S-11]; la prueba
  usa las etapas inferidas y se recalibra después — editar configuración, no código).

## Dudas abiertas
- Ver S-11 (flujo real NEE/Severa) y DUDAS.md ALTA correspondiente.
