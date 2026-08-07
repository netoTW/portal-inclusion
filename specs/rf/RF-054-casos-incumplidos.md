# RF-054 — Casos incumplidos: marcado en rojo y arrastre entre períodos

**Módulo:** evidencias
**Prioridad:** crítica
**Depende de:** RF-046, RF-051; resuelve el lado fiscalización de la duda transversal [S-22]
**Inferencia:** de la figura 3.2 ("caso marcado en rojo en su tablero") y del cruce
transversal identificado en revisión de Tanda 3: qué pasa con el caso NO acreditado
después del cierre.

## Descripción
Un caso con evidencias vencidas se marca en rojo en el tablero de su sede (anclado
arriba, inconfundible). Con ADR-004, el rojo llega por DOS vías: la documental
(plazos del período vencidos) y la de EVENTOS, EN TIEMPO REAL (evaluación pasada sin
confirmación, reprogramación vencida) — el incumplimiento de evento no espera al
cierre del período para ser visible. Si el período cierra y el caso no acreditó, NO
desaparece: queda "abierto — incumplido", se ARRASTRA al período siguiente con marca
visible y sigue penalizando el semáforo de su sede hasta regularizarse [S-22]. El
incumplimiento no prescribe solo ni se pierde de vista — pero tampoco castiga al
estudiante: su renovación de apoyo NO se bloquea por la deuda administrativa de la
sede (lado vigencias: se confirma en Tanda 6).

**Umbral de instancia institucional (decisión de dirección):** el arrastre tiene un
umbral configurable (seed: 2 períodos [RF-061]). Al superarse, el caso y su sede
encienden en el panel GDI la alerta **"REQUIERE INSTANCIA INSTITUCIONAL FORMAL"**,
con registro de gestión: quién la vio, qué acción tomó, o que sigue sin gestionar —
visible. El sistema NO modela la instancia formal misma (proceso institucional de
AIEP, fuera de alcance): señala, registra y persiste. El valor exacto del umbral y
qué constituye la instancia quedan para AIEP (duda de [S-22]).

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | nada (su apoyo sigue su curso; la deuda es de la sede) |
| Sede (DAE) | ver sus rojos y arrastrados, con antigüedad ("pendiente desde 1°S 2026") |
| Jefatura de Escuela | ver estado agregado de sus estudiantes |
| Docente | nada |
| Secretaría General | consulta |
| Equipo nacional GDI | tablero nacional de incumplidos y arrastrados por sede/antigüedad |
| Rectoría/Vicerrectorías | agregados vía reportes (sin folios) |

## Datos que toca
- Entidades: marca de incumplido {caso, período de origen, arrastres[], antigüedad},
  vínculo caso-arrastrado→período nuevo.
- ¿Datos clínicos? NO.

## Flujo principal
1. Vencido el plazo del caso dentro del período (o al no acreditar al cierre): rojo
   anclado en el tablero de la sede.
2. Cierre sin acreditar (RF-051) → estado "abierto — incumplido" con período de origen.
3. Al abrir el período siguiente (RF-044), los incumplidos se ARRASTRAN: aparecen en
   el tablero nuevo con marca "arrastrado de [período]" ANTES que los casos nuevos.
4. Se regulariza (RF-058) → sale del arrastre; la historia completa queda (períodos
   que estuvo incumplido).

## Flujos alternos / casos borde
- Arrastre múltiple (2+ períodos): la antigüedad escala la visibilidad (GDI ve "sede X:
  3 casos con 2 períodos de arrastre") — ¿tope institucional de arrastre? [S-22, duda].
- Apoyo del caso incumplido que venció su vigencia semestral: la evidencia SIGUE
  debiéndose (acredita la implementación del semestre en que ESTUVO vigente); el
  checklist arrastrado no muta.
- Estudiante egresado/retirado con caso incumplido: la deuda de la sede persiste
  igual (el expediente lo permite); GDI decide regularización o cierre excepcional
  documentado (RF-058).
- Semáforo (RF-056): los arrastrados cuentan CONTRA la sede en cada período en que
  sigan abiertos — el incumplimiento no se diluye cambiando de semestre.

## Criterios de aceptación
- [ ] CA-1: caso sin acreditar al cierre queda incumplido y aparece arrastrado (con
      marca y antigüedad) al abrir el período siguiente, antes que los casos nuevos.
- [ ] CA-2: regularizado, sale del arrastre y su historia de períodos incumplidos
      queda consultable.
- [ ] CA-3 (negativo): el arrastre no altera el checklist original (misma deuda, no
      una nueva); DAE de otra sede no ve arrastrados ajenos.
- [ ] CA-3b (negativo): la renovación del apoyo del estudiante procede aunque el caso
      esté incumplido (test del cruce [S-22] — se re-verifica en Tanda 6).
- [ ] CA-5 (instancia formal): al superar el umbral de arrastre, la alerta "requiere
      instancia institucional formal" aparece en el panel GDI con su registro de
      gestión; un caso alertado sin gestión sigue visible como tal (nunca se apaga
      solo); la gestión registrada (vista, acción) queda auditada.
- [ ] CA-6 (tiempo real): una evaluación pasada sin confirmar (gracia vencida) pone
      el caso en rojo el MISMO día, sin esperar cierres (test con reloj simulado).
- [ ] CA-4 (accesibilidad): el rojo es icono+texto+posición (nunca solo color);
      la antigüedad en texto ("hace 2 períodos"); axe 0.

## Propiedades (fuzzing)
- P1: un caso incumplido está visible en exactamente un tablero vigente (el del
  período actual, como arrastrado) además del histórico — nunca desaparece de la vista.
- P2: incumplido ⇒ no cerrado (consistencia con RF-052/P2).

## Fuera de alcance
- El escalamiento a personas (RF-055) y el semáforo (RF-056).
- El lado vigencias/renovación del cruce (Tanda 6, que debe citar [S-22]).

## Dudas abiertas
- [S-22] ¿Tope institucional de arrastre con escalamiento máximo (ej. 2 períodos →
  instancia formal)? Hoy: arrastre indefinido con visibilidad creciente.
