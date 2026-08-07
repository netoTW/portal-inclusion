# RF-065 — Motor de envío multicanal

**Módulo:** comunicaciones
**Prioridad:** crítica
**Depende de:** RF-063/064, IdentityAdapter (correo M365)
**Inferencia:** del principio del módulo 8: "el correo AVISA; el trabajo ocurre EN
la plataforma". El canal primario es la campana en la plataforma; el correo es el
extensor de alcance.

## Descripción
El motor toma los avisos encolados (RF-063), renderiza la plantilla por canal
(RF-064) y entrega: SIEMPRE a la bandeja en plataforma (RF-067), y por correo según
la regla. Deep links autenticados a la acción exacta (patrón RF-026: nunca
contenido en el correo, siempre el portal). Reintentos, control de fallas y
registro completo (RF-066).

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| (todos) | recibir por sus canales |
| Equipo nacional GDI | ver salud del canal (cola, fallas, rebotes) y reintentar |
| (resto) | nada |

## Datos que toca
- Entidades: envío {aviso, destinatario, canal, estado: encolado → entregado |
  fallido(reintentos) | rebotado, timestamps}.
- ¿Datos clínicos? El CORREO lleva el mínimo (asunto neutro, folio, deep link) —
  el correo es el canal menos controlado (reenvíos, casillas compartidas): ningún
  dato sensible viaja en él, ni siquiera el nombre del tipo de proceso cuando es
  cuidados (coherente con RF-040).

## Flujo principal
1. Aviso encolado → render por canal → entrega en plataforma (inmediata, transaccional)
   + correo (asíncrono con reintentos).
   **DOBLE CANAL de correo para clase crítica:** la ficha modela correo INSTITUCIONAL
   (origen: integración académica) y PERSONAL (origen: capturado en la primera
   solicitud o entregado por AIEP — ficha-estudiante.md). Los críticos se emiten a
   AMBOS cuando existen; el acuse es único (acceso autenticado vía deep link desde
   cualquiera). El test de corpus (canal hostil) aplica idéntico a ambos — ya
   garantizado porque ningún correo porta datos sensibles.
2. Deep link → login (SSO/dev) → aterriza EN la acción (tarea, caso, confirmación).
3. Fallas de correo: reintentos con backoff; rebote → marca al destinatario y alerta
   (patrón RF-016: nunca silencio); la entrega en plataforma NUNCA depende del correo.

## Flujos alternos / casos borde
- Destinatario sin correo válido (Dirección de Sede con contacto caído, RF-055):
  registro + alerta GDI.
- Avalancha (apertura de período): la cola aplana los picos; el orden de entrega
  respeta prioridad (escalamientos antes que informativos).
- Agrupación digest: si la regla es agrupable, el motor difiere y consolida (RF-070).
- Proveedor de correo (M365) caído: la plataforma sigue completa; el correo se
  recupera al volver — el sistema nunca depende del canal de cortesía.

## Criterios de aceptación
- [ ] CA-1: aviso seed llega a la campana al tiro y por correo con deep link que
      aterriza en la acción tras login.
- [ ] CA-2: falla de correo simulada → reintentos, rebote marcado, alerta; la
      campana entregó igual.
- [ ] CA-3 (negativo): corpus de correos emitidos sin ningún dato sensible ni
      clínico (test de contenido — el más importante del módulo); ningún deep link
      sirve contenido sin autenticación.
- [ ] CA-4 (accesibilidad): correos accesibles (RF-064 CA-4); campana según RF-067.

## Propiedades (fuzzing)
- P1: todo aviso emitido queda entregado-en-plataforma exactamente una vez
  (idempotencia bajo reintentos y reinicios de cola).

## Fuera de alcance
- Registro y acuses (RF-066), bandeja (RF-067), digest (RF-070).
- SMS/WhatsApp: no exigidos por el PDF (si el levantamiento los trae, es un canal
  más del motor).

## Dudas abiertas
- **[ALTA en DUDAS.md]** ¿La integración académica entregará el correo personal del
  estudiante y la política institucional de AIEP autoriza usarlo como canal de
  avisos? (pregunta de DATOS y POLÍTICA — el diseño de doble canal ya está resuelto).
