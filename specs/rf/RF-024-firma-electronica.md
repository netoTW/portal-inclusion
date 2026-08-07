# RF-024 — Firma electrónica

**Módulo:** documentos
**Prioridad:** crítica
**Depende de:** RF-022/023, contracts (FirmaAdapter) [S-07]
**Inferencia:** del bloque Documentos (cap. 7 y módulo 3: "firma electrónica"),
etapa 4 (GDI y Secretaría General firman la resolución) y cap. 9 ("firmar
resoluciones y documentos con el mecanismo institucional vigente").

## Descripción
Los documentos que lo exigen pasan por un flujo de firma electrónica: cola del
firmante (Secretaría General para resoluciones), firma vía el mecanismo institucional
(FirmaAdapter conmutable [S-07]: mock en dev, proveedor real en prod), y documento
firmado inmutable con su constancia. La firma es el acto que da efectos: notificación
al estudiante y apertura de Aplicación ocurren SOLO con el documento firmado.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | ver la constancia de firma en su documento descargado |
| Sede (DAE) | ver estado de firma de documentos de sus casos |
| Jefatura de Escuela | nada |
| Docente | nada |
| Secretaría General | SU cola de firma: revisar documento, firmar, devolver con observaciones |
| Equipo nacional GDI | ver colas y estados; configurar qué tipos exigen firma y quién firma; NO firmar por otros |
| Rectoría/Vicerrectorías | nada |

## Datos que toca
- Entidades: solicitud de firma {documento+versión, firmante requerido, estado:
  pendiente → firmada | devuelta, constancia del proveedor, timestamps}.
- ¿Datos clínicos? NO (los documentos ya nacen sin contenido clínico, RF-021).

## Flujo principal
1. Documento generado con requiere_firma → entra a la cola del firmante con su plazo
   (dentro del SLA de la etapa 4: 5dh).
2. Secretaría revisa el documento en pantalla; firma (FirmaAdapter) o devuelve con
   observaciones (→ GDI corrige/regenera, RF-022, y vuelve a la cola).
3. Firmado: el documento queda INMUTABLE con constancia verificable; se disparan los
   efectos (notificación con documento, etapa siguiente).
4. Todo firmado/devuelto en audit; la cola alimenta los avisos de plazo (RF-016).

## Flujos alternos / casos borde
- Proveedor de firma caído: la cola retiene con reintentos y alerta; NUNCA se
  "firma sin proveedor" ni se notifica un documento no firmado.
- Firmante ausente (vacaciones): configuración de subrogancia — quién subroga es
  pregunta de levantamiento; el mecanismo (firmante alterno configurado por GDI,
  auditado) queda construido.
- Firma masiva: Secretaría puede firmar un lote tras revisar (N resoluciones del
  día), con confirmación explícita del lote — la revisión no se salta, se agiliza.
- Verificación externa: cualquier receptor del PDF puede verificar la constancia
  (según el mecanismo del proveedor real; el mock la simula).

## Criterios de aceptación
- [ ] CA-1: resolución seed → cola de Secretaría → firma (mock) → documento inmutable
      con constancia; recién ahí se notifica al estudiante y abre Aplicación.
- [ ] CA-2: devolución con observaciones regresa a GDI, la corrección re-entra a la
      cola como versión nueva; la trazabilidad del ciclo completo queda en audit.
- [ ] CA-3 (negativo): nadie distinto del firmante requerido puede firmar (ni GDI:
      403 + audit); un documento pendiente de firma no es descargable por el
      estudiante ni dispara efectos.
- [ ] CA-4 (accesibilidad): la cola de firma y la vista de revisión son operables por
      teclado (lote incluido); axe 0.

## Propiedades (fuzzing)
- P1: documento firmado ⇒ inmutable para siempre (ningún evento posterior altera
  contenido ni constancia).
- P2: efectos (notificación, etapa) ocurren si y solo si el documento está firmado.

## Fuera de alcance
- El proveedor real y su integración (specs/mock-firma.md ahora; adapter real en
  despliegue [S-07]).
- Firma del estudiante u otros actores (no exigida por el PDF; si aparece en el doc
  extendido, es config de firmante).

## Dudas abiertas
- [S-07] Mecanismo/proveedor institucional, tipo de firma (simple/avanzada) y
  ¿quién subroga a Secretaría General?
