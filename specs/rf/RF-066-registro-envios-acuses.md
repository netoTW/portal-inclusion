# RF-066 — Registro de envíos y acuses

**Módulo:** comunicaciones
**Prioridad:** crítica
**Depende de:** RF-065, audit
**Inferencia:** EXPLÍCITO: "con registro de envíos y acuses" (cap. 7) / "con
registro de envíos" (cap. 4). Las metas de constancia del cap. 11 (recepción de
sede 100%, aviso a docente 100%) se PRUEBAN con este registro.

## Descripción
Todo aviso emitido queda registrado: qué se envió (plantilla+versión renderizada),
a quién, por qué regla, por qué canales, cuándo se entregó y cuándo se ACUSÓ
(lectura/acción del destinatario). El registro es consultable por caso ("qué se le
comunicó a quién en este caso") y alimenta los indicadores de constancia.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | ver los avisos que ÉL recibió (su historial de notificaciones) |
| Sede (DAE) | registro de comunicaciones de sus casos |
| Jefatura de Escuela | constancias de sus avisos y acuses |
| Docente | sus propios avisos/acuses |
| Secretaría General | consulta |
| Equipo nacional GDI | registro completo; exportación (con registro) |
| Rectoría/Vicerrectorías | % agregados vía reportes |

## Datos que toca
- Entidades: registro de envío (RF-065) + acuse {tipo: visto | accionado, timestamp}.
  Respaldado en audit (una fuente); el contenido renderizado se conserva (qué DECÍA
  el aviso que se envió — valor probatorio).
- ¿Datos clínicos? NO (los avisos no los contienen — RF-064/065).

## Flujo principal
1. Cada entrega (RF-065) inscribe su registro con contenido renderizado y versión.
2. El acuse se captura: apertura en campana = visto; click de acción/atestación =
   accionado (los acuses formales — recibo de sede, aviso docente — son los de
   RF-031/032, que ESTE registro respalda).
3. Vista por caso: línea de comunicaciones integrada al expediente (RF-027) y a la
   historia (RF-018).

## Flujos alternos / casos borde
- Correo entregado sin acuse en plataforma: el registro distingue entregado ≠
  acusado (la meta del 100% se mide sobre acuses reales, no sobre envíos — sin
  maquillaje, coherente con la filosofía de evidencias).
- **CICLO DE REINTENTO DE ACUSES CRÍTICOS:** aviso de clase crítica (RF-063) sin
  acuse en plazo configurable (seed: 5 días hábiles) → recordatorio automático → si
  persiste (seed: +5dh) → TAREA al DAE de la sede del estudiante ("contactar por
  medio alternativo") con registro de gestión visible en su tablero. El silencio del
  destinatario genera GESTIÓN, no un hoyo en la métrica.
- Aviso a destinatario externo (Dirección de Sede): registro de entrega de correo;
  acuse no exigible (sin login [S-08]) — visible como tal.
- Re-envíos/digest: cada entrega física registrada; el aviso lógico enlaza sus
  entregas.

## Criterios de aceptación
- [ ] CA-1: ciclo seed completo → el registro por caso muestra cada comunicación
      con contenido, canales, entrega y acuse; los indicadores de constancia
      (RF-062) cuadran con este registro.
- [ ] CA-2: entregado sin acusar se distingue de acusado; el corpus conservado
      muestra el texto exacto enviado (versión).
- [ ] CA-3 (negativo): un usuario solo ve SU historial; DAE solo su sede; la
      exportación de GDI queda registrada.
- [ ] CA-5 (reintento crítico): aviso crítico sin acuse a los 5dh → recordatorio;
      a los +5dh → tarea al DAE con registro de gestión en su tablero; acusar en
      cualquier punto detiene el ciclo (test con reloj simulado).
- [ ] CA-4 (accesibilidad): historial de notificaciones navegable por teclado;
      axe 0.

## Propiedades (fuzzing)
- P1: todo envío entregado tiene registro con contenido y versión; todo acuse
  referencia un envío entregado (sin acuses fantasmas).

## Fuera de alcance
- La captura del acuse formal de negocio (RF-031/032 — este registro los respalda).

## Dudas abiertas
- Retención del corpus renderizado (se une a la duda de retención de audit.md).
