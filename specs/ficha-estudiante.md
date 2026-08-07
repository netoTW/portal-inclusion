# Ficha única del estudiante — vista integradora

**Origen:** módulo 6 del PDF (cap. 4). No tiene rango RF propio en el cap. 7: asumimos
que sus requisitos viven repartidos en los otros bloques y que la ficha es una VISTA
integradora, no un módulo con datos propios [S-02]. Confirmar con el documento extendido.

## Qué exige el PDF (textual, módulo 6)
"Un solo lugar con datos personales, historial de solicitudes, resoluciones,
adecuaciones, medidas, documentos, bitácora, comunicaciones, responsables y estado actual."

## Principio de diseño
- El package `/packages/ficha` NO posee tablas de negocio: COMPONE lo que exponen los
  demás módulos exclusivamente vía /packages/contracts. Cero lógica duplicada.
- Es el punto de máximo riesgo de fuga de datos (junta todo): CADA sección de la ficha
  pasa por authz por separado. La ficha de un mismo estudiante se ve DISTINTA según
  quién mira — es la demostración visible del policy engine.

## La misma ficha, por perfil (recortes autorizados)
| Perfil | Ve en la ficha | Jamás ve |
|---|---|---|
| Estudiante (la suya) | datos personales, historial, resoluciones, medidas, documentos propios, comunicaciones | notas internas de gestión |
| Sede (DAE) | fichas de estudiantes con caso en SU sede: todo lo operativo + antecedentes del caso | fichas de otras sedes |
| Jefatura de Escuela | sus estudiantes: adecuaciones vigentes, resoluciones, tareas pendientes | antecedentes clínicos |
| Docente | sus estudiantes asignados: adecuaciones vigentes y recomendaciones de aplicación | diagnósticos, informes médicos, historial clínico |
| Secretaría General | antecedentes para resolver, resoluciones, estado de procesos | — |
| Equipo nacional GDI | ficha completa | — |
| Rectoría/Vicerrectorías | NADA individual — no existe ruta de ficha para este perfil | cualquier dato identificable |

## Secciones (cada una alimentada por su módulo dueño)
1. Identificación (datos personales + académicos vía BannerAdapter; incluye los DOS
   canales de correo: institucional —origen integración académica— y personal
   —origen: capturado en la primera solicitud o entregado por AIEP—, usados por el
   doble canal de avisos críticos de RF-065)
2. Historial de solicitudes y estado actual de cada caso (solicitudes/workflow; multi-caso)
3. Resoluciones y documentos (documentos; descarga según perfil)
4. Adecuaciones y medidas vigentes, con vigencia semestral (adecuaciones/cuidados)
5. Evidencias del caso y su estado (evidencias)
6. Bitácora del caso (audit — lectura filtrada por perfil)
7. Comunicaciones del caso (comunicaciones)
8. Responsables actuales por etapa (workflow)

## Criterios de aceptación transversales (se detallan en Fase 0)
- [ ] CA-1: la ficha renderiza SOLO las secciones que authz autoriza para el actor;
      no existe variante "campo oculto en el cliente" (el dato no viaja).
- [ ] CA-2 (negativo): docente pide la ficha de un estudiante asignado → la respuesta
      NO contiene ningún campo del esquema clinical; el intento de ampliar via query
      params devuelve 403 + evento en audit.
- [ ] CA-3 (negativo): DAE de sede A pide ficha de estudiante con casos solo en sede B → 404/403.
- [ ] CA-4 (negativo): no existe endpoint de ficha accesible con rol Rectoría.
- [ ] CA-5 (accesibilidad): navegable 100% por teclado, axe sin violaciones.

## Fuera de alcance
- Edición de datos desde la ficha (cada dato se edita en su módulo dueño).
- Datos académicos de progresión (llegan por ProgresionAdapter al módulo reportes).

## Dudas abiertas
- ¿El documento extendido asigna RF específicos a la ficha? (ver DUDAS.md)
