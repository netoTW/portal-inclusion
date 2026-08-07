# Migración — pipeline contra los 881 registros sucios

**Vive en:** `/packages/migracion` (herramienta, no módulo de producción permanente).
Cap. 10 del PDF: migrar 541 solicitudes "o más" + 153 severa + 187 seguimientos de
evidencia + documentación asociada [S-12], con normalización previa (32 variantes de
sede, 16 de escuela, 41 categorías libres, trazabilidad vacía). El banco de pruebas
es el generador sucio de specs/seed.md (Producto B): el pipeline se construye y se
MIDE contra él antes de ver un dato real.

## Diseño del pipeline (por etapas, re-ejecutable e idempotente)
1. **Ingesta:** lee los formatos de origen (CSV/XLSX estilo planilla); staging crudo
   inmutable (lo recibido se conserva tal cual — auditoría de la migración).
2. **Normalización automática:** sedes/escuelas contra los catálogos espejo [S-18]
   (fuzzy match + tabla de alias); categorías libres contra el catálogo de
   condiciones vía la HERRAMIENTA DE FUSIÓN de RF-003 (dependencia declarada: se usa,
   no se duplica); fechas y RUT (validación DV).
3. **Cola de decisión humana:** todo lo no resuelto automáticamente (alias ambiguo,
   categoría irreducible, RUT inválido) va a una cola de revisión GDI con la misma UX
   de decisión 1-click — NADA se descarta ni se adivina en silencio.
4. **Carga:** casos históricos al esquema real: proceso correspondiente (incluido
   Severa YA CONFIGURADO por UI — rf020-proceso-severa.md), expedientes retroactivos
   (RF-027), historial de apoyos con marca pre-plataforma (RF-035), ciclo de
   evidencias 2024-25 como histórico (RF-059), huecos de trazabilidad VISIBLES
   ("sin registro histórico" — RF-035/036: nunca se inventa ni normaliza como pleno).
5. **Verificación:** conteos y proporciones contra el origen (los totales cuadran o
   la migración FALLA); reporte de cierre (qué entró, qué quedó en cola, qué % fue
   automático).

## La métrica del pipeline
**% auto-resuelto** contra el banco calibrado (tareas.md): objetivo de diseño ≥90%
de los 881 sin intervención humana; el resto en cola de decisión con esfuerzo
medido. El número real (con datos reales, bajo NDA, en dic-2026) alimenta la
estimación de la fase de migración del cap. 10.

## Reglas
- Idempotente y re-ejecutable: correr dos veces no duplica (clave natural por
  registro de origen); una corrida fallida se revierte completa.
- Los datos reales NUNCA entran al repo ni al seed (NDA); el pipeline se desarrolla
  100% contra el banco sintético.
- Todo lo migrado queda auditado como tal (actor "migración", lote, fecha).

## Criterios de aceptación
- [ ] CA-1: pipeline completo contra los 881 sintéticos: totales cuadran, %
      auto-resuelto medido y reportado, cola de decisión operable.
- [ ] CA-2: doble corrida no duplica; corrida interrumpida revierte.
- [ ] CA-3: los migrados aparecen correctos en ficha, expediente, historial e
      histórico de evidencias (línea base RF-059 CA-2 y RF-062 CA-1: los
      indicadores reproducen las cifras del PDF).
- [ ] CA-4: huecos de trazabilidad visibles como tales en todas las vistas (nunca
      datos inventados).

## Dudas
- [S-12] Solape entre fuentes y volumen real a la fecha de corte de migración.
- Formatos reales de las planillas de origen (llegan bajo NDA — el banco sintético
  se recalibra al verlas).
