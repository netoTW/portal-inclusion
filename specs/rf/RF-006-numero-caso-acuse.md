# RF-006 — Número único de caso y acuse de recibo

**Módulo:** solicitudes
**Prioridad:** crítica
**Depende de:** RF-005, RF-012 (entrada al proceso), comunicaciones (plantilla de acuse)
**Inferencia:** del bloque Solicitudes (cap. 7: "número de caso") y etapa 2 del cap. 6
("genera el número de caso, valida documentos, acusa recibo y asigna responsable —
Inmediato"). Formato de folio [S-18].

## Descripción
Al enviar una solicitud válida, la plataforma crea el caso con número único
(`PIC-AAAA-NNNNN` provisional [S-18]), acusa recibo al estudiante de inmediato y lo
deja en el proceso (Recepción → asignación RF-011). El folio es la referencia de todo:
vistas, documentos, avisos, auditoría y reportes.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | recibir el acuse con folio; ver el folio en todas sus vistas |
| Sede (DAE) | ver folios de su sede |
| Jefatura de Escuela | ver folios de sus casos visibles |
| Docente | ver folios de sus casos visibles |
| Secretaría General | ver folios |
| Equipo nacional GDI | ver todos; buscar por folio |
| Rectoría/Vicerrectorías | NUNCA (el folio identifica → excluido de agregados, ADR-002) |

## Datos que toca
- Entidades: caso (folio, correlativo, año), acuse emitido (registro en comunicaciones).
- ¿Datos clínicos? NO.

## Flujo principal
1. Envío válido (RF-005) → transacción única: crear caso + folio + entrar a Recepción.
2. Acuse inmediato al estudiante: notificación con folio, resumen de lo enviado
   (tipos y documentos, sin contenido), y qué sigue con qué plazo.
3. Recepción ejecuta lo suyo (etapa 2: validación, asignación RF-011) y el caso queda
   visible en la bandeja de la sede.

## Flujos alternos / casos borde
- Concurrencia: dos envíos simultáneos jamás comparten folio (unicidad a nivel de BD,
  no de aplicación).
- Envío duplicado (doble click / reintento de red): idempotencia — un solo caso, un
  solo acuse.
- Falla el envío del correo de acuse: el caso EXISTE igual (el acuse en plataforma es
  el primario; el correo se reintenta y su falla queda alertada — "el correo avisa, el
  trabajo ocurre en la plataforma").
- El folio nunca se recicla, ni siquiera de casos anulados.

## Criterios de aceptación
- [ ] CA-1: envío válido crea caso con folio `PIC-2026-#####`, acuse visible en la
      plataforma y correo registrado; el caso aparece asignado en la bandeja de la
      sede correcta.
- [ ] CA-2: 100 envíos concurrentes → 100 folios únicos y consecutivos sin huecos
      injustificados (test de carrera).
- [ ] CA-3 (negativo): reintento idéntico del mismo envío no crea segundo caso.
- [ ] CA-3b (negativo): ninguna respuesta agregada para Rectoría contiene folios.
- [ ] CA-4 (accesibilidad): pantalla de acuse legible, folio copiable, navegable por
      teclado; axe 0.

## Propiedades (fuzzing)
- P1: folio único global; correlativo estrictamente creciente por año.
- P2: todo caso tiene exactamente un acuse primario registrado.

## Fuera de alcance
- Contenido/plantilla del acuse (comunicaciones).
- La asignación (RF-011) y la validación (RF-005) — aquí se orquestan, no se definen.

## Dudas abiertas
- Formato institucional del folio (¿por sede? ¿por proceso?) — [S-18].
