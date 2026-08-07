# RF-053 — Recordatorios D-15 / D-7 / D-1

**Módulo:** evidencias
**Prioridad:** crítica
**Depende de:** RF-043/044, RF-016 (maquinaria de avisos), comunicaciones
**Inferencia:** EXPLÍCITO en el PDF: "recordatorios D-15/D-7/D-1" (cap. 7) y figura
3.2 ("si la sede no carga… recordatorios D-15/D-7/D-1"). Usa la maquinaria de RF-016
con umbrales de período.

## Descripción
A 15, 7 y 1 día del cierre del período, cada sede CON pendientes recibe un
recordatorio automático con su estado exacto: cuántos casos le faltan, cuáles, y el
link directo a su tablero. La sede al día no recibe nada (cero ruido). El equipo
nacional no escribe ni un correo.
**Alcance por ADR-004:** los D-X del período cubren los ítems DOCUMENTALES y de
ATESTACIÓN pendientes. Los pendientes de EVENTO tienen su propio ciclo en tiempo real
(reloj de gracia post-evaluación, reprogramaciones — specs/evidencia-eventos.md) y NO
esperan al D-15: el recordatorio de un evento sin confirmar le llega al DOCENTE al
vencer su gracia, y a la sede como visibilidad (RF-046).

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | nada |
| Sede (DAE) | recibir sus recordatorios; ver en su tablero cuáles se han emitido |
| Jefatura de Escuela | nada |
| Docente | nada |
| Secretaría General | nada |
| Equipo nacional GDI | configurar los umbrales del período (D-X, editable [RF-061]); ver el registro de emisión nacional |
| Rectoría/Vicerrectorías | nada |

## Datos que toca
- Entidades: configuración de umbrales del período, registro de recordatorios emitidos
  (sede, umbral, contenido resumido, fecha).
- ¿Datos clínicos? NO — folios y conteos, jamás diagnósticos.

## Flujo principal
1. El motor calcula D-15/D-7/D-1 en DÍAS CORRIDOS respecto de la fecha de cierre
   [regla inferida: "D-15" del PDF se lee calendario, no hábil — ver dudas].
2. En cada umbral: un (1) recordatorio POR SEDE con pendientes: N casos, lista corta
   con folios, deep link al tablero filtrado en pendientes.
3. Emisión registrada; visible para GDI ("qué sedes fueron recordadas y cuándo").
4. D-1 sube el tono (asunto y urgencia visual) — la escala de urgencia es del design
   system, no color solamente.

## Flujos alternos / casos borde
- Sede que completa TODO entre D-7 y D-1: no recibe el D-1 (recalculo al emitir).
- Extensión del cierre (RF-043): recalcula los D-X futuros; los ya emitidos no se
  repiten para el mismo umbral (idempotencia por sede-período-umbral).
- Período más corto que 15 días: se emiten solo los umbrales que caben (D-7/D-1), sin
  errores.
- Los recordatorios cesan si el período se cierra excepcionalmente.

## Criterios de aceptación
- [ ] CA-1: con el período seed, en D-15/D-7/D-1 cada sede con pendientes recibe
      exactamente un recordatorio con N correcto; la sede al día no recibe nada.
- [ ] CA-2: doble corrida del job no duplica; extensión de cierre reprograma sin
      re-emitir umbrales pasados.
- [ ] CA-3 (negativo): un recordatorio jamás incluye contenido clínico ni casos de
      otra sede (test de contenido por destinatario).
- [ ] CA-4 (accesibilidad): el recordatorio en plataforma cumple patrones de
      notificación del design system (role=status, legible); axe 0.

## Propiedades (fuzzing)
- P1: emisiones por (sede, período, umbral) ∈ {0,1}; 1 solo si había pendientes al
  momento del umbral.

## Fuera de alcance
- Marcado en rojo (RF-054) y escalamiento (RF-055) — esto es la fase amistosa.
- Plantillas del texto (comunicaciones).

## Dudas abiertas
- ¿D-15 en días corridos (hoy) o hábiles? Menor, pero cambia fechas de emisión.
