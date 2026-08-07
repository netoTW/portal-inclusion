# RF-037 — Solicitud de cuidados (flujo propio)

**Módulo:** cuidados
**Prioridad:** crítica
**Depende de:** motor workflow (proceso seed 2), RF-001..008 (maquinaria de solicitudes), ADR-003 (Ley 21.790)
**Inferencia:** del bloque Cuidados (cap. 7: "solicitudes… con flujo propio") y
módulo 5 del cap. 4 ("flujo propio y configurable"). El Portal de Cuidados atiende
al ESTUDIANTE-CUIDADOR: quien cuida a un tercero (ADR-003, Ley 21.790).

## Descripción
El estudiante que ejerce rol de cuidador solicita medidas de apoyo por un flujo
PROPIO (proceso seed 2 del motor): formulario específico que identifica la situación
de cuidado y a la persona cuidada (datos mínimos), con su propio checklist (RF-038)
y catálogo de medidas (RF-040). Es configuración del motor — la prueba de que el
workflow soporta procesos distintos sin código.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | crear su solicitud de cuidados; consentimiento propio (RF-008) + declaración responsable por el tercero [S-23] |
| Sede (DAE) | gestionar casos de cuidados de su sede — SIN antecedentes del tercero [S-20][S-23] |
| Jefatura de Escuela | ver medidas vigentes de sus estudiantes (no la situación de cuidado) |
| Docente | ver SOLO las medidas que lo involucran (ej. flexibilidad de asistencia) — jamás quién es cuidado ni por qué |
| Secretaría General | resolver/firmar |
| Equipo nacional GDI | todo el proceso |
| Rectoría/Vicerrectorías | agregados |

## Datos que toca
- Entidades: solicitud de cuidados (caso del proceso 2), persona cuidada {relación
  con el estudiante, edad/rango, comuna — MÍNIMOS para evaluar; sin RUT salvo que la
  acreditación lo exija [S-23]}.
- ¿Datos clínicos? SÍ, con doble sensibilidad: la situación de cuidado del
  estudiante Y los datos del tercero. TODO antecedente del proceso vive en
  `clinical` (regla fijada en authz.md, Tanda 0), acceso solo GDI/Secretaría.

## Flujo principal
1. El estudiante elige "Solicitud de cuidados" (tipo del catálogo RF-001, proceso 2).
2. Formulario propio: situación de cuidado, persona cuidada (datos mínimos),
   medidas que necesita; checklist RF-038.
3. Antes de enviar: consentimiento propio (RF-008) + DECLARACIÓN RESPONSABLE sobre
   los antecedentes del tercero [S-23] — explícita, versionada, registrada.
4. Envío → caso con folio (RF-006) al flujo propio: evaluación → resolución →
   medidas → seguimiento (RF-039/040/041).

## Flujos alternos / casos borde
- Estudiante con caso de inclusión Y de cuidados: multi-caso normal (RF-010),
  expedientes separados (procesos distintos, sensibilidades distintas).
- Más de una persona cuidada: una solicitud por situación de cuidado (medidas se
  evalúan por el conjunto — ver dudas).
- El flujo/etapas exactas del proceso de cuidados: CONFIGURACIÓN editable — las
  etapas seed calcan las 7 genéricas con evaluación propia; el real llega con el
  levantamiento (motor lo absorbe sin código).

## Criterios de aceptación
- [ ] CA-1: el proceso seed 2 corre completo (solicitud → resolución → medidas) como
      configuración del motor — cero código específico de cuidados en el workflow
      (verificable por arquitectura de packages).
- [ ] CA-2: el envío exige consentimiento propio + declaración responsable; sin
      ambas → 403 con motivo (patrón RF-008 CA-3).
- [ ] CA-3 (negativo): DAE gestionando el caso NO accede a antecedentes del tercero
      ni del estudiante (solo estado y checklist [S-20]); docente solo ve la medida
      que lo toca, sin contexto (vectores red team dedicados a cuidados).
- [ ] CA-4 (accesibilidad): formulario propio operable por teclado/móvil, lenguaje
      cuidadoso (no burocrático) para una situación sensible; axe 0.

## Propiedades (fuzzing)
- P1: todo caso de cuidados referencia declaración responsable registrada previa al
  envío (espejo del P1 de RF-008).

## Fuera de alcance
- Checklist documental (RF-038), medidas (RF-040), renovación (RF-042).
- Beneficios externos (RSH, cuidados estatales): la plataforma acredita PARA AIEP.

## Dudas abiertas
- ¿Una solicitud por persona cuidada o por situación de cuidado (varias personas)?
  Hoy: por situación.
- Etapas/SLA reales del flujo propio — doc extendido/levantamiento (configuración).
