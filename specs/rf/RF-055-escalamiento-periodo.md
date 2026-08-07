# RF-055 — Escalamiento del período de evidencias

**Módulo:** evidencias
**Prioridad:** crítica
**Depende de:** RF-053, RF-054, RF-017 (maquinaria de escalamiento)
**Inferencia:** de la figura 3.2, cadena explícita: "recordatorios → caso en rojo →
escalamiento a Dirección de Sede → alerta a GDI y reporte de incumplimiento". Usa la
maquinaria genérica de RF-017 con la cadena específica del período.

## Descripción
Cuando los recordatorios no bastan, la plataforma sube sola por la cadena: notifica a
la Dirección de la Sede incumplidora [S-08] con el detalle de su pendiente, y alerta
a GDI con el reporte de incumplimiento. Todo automático, todo registrado — "sin que
el equipo nacional persiga a nadie".

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | nada |
| Sede (DAE) | ver que su sede fue escalada (transparencia interna: el DAE sabe qué recibió su Dirección) |
| Jefatura de Escuela | nada |
| Docente | nada |
| Secretaría General | nada |
| Equipo nacional GDI | configurar la cadena (umbrales, destinatarios [RF-061]); recibir alertas; ver el mapa nacional de escalamientos |
| Rectoría/Vicerrectorías | agregado vía reportes |
| (Dirección de Sede) | destinatario de notificación, sin login [S-08]; el contacto lo mantiene GDI |

## Datos que toca
- Entidades: cadena de escalamiento del período (config), eventos de escalamiento
  emitidos, registro de contactos de Dirección por sede (mantenido por GDI, auditado).
- ¿Datos clínicos? NO — el reporte a Dirección lista folios, conteos y plazos.

## Flujo principal
1. Umbral de escalamiento cumplido (config: sede con pendientes tras D-1, cierre con
   incumplidos, O acumulación de incumplimientos de EVENTO en tiempo real — ADR-004:
   ej. "N evaluaciones sin confirmar con gracia vencida en la sede"): se emite la
   notificación a Dirección de Sede con el resumen exacto (N casos, folios,
   antigüedad, qué se espera).
2. Simultáneo o siguiente peldaño: alerta a GDI + el reporte de incumplimiento queda
   generado y archivado (alimenta RF-057).
3. Cada emisión registrada (a quién, qué, cuándo); visible en el caso y en el mapa
   nacional de GDI.

## Flujos alternos / casos borde
- Contacto de Dirección desactualizado/rebotado: alerta a GDI, el peldaño no se pierde
  (reintento tras corrección) — nunca en silencio (patrón RF-017).
- Sede que regulariza tras el escalamiento: el evento queda en la historia; no se
  "borra" el escalamiento ocurrido.
- Arrastrados (RF-054): cada período nuevo re-escala según su antigüedad — el
  escalamiento de un arrastrado referencia su historia completa ("3er período
  consecutivo").
- La cadena es configurable [RF-061] pero SIEMPRE termina en GDI: el último peldaño
  no es editable (nadie puede configurar el sistema para que GDI no se entere).

## Criterios de aceptación
- [ ] CA-1: sede seed con pendientes al umbral → Dirección notificada con resumen
      exacto y GDI alertado con el reporte; ambos eventos registrados y visibles.
- [ ] CA-2: el escalamiento de un caso arrastrado incluye su historia de períodos.
- [ ] CA-3 (negativo): la notificación a Dirección no contiene datos clínicos ni
      permite acceso a la plataforma (sin cuenta [S-08]); DAE de otra sede no ve
      escalamientos ajenos.
- [ ] CA-3b (negativo): intentar configurar la cadena sin peldaño final GDI →
      validación lo rechaza.
- [ ] CA-4 (accesibilidad): el mapa de escalamientos de GDI es tabla semántica
      navegable; axe 0.

## Propiedades (fuzzing)
- P1: peldaños en orden y a lo más una vez por (sede, período, umbral) — hereda P1 de
  RF-017.
- P2: todo escalamiento emitido tiene su reporte de incumplimiento archivado
  correspondiente.

## Fuera de alcance
- El semáforo comparativo (RF-056) y los reportes agregados (RF-057).
- Consecuencias institucionales del escalamiento (fuera del sistema).

## Dudas abiertas
- ¿Escalamiento adicional sobre Dirección de Sede (ej. Vicerrectoría) para arrastres
  largos? Se conecta con el tope de [S-22].
