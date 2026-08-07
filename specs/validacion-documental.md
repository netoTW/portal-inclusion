# Motor de validación documental y decisión

## Principio
Qué documentos exige cada tipo de solicitud y con qué criterios se evalúa
NO está en el documento breve (vive en el extendido de 37 págs, bajo NDA).
Por lo tanto: se construye el MOTOR; los requisitos son CATÁLOGO editable.

## Catálogo de requisitos por tipo de solicitud (panel GDI, sin código)
Cada tipo de apoyo define su checklist:
{ documento, obligatorio: bool, formatos: [pdf,jpg...], tamaño_max,
  vigencia_max_meses, emisor_esperado, ayuda_al_estudiante }
El formulario dinámico se genera desde este catálogo (RF-001..010).

## Validación en DOS niveles (crítico — no confundirlos)
Nivel 1 — AUTOMÁTICO (admisibilidad): completitud del checklist, formato,
  tamaño, vigencia por fecha. Si falta algo: la plataforma DEVUELVE la solicitud
  pidiendo antecedentes ella sola y deja el caso en espera (RFP, etapa 3).
Nivel 2 — HUMANO (decisión de fondo): el sistema pre-evalúa contra criterios
  configurables y RECOMIENDA ("cumple X,Y — recomendación: aprobar"), pero la
  decisión la toma el Equipo GDI con un click y la resolución la firma
  Secretaría General.
  PROHIBIDO aprobar/rechazar 100% automático: (a) el RFP asigna la evaluación
  a GDI y la firma a Secretaría; (b) decisión automatizada sobre datos de salud
  = zona crítica Ley 21.719. El sistema hace TODO menos decidir.

## Post-decisión (automático de punta a punta — lógica de la demo de Pablo)
click de decisión → genera resolución desde plantilla → FirmaAdapter →
notifica al estudiante con documento firmado → asocia adecuaciones aprobadas
→ dispara etapa de Aplicación (tareas fechadas, avisos a docentes).

## Seed para el experimento (marcar "pendiente validación AIEP" en SUPUESTOS.md)
4-5 tipos plausibles con requisitos verosímiles, ej:
- Adecuación menor: certificado médico/psicológico (≤6 meses), informe de especialista
- Adecuación mayor: + informe psicopedagógico, credencial discapacidad (RND) si aplica
- Cuidados (21.790): certificado del RSH o acreditación de rol de cuidador
- Discapacidad severa: derivación + antecedentes de exploración
Cuando llegue el documento extendido: cargar los reales = editar catálogo, cero código.
