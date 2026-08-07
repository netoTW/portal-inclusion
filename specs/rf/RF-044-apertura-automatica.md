# RF-044 — Apertura automática del período

**Módulo:** evidencias
**Prioridad:** crítica
**Depende de:** RF-043, RF-045, comunicaciones
**Inferencia:** de la figura 3.2 (paso 1: "apertura automática del período") y el
principio del cap. 3.2: "el sistema abre el período, avisa, recuerda, escala y valida.
El equipo nacional deja de perseguir a las sedes."

## Descripción
Al llegar la fecha, el período se abre sin intervención: se generan los checklists de
cada caso del alcance (RF-045), cada sede recibe UN aviso claro con su carga ("tienes
N casos con evidencias por acreditar, plazo hasta DD-MM-YYYY") y los tableros quedan
poblados. Nadie escribe correos de inicio de ciclo.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | nada |
| Sede (DAE) | recibir el aviso de apertura con SU carga; ver su tablero poblado (RF-046) |
| Jefatura de Escuela | recibir aviso informativo si el período la involucra (config) |
| Docente | nada |
| Secretaría General | nada |
| Equipo nacional GDI | ver el resultado de la apertura (resumen nacional: casos vinculados por sede) |
| Rectoría/Vicerrectorías | nada |

## Datos que toca
- Entidades: evento de apertura, vínculos caso-período generados, avisos emitidos
  (registro en comunicaciones).
- ¿Datos clínicos? NO — los avisos y checklists refieren folio y tipo de apoyo
  aprobado, jamás diagnóstico.

## Flujo principal
1. Job de apertura (idempotente) detecta período con fecha cumplida → estado abierto.
2. Para cada caso del alcance genera el checklist (RF-045).
3. Emite el aviso de apertura POR SEDE (uno, con el resumen de su carga y deep link al
   tablero — no un correo por caso: la sobrecarga de correos es la barrera nº1).
4. GDI ve el resumen de apertura: períodos abiertos, casos vinculados por sede,
   avisos emitidos.

## Flujos alternos / casos borde
- Job caído en la fecha exacta: la apertura corre al reanudarse (atrasada pero
  completa) y la demora queda alertada a GDI; los plazos D-X se calculan desde la
  fecha PROGRAMADA de cierre, no desde la apertura efectiva.
- Sede sin casos en el alcance: NO recibe aviso (cero ruido).
- Doble ejecución del job: idempotencia total (ni checklists ni avisos duplicados).
- Apertura con casos en estados no acreditables (ej. caso anulado tras aprobarse):
  se excluyen del checklist con registro del motivo.

## Criterios de aceptación
- [ ] CA-1: al cumplirse la fecha del período seed, se abren checklists para todos los
      casos del alcance y cada sede CON carga recibe exactamente un aviso con N
      correcto y deep link funcional.
- [ ] CA-2: correr el job dos veces no duplica nada (test de idempotencia).
- [ ] CA-3 (negativo): el aviso de apertura no contiene datos clínicos ni nombres de
      diagnóstico (test de contenido); sede sin casos no recibe aviso.
- [ ] CA-3b (negativo): el resumen de apertura de DAE muestra solo su sede.
- [ ] CA-4 (accesibilidad): el aviso en plataforma y el tablero poblado cumplen los
      patrones del design system; axe 0.

## Propiedades (fuzzing)
- P1: tras la apertura, todo caso del alcance tiene exactamente un checklist activo o
  una exclusión registrada con motivo.

## Fuera de alcance
- Contenido del checklist (RF-045); recordatorios D-15/D-7/D-1 (RF-053, Tanda 4).

## Dudas abiertas
- ¿El aviso de apertura debe copiar a Dirección de Sede desde el día 1 o solo en
  escalamiento? Hoy: solo DAE en apertura; Dirección aparece al escalar [S-08].
