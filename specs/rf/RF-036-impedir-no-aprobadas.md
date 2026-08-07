# RF-036 — Impedir adecuaciones distintas a las aprobadas

**Módulo:** adecuaciones
**Prioridad:** crítica
**Depende de:** RF-029, RF-045/048 (coherencia de evidencias), RF-033
**Inferencia:** EXPLÍCITO en el módulo 4 del cap. 4: "impedir adecuaciones distintas
a las aprobadas". Es la contracara de la regla de oro: no solo que lo aprobado se
implemente — que NADA no aprobado se implemente como si lo fuera.

## Descripción
El sistema hace imposible registrar, comunicar o acreditar una adecuación que no esté
en una resolución firmada: los paneles muestran SOLO lo aprobado vigente; los avisos
solo comunican lo aprobado; el checklist de evidencias solo acepta acreditación
coherente con lo aprobado (RF-048); y no existe vía para "agregar un ajuste" fuera
del proceso (evaluación → resolución → firma). Lo informal podrá ocurrir en la sala,
pero el SISTEMA nunca lo respalda ni lo registra como aprobado.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| (todos) | NADIE tiene una acción "crear adecuación" fuera del flujo resolución (RF-029) — este RF es la AUSENCIA verificada de esa vía |
| Equipo nacional GDI | corregir errores materiales vía RF-029 (auditado); lo demás, por resolución |

## Datos que toca
- Entidades: ninguna nueva — este RF son INVARIANTES sobre RF-029/032/033/045/048.
- ¿Datos clínicos? NO.

## Flujo principal (como invariantes verificables)
1. Materialización única: adecuaciones nacen SOLO de resoluciones firmadas (RF-029 P1).
2. Comunicación fiel: aviso a docente (RF-032) y panel (RF-033) muestran exactamente
   el conjunto aprobado vigente — ni más, ni menos, ni "sugerencias" no resueltas.
3. Acreditación coherente: la validación de evidencias rechaza acreditar un ajuste
   no aprobado (RF-048, dimensión coherencia; modo evento: el cruce solo acepta
   confirmaciones de apoyos aprobados del estudiante en esa sección).
4. Sin puerta trasera: no existe endpoint/acción de creación directa; la corrección
   material de GDI no puede AGREGAR apoyos (solo corregir datos del registro
   existente, con diff auditado).

## Flujos alternos / casos borde
- Docente aplica informalmente algo no aprobado y quiere "dejarlo registrado": el
  canal correcto es sugerir una solicitud complementaria (RF-010) — el panel ofrece
  ese camino, nunca un registro directo.
- Urgencias (estudiante necesita ajuste YA): el proceso es la vía rápida configurada
  (SLA cortos), no un bypass — si el levantamiento revela necesidad de "medida
  provisoria", se diseña como figura del proceso (duda).
- Datos migrados con apoyos sin resolución de respaldo (trazabilidad histórica
  rota): se migran marcados "histórico sin resolución asociada" — visibles, nunca
  normalizados como aprobados plenos.

## Criterios de aceptación
- [ ] CA-1: no existe ruta (UI ni API) que cree una adecuación sin resolución
      firmada — barrido de endpoints + intento directo → 403/405 + audit.
- [ ] CA-2: corrección material de GDI no puede agregar un apoyo nuevo (validación
      lo rechaza); el diff de corrección queda auditado.
- [ ] CA-3 (negativo): confirmación de evento sobre apoyo no aprobado → rechazada por
      el cruce (RF-048/evidencia-eventos); evidencia documental de ajuste no aprobado
      → incoherente (observada).
- [ ] CA-4 (accesibilidad): el camino "sugerir solicitud complementaria" desde el
      panel docente es accesible y claro; axe 0.

## Propiedades (fuzzing — este RF es esencialmente propiedades)
- P1 (= RF-029 P1 reforzada): ∀ adecuación en cualquier vista/aviso/checklist:
  ∃ resolución firmada que la contiene, vigente al momento mostrado.
- P2: el conjunto mostrado a un docente = exactamente el conjunto aprobado vigente
  de sus asignados (ni subconjunto ni superconjunto — fidelidad bidireccional).

## Fuera de alcance
- Sanciones/gestión del incumplimiento humano (institucional, fuera del sistema).
- La figura de "medida provisoria" (no existe en el PDF; solo si el levantamiento
  la trae).

## Dudas abiertas
- ¿Necesita AIEP una "medida provisoria" de urgencia pre-resolución? Hoy NO existe
  — el bypass sería contradictorio con este RF; si se necesita, se diseña como
  proceso con SLA corto.
