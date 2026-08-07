# RF-002 — Formularios dinámicos

**Módulo:** solicitudes
**Prioridad:** crítica
**Depende de:** RF-001, workflow.md (formularios JSON Schema), design-system
**Inferencia:** del bloque Solicitudes (cap. 7: "formularios dinámicos con catálogos
controlados") y módulo 1 ("formularios dinámicos por tipo de apoyo… nuevos formularios
sin desarrollo").

## Descripción
El formulario que llena el estudiante se genera desde la definición del tipo elegido
(JSON Schema + hints de UI): campos, secciones, condicionales ("si marcas X, aparece
Y") y cargas documentales. Un formulario nuevo o modificado es configuración de GDI,
jamás desarrollo.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | llenar el formulario de su solicitud; ver ayuda contextual por campo |
| Sede (DAE) | ver las RESPUESTAS no clínicas de casos de su sede |
| Jefatura de Escuela | nada (no ve formularios de solicitud) |
| Docente | nada |
| Secretaría General | ver respuestas al revisar antecedentes (según clinical_gate) |
| Equipo nacional GDI | construir formularios (RF-019), ver todo |
| Rectoría/Vicerrectorías | nada |

## Datos que toca
- Entidades: definición de formulario (versionada con el proceso), respuestas de la
  solicitud.
- ¿Datos clínicos? SÍ: los campos marcados `sensible: true` en el schema (síntomas,
  diagnóstico declarado, tratamiento) se almacenan en el esquema `clinical` y solo se
  sirven vía clinical_gate. El constructor de RF-019 EXIGE clasificar cada campo
  (sensible/no sensible) al crearlo — sin clasificación no se publica.

## Flujo principal
1. El estudiante elige tipo (RF-001) → la plataforma renderiza el formulario desde el
   schema con los componentes del design system (campos con label visible, pasos con
   progreso, validación en línea).
2. Campos condicionales aparecen/desaparecen según respuestas; nada irrelevante se pregunta.
3. Los datos académicos (sede, escuela, carrera) vienen precargados de RF-004 —
   el estudiante NO los digita.
4. Al enviar: validación completa (formato por campo + checklist RF-005) antes de
   crear el caso.

## Flujos alternos / casos borde
- Versionado: una solicitud enviada conserva su versión de formulario; se muestra tal
  como se respondió aunque el formulario haya cambiado después.
- Condicionales que ocultan un campo ya respondido: la respuesta oculta NO se envía
  (se descarta al ocultarse, con aviso).
- Formulario en móvil: usable completo (el estudiante solicita desde el teléfono).

## Criterios de aceptación
- [ ] CA-1: el formulario seed de "Adecuación menor" se renderiza desde su schema con
      condicionales funcionando y validación en línea por campo.
- [ ] CA-2: GDI agrega un campo vía constructor y el formulario del estudiante lo
      muestra sin deploy; la solicitud antigua muestra su versión original.
- [ ] CA-3 (negativo): las respuestas de campos `sensible` no aparecen en ninguna
      respuesta de API para Docente/Jefatura/DAE [S-20]; el intento directo da 403 + audit.
- [ ] CA-4 (accesibilidad): flujo completo del formulario operable solo con teclado,
      errores anunciados (aria-live), labels siempre visibles; axe 0. Textos y ayudas
      en chileno simple.

## Propiedades (fuzzing)
- P1: para cualquier schema válido generado, el render no pierde campos obligatorios
  visibles y el submit valida exactamente lo que el schema declara.
- P2: ningún campo `sensible: true` termina almacenado fuera del esquema clinical.

## Fuera de alcance
- Constructor de formularios (RF-019/RF-020).
- Reglas del checklist documental (RF-005/validacion-documental).

## Dudas abiertas
- ¿Formularios bilingües o solo español? (asumimos solo es-CL).
