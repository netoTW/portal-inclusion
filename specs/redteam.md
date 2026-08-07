# Red team — las 4 reglas se demuestran por ataque

**Vive en:** `/redteam` · **Depende de:** seed (usuarios y datos), api levantada.
Gate de CI nº5 (specs/arquitectura.md): **0 exfiltraciones** en el set de vectores.
Un PR que serialice un campo clínico fuera del policy engine se rechaza aquí aunque
todos los demás gates estén verdes.

## Qué es una exfiltración (definición operativa del gate)
Una respuesta HTTP (o export/archivo generado) que, para el actor autenticado, contiene:
1. cualquier campo del esquema `clinical` — actor Docente o Jefatura de Escuela;
2. cualquier dato de un caso de otra sede — actor Sede (DAE);
3. cualquier dato identificable (RUT, nombre, nº de caso, combinación re-identificante
   bajo el umbral k de ADR-002) — actor Rectoría/Vicerrectorías;
4. una nota interna de gestión — actor Estudiante.
También cuenta como fallo del gate: una denegación esperada que NO dejó evento en audit.

## Set de vectores congelado (regresión, versionado en /redteam/vectores/)
Organizado por regla atacada. Familias mínimas por regla:
- **IDOR / acceso directo:** ids ajenos secuenciales y adivinados, ids opacos filtrados
  de otras respuestas, casos de otra sede/escuela.
- **Sobre-expansión:** query params `include`/`expand`/`fields` pidiendo relaciones
  clínicas; GraphQL-style over-fetching si existiera; campos extra en filtros.
- **Mass assignment / escritura:** POST/PATCH con campos de más (cambiar sede_id propio,
  rol propio, estudiante_id de un caso).
- **Rutas laterales:** ficha del estudiante, búsqueda global, exportaciones, descargas
  de documentos, bitácora del caso, notificaciones — cada superficie que agrega datos.
- **Re-identificación (regla 4):** combinaciones de filtros del dashboard que produzcan
  celdas n<k; diferencias entre dos consultas agregadas que aíslen a un individuo.
- **Escalada por configuración:** intentar relajar la matriz de permisos vía panel admin
  con rol no-GDI; intentar editar una de las 4 invariantes con rol GDI (debe fallar).
- **Sesión/actor:** tokens de un rol usados contra endpoints de otro; usuario DAE con
  sede_id manipulado en el JWT/perfil.

## Mecánica
1. Levanta el stack con datos seed (usuarios de prueba: 1+ por perfil, DAE de al menos
   2 sedes distintas, docente con y sin estudiantes asignados).
2. Ejecuta el set completo; para cada vector: asserts sobre status, sobre el CUERPO
   (escaneo de campos prohibidos por allowlist inversa) y sobre audit (la denegación
   quedó registrada con el vector).
3. Reporte: vectores ejecutados / bloqueados / exfiltraciones — falla con exit ≠ 0 si
   exfiltraciones > 0 o si falta un evento de audit esperado.

## Agente adversarial (generación de vectores nuevos)
- Periódicamente (y antes de cada hito), un agente LLM con acceso al esquema OpenAPI y
  a los contratos —no al código de authz— genera vectores nuevos por regla.
- Todo vector nuevo que logre una exfiltración se agrega al set congelado (regresión
  permanente) y el hallazgo se registra como BLOQUEO ACTIVO en BITACORA.md.
- Los vectores fallidos interesantes también se congelan (documentan la superficie ya
  explorada).

## Criterios de aceptación
- [ ] CA-1: el runner ejecuta el set completo contra el stack seed y produce reporte
      legible (por regla: ejecutados/bloqueados) con exit code correcto.
- [ ] CA-2: set inicial cubre las 7 familias de vectores para las 4 reglas (mínimo
      40 vectores) y TODOS quedan bloqueados con su evento en audit.
- [ ] CA-3: un endpoint "canario" agregado a propósito que serializa un campo clínico
      sin authz es detectado por el gate (test del test).
- [ ] CA-4: el gate corre en CI en cada PR y bloquea el merge si falla.

## Fuera de alcance
- Seguridad de infraestructura (TLS, headers, rate limiting): checklist aparte en la
  fase de despliegue; este gate ataca AUTORIZACIÓN de datos.
- Pentest de la autenticación M365 (responsabilidad del IdentityAdapter/tenant).
