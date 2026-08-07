# Policy engine (authz) — la única puerta a los datos

**Package:** `/packages/authz` · **Depende de:** contracts · **Lo consumen:** todos.
Implementa la propiedad rectora de `specs/arquitectura.md`: las reglas de acceso son
arquitectura, no features. Se garantizan por construcción y se demuestran por ataque
(`specs/redteam.md`).

## Modelo: ABAC con denegación por defecto
`decide(actor, accion, recurso, contexto) → PERMIT | DENY(motivo)`
- **Actor:** `{usuario_id, rol, sede_id?, escuela_id?, asignaciones[]}`. Rol ∈ los 7
  perfiles EXACTOS de contexto-aiep.md — no existen otros roles. "Dirección de Sede"
  NO es rol: es destinatario de notificaciones sin login [S-08].
- **Acción:** verbos del catálogo de contracts (`ver`, `crear`, `editar`, `transicionar`,
  `cargar_evidencia`, `firmar`, `exportar`, …). Acción no catalogada = DENY.
- **Recurso:** tipo + id + atributos de scoping (`sede_id`, `escuela_id`, `estudiante_id`,
  `es_clinico`, `es_nota_interna`).
- **Contexto:** propósito declarado, etapa del caso, relación actor-recurso.
- **Default DENY:** toda combinación no cubierta por una regla explícita se deniega.
  Toda denegación emite evento a `/packages/audit` con el vector completo del intento.

## La matriz de permisos VIVE EN DATOS
- Editable por GDI desde panel admin (sin deploy), versionada, con bitácora de cambios.
- Tests de congelamiento: la matriz seed se verifica celda por celda contra la tabla
  exacta de perfiles de specs/contexto-aiep.md. Cambiarla rompe el test a propósito:
  obliga a actualizar spec + test en el mismo commit.
- Las 4 reglas "por diseño" NO son editables desde el panel: están codificadas como
  invariantes por encima de la matriz (la matriz puede restringir más, jamás menos).

## Las 4 reglas por diseño (invariantes duras)
1. **Docente → clinical: imposible.** Ninguna configuración de matriz, parámetro de
   query, include/expand o exportación entrega un campo del esquema `clinical` a rol
   Docente. Tampoco diagnósticos "colados" en texto libre de recomendaciones (las
   recomendaciones de aplicación se redactan sin diagnóstico; validación en el módulo
   de adecuaciones).
2. **Jefatura de Escuela → antecedentes clínicos: imposible.** Misma mecánica.
3. **Scoping territorial de Sede (DAE):** el filtro `sede_id = actor.sede_id` se inyecta
   a nivel de REPOSITORIO (query builder), nunca como post-filtro en memoria ni en el
   cliente. No existe código de acceso a casos que omita el scope.
4. **Rectoría/Vicerrectorías:** no existen endpoints de detalle para este rol; solo las
   vistas agregadas del módulo reportes con k-anonimato (ADR-002). El dato identificable
   no viaja jamás en una respuesta para este rol.

## clinical_gate — acceso a datos de salud
- `clinical_gate(actor, recurso, proposito)` es la ÚNICA función que abre el esquema
  `clinical` (FK por id opaco; sin joins directos desde `public`).
- Roles que pueden cruzarla: Equipo GDI, Secretaría General (revisión de antecedentes)
  y el Estudiante sobre sus propios documentos.
- **Sede (DAE): DENY por defecto conservador — y es DECISIÓN nuestra, no dato del PDF**
  [S-20]. El cap. 8 dice que DAE puede "revisar antecedentes" sin prohibirle lo
  clínico (las prohibiciones explícitas son solo para Docente y Jefatura). Pregunta
  ALTA de levantamiento en DUDAS.md. La matriz queda PREPARADA para que un "sí"
  de AIEP sea solo configuración + actualización del test de congelamiento: DAE es
  celda editable de la matriz, NO invariante dura (las invariantes son las 4 reglas).
- **Datos clínicos de TERCEROS (Portal de Cuidados):** los antecedentes del proceso
  de Cuidados pueden contener datos de salud de la persona cuidada — un tercero que
  NO es usuario. Regla desde ya: TODO antecedente del proceso Cuidados vive en el
  esquema `clinical` y cruza el mismo gate con las mismas garantías, sea del
  estudiante o de un tercero. El diseño fino (consentimiento del tercero, marco
  ADR-003) se especifica en specs/modulo-cuidados.md (Tanda 7); duda registrada.
- Todo cruce del gate (también los permitidos) queda en audit con propósito.
- Serializers de API: allowlist explícita de campos POR ROL (nunca blocklist). Un campo
  nuevo en el modelo NO aparece en ninguna respuesta hasta ser agregado a una allowlist.

## Relaciones que habilitan acceso (se resuelven contra datos académicos)
- Docente → estudiantes de sus secciones vigentes (vía BannerAdapter/asignaciones seed).
- Jefatura de Escuela → estudiantes de su escuela (y su sede, si aplica — ver DUDAS.md).
- Estudiante → exclusivamente sus propios casos y documentos (self-only).
- Secretaría General y GDI → alcance nacional.

## Criterios de aceptación (cada uno se convierte en test)
- [ ] CA-1: test de congelamiento pasa celda por celda contra la tabla de contexto-aiep.md.
- [ ] CA-2 (negativo): Docente autenticado intenta leer un campo clinical por todas las
      vías conocidas (endpoint directo, include, filtro, exportación, ficha) → 403 en
      todas + evento en audit por cada intento.
- [ ] CA-3 (negativo): DAE de sede A pide caso de sede B por id directo → 404/403; el
      listado de casos de A jamás contiene ids de B (verificado a nivel SQL emitido).
- [ ] CA-4 (negativo): con rol Rectoría, TODA ruta de detalle responde 403; las rutas
      agregadas nunca devuelven RUT, nombre ni nº de caso.
- [ ] CA-5: acción no catalogada o matriz sin regla aplicable → DENY + audit (default deny).
- [ ] CA-6: editar la matriz desde el panel queda versionado y auditado; un intento de
      relajar una de las 4 invariantes desde el panel es rechazado.

## Propiedades (fuzzing)
- P1: ∀ combinación (actor con rol Docente, recurso con es_clinico=true, acción, contexto):
  decide() = DENY.
- P2: ∀ query de listado ejecutada como DAE: el conjunto resultado ⊆ recursos de su sede.
- P3: decide() es determinista y total: nunca lanza excepción ante entrada arbitraria
  (entrada malformada → DENY, no error 500).

## Fuera de alcance
- Autenticación (vive en IdentityAdapter / sso-m365).
- Agregación y k-anonimato (módulo reportes; authz solo garantiza que Rectoría no
  alcance rutas de detalle).
