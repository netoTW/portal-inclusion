# RF-014 — Solicitud automática de antecedentes

**Módulo:** workflow
**Prioridad:** crítica
**Depende de:** RF-012, validacion-documental, comunicaciones (plantillas)
**Inferencia:** del bloque Workflow (cap. 7: "solicitud automática de antecedentes"),
etapa 3 del PDF ("si faltan antecedentes, los solicita sola al estudiante y deja el
caso en espera") y figura 2 ("faltan antecedentes → el sistema los pide solo").

## Descripción
Cuando la evaluación detecta antecedentes faltantes (por validación automática de
admisibilidad o marcados por GDI), la plataforma se los pide SOLA al estudiante con la
lista exacta de lo que falta, deja el caso "en espera" y lo reactiva al recibir la
respuesta. El equipo nacional no escribe correos de "falta tu certificado".

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | ver QUÉ le falta (lista clara con ayuda), subir los documentos, ver el plazo |
| Sede (DAE) | ver que el caso de su sede está en espera y desde cuándo |
| Jefatura de Escuela | nada (etapa de evaluación no es suya) |
| Docente | nada |
| Secretaría General | ver estado en espera de casos que le llegarán |
| Equipo nacional GDI | marcar faltantes manualmente, ver/gestionar todos los en-espera, reactivar |
| Rectoría/Vicerrectorías | nada |

## Datos que toca
- Entidades: solicitud de antecedentes (caso, ítems faltantes del checklist, plazo,
  estado), sub-estado en_espera del caso, pausas de reloj SLA.
- ¿Datos clínicos? SÍ tangencialmente: los documentos que el estudiante sube pueden ser
  informes médicos → van DIRECTO al esquema clinical vía el flujo de carga documental
  (nunca quedan en tablas public). La lista de faltantes usa los NOMBRES del catálogo
  de requisitos, no contenido clínico.

## Flujo principal
1. Nivel 1 automático (admisibilidad, validacion-documental.md) detecta faltantes al
   recibir la solicitud, O el evaluador GDI marca faltantes en la evaluación (nivel 2).
2. La plataforma genera la solicitud de antecedentes con la lista exacta (documento,
   por qué, formato aceptado, ayuda), notifica al estudiante y deja el caso en_espera.
3. El reloj SLA del responsable se pausa según configuración [S-16]; audit registra.
4. El estudiante sube lo pedido desde su vista; la plataforma valida admisibilidad
   (formato/tamaño/vigencia) en línea.
5. Completa la lista → el caso se reactiva solo, vuelve a Evaluación, notifica al
   responsable y reanuda el reloj.

## Flujos alternos / casos borde
- Respuesta parcial: el caso sigue en espera; la vista del estudiante muestra qué falta aún.
- Sin respuesta: recordatorios configurables al estudiante; ¿vencimiento con anulación
  por abandono? NO decidido — ver dudas (hoy: nunca se anula solo, GDI decide).
- Documento subido inválido (vencido/ilegible por formato): rechazo en línea con motivo
  claro; no cuenta como recibido.
- Iteraciones múltiples: GDI puede pedir antecedentes más de una vez; cada ciclo queda
  en la historia.

## Criterios de aceptación
- [ ] CA-1: solicitud con checklist incompleto → el estudiante recibe la lista exacta
      de faltantes y el caso queda en_espera con reloj pausado [S-16], todo auditado.
- [ ] CA-2: al completar el último faltante, el caso se reactiva sin intervención,
      notifica al evaluador y reanuda el reloj.
- [ ] CA-3 (negativo): docente/Jefatura no ven la lista de antecedentes pedidos ni los
      documentos subidos (403 + audit); DAE de otra sede tampoco.
- [ ] CA-4 (accesibilidad): la vista "te falta esto" del estudiante es operable por
      teclado, con errores de carga anunciados; axe 0. Redacción en chileno simple.

## Propiedades (fuzzing)
- P1: un caso en_espera tiene ≥1 ítem faltante abierto; sin ítems abiertos, no puede
  estar en_espera.

## Fuera de alcance
- Definición de checklists por tipo (catálogo de validacion-documental.md).
- Plantillas del mensaje (comunicaciones).

## Dudas abiertas
- ¿Plazo máximo de espera y consecuencia al vencer (anulación por abandono, alerta a
  GDI, nada)? Hoy: solo alerta a GDI, nunca anulación automática.
