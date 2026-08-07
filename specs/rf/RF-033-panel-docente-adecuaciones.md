# RF-033 — Panel del docente: adecuaciones vigentes y recomendaciones

**Módulo:** adecuaciones
**Prioridad:** crítica
**Depende de:** RF-029/030/032, evidencia-eventos (mismo panel), RF-004 (asignaciones)
**Inferencia:** del cap. 8, perfil Docente: "ver sólo a sus estudiantes asignados,
las adecuaciones vigentes y las recomendaciones de aplicación". Es la CARA VISIBLE
de la regla 1 y la vista más usada del sistema (todos los docentes con estudiantes
con apoyo).

## Descripción
El lugar único del docente: por sección, sus estudiantes con adecuaciones VIGENTES,
qué aplicar y cómo (recomendaciones prácticas), sus avisos por acusar (RF-032), sus
evaluaciones y confirmaciones pendientes (evidencia-eventos). Diseñado para el
docente que entra 2 minutos antes de la clase: claridad y cero fricción. Y por
diseño: NADA clínico — jamás.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Docente | TODO su panel: estudiantes asignados, adecuaciones vigentes, recomendaciones, acuses, confirmaciones |
| (los demás perfiles) | no acceden a este panel (cada uno tiene el suyo); GDI puede previsualizarlo "como docente X" para soporte (auditado) |

## Datos que toca
- Entidades: LEE adecuaciones vigentes × asignaciones académicas; no escribe datos
  propios salvo acuses (RF-032) y confirmaciones (evidencia-eventos).
- ¿Datos clínicos? La respuesta del panel se construye con la ALLOWLIST más
  restrictiva del sistema: {estudiante (nombre, carrera), sección, adecuación (tipo,
  condiciones), recomendaciones, fechas}. Ni causa, ni categoría de condición, ni
  documentos, ni historial de solicitudes — el dato no viaja (authz regla 1).

## Flujo principal
1. El docente entra (deep link de aviso o navegación): sus secciones del semestre.
2. Por sección: estudiantes con apoyo, cada uno con sus adecuaciones vigentes y
   recomendaciones aplicables en texto práctico.
3. Pendientes arriba: avisos sin acusar, evaluaciones por confirmar,
   reprogramaciones vivas.
4. Todo cambio de lo vigente se refleja solo (RF-030/032).

## Flujos alternos / casos borde
- Docente sin estudiantes con apoyo: panel con estado vacío informativo (y material
  general de inclusión — contenido de GDI, opcional).
- Estudiante que anula/pierde vigencia: desaparece del panel (con aviso de cese,
  RF-032) — el panel NUNCA muestra apoyos extintos como vigentes.
- Ayudantes/co-docentes: fuera de alcance salvo que Banner los modele — duda.

## Criterios de aceptación
- [ ] CA-1: docente seed con 2 secciones ve exactamente sus estudiantes con apoyo
      vigente y las recomendaciones correctas; los cambios (revocación, renovación)
      se reflejan sin acción del docente.
- [ ] CA-2: pendientes (acuses, confirmaciones) accionables en 1 click desde el panel.
- [ ] CA-3 (negativo — EL test del sistema): la respuesta completa del panel no
      contiene ningún campo fuera de la allowlist (verificación byte a byte);
      todos los vectores docente→clinical del red team corren contra este panel;
      GDI previsualizando queda auditado.
- [ ] CA-4 (accesibilidad): panel completo por teclado, comprensible con lector de
      pantalla, textos en chileno docente (no jerga clínica ni técnica); axe 0.

## Propiedades (fuzzing)
- P1: panel(docente) ⊆ allowlist × sus asignaciones vigentes — para cualquier
  combinación de datos generada (la regla 1 como propiedad).

## Fuera de alcance
- Confirmación de eventos (evidencia-eventos — integrada aquí, especificada allá).
- Material pedagógico general (contenido, no software).

## Dudas abiertas
- ¿Co-docentes/ayudantes ven el panel? (depende del modelo de Banner — levantamiento).
