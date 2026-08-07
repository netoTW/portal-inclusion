# RF-045 — Checklist de evidencias por caso

**Módulo:** evidencias
**Prioridad:** crítica
**Depende de:** RF-043/044, adecuaciones (lo aprobado por caso), catálogo de tipos de evidencia
**Inferencia:** del bloque Evidencias (cap. 7: "checklist por caso") y etapa 6
("entrega el checklist por caso"). La clave del diseño: el checklist se DERIVA de lo
aprobado — es lo que convierte "recibida = la sede declaró algo" en "validada =
coherente con el mecanismo aprobado".

## Descripción
Cada caso del período tiene su checklist generado automáticamente desde las
adecuaciones/medidas APROBADAS en su resolución: por cada apoyo, un ítem según el
**MODO DE EVIDENCIA** que su tipo declara ([ADR-004](../../docs/decisiones/ADR-004-evidencia-por-eventos.md)):
- **EVENTO** (apoyos evaluativos, el grueso): el ítem se satisface con confirmaciones
  de rendición capturadas por el circuito de specs/evidencia-eventos.md.
- **ATESTACIÓN** (material adaptado, accesibilidad, acompañamientos): confirmación
  estructurada del responsable.
- **DOCUMENTAL** (residual): carga y validación de archivo (RF-047/048).
La sede nunca adivina qué acreditar; hoy ese vacío es exactamente por qué "recibida"
no prueba implementación.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | nada (ver dudas: ¿transparencia del estado de acreditación al estudiante?) |
| Sede (DAE) | ver el checklist de SUS casos con ayuda por ítem |
| Jefatura de Escuela | ver estado agregado de checklists de sus estudiantes (sin documentos) |
| Docente | nada |
| Secretaría General | consulta |
| Equipo nacional GDI | ver todos; ajustar un checklist puntual (auditado, con motivo) |
| Rectoría/Vicerrectorías | nada |

## Datos que toca
- Entidades: checklist {caso, período, ítems[]}; ítem {apoyo aprobado de origen,
  MODO (evento|atestación|documental), qué lo satisface según modo (confirmaciones
  esperadas / atestación / tipo de archivo + ventana + formatos), estado (RF-049), ayuda}.
  El CATÁLOGO tipo-de-apoyo → modo + parámetros es configuración de GDI (RF-061,
  editable sin código, mismo patrón que validacion-documental.md).
- ¿Datos clínicos? NO: el checklist habla de apoyos aprobados ("tiempo adicional en
  evaluaciones"), nunca de diagnósticos.

## Flujo principal
1. La apertura (RF-044) genera el checklist: un ítem por apoyo aprobado vigente del
   caso, según el mapeo del catálogo.
2. La sede ve por caso: qué se espera, ejemplo de evidencia aceptable, ventana de
   fechas exigida (la evidencia debe ser DEL semestre del apoyo, no un documento viejo).
3. Los ítems se satisfacen con cargas (RF-047) que pasan la validación (RF-048).

## Flujos alternos / casos borde
- Apoyo aprobado sin mapeo en el catálogo: ítem genérico DOCUMENTAL "constancia de
  implementación" + alerta a GDI para completar el catálogo (nunca silencio).
- Checklist MIXTO (caso con apoyos de distintos modos): normal — cada ítem vive su
  ciclo; el caso acredita cuando todos los obligatorios se satisfacen según SU modo.
- Ítems modo evento con MÚLTIPLES evaluaciones en el semestre: el ítem agrega las
  confirmaciones (cumplido cuando el conjunto exigido por la resolución se satisface).
- Caso multi-apoyo: un ítem por apoyo; el caso acredita cuando TODOS los obligatorios
  están validados.
- Adecuación revocada/anulada a mitad de período: su ítem se cancela con registro.
- GDI ajusta un checklist puntual (caso atípico): agregar/quitar ítem con motivo,
  auditado — la excepción es visible, no silenciosa.

## Criterios de aceptación
- [ ] CA-1: caso seed con 2 apoyos aprobados → checklist con 2 ítems correctos según
      el catálogo, cada uno con tipo, ventana y ayuda.
- [ ] CA-2: apoyo sin mapeo genera ítem genérico + alerta a GDI (test del hueco de
      catálogo).
- [ ] CA-3 (negativo): el checklist visible para Jefatura no incluye documentos ni
      detalle clínico; DAE de otra sede no lo ve (403/404 + audit).
- [ ] CA-4 (accesibilidad): el checklist es una lista semántica con estado por ítem en
      icono+texto, navegable por teclado; axe 0.

## Propiedades (fuzzing)
- P1: todo ítem de checklist referencia un apoyo aprobado vigente del caso (o una
  excepción GDI auditada).
- P2: caso acreditado ⇒ todos los ítems obligatorios en estado validado (RF-049).

## Fuera de alcance
- La carga (RF-047), la validación (RF-048), los estados (RF-049).
- El catálogo de adecuaciones mismo (RF-029+, Tanda 6).

## Dudas abiertas
- ¿El estudiante debería VER que su apoyo fue acreditado (transparencia) o el ciclo es
  puramente institucional? Hoy: institucional; buen candidato a mejora — levantamiento.
- Mapeo real apoyo→evidencia (catálogo): doc extendido / levantamiento [S-21].
