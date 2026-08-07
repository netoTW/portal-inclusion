# RF-038 — Antecedentes de cuidados (datos de terceros)

**Módulo:** cuidados
**Prioridad:** crítica
**Depende de:** RF-037, RF-005/014 (maquinaria documental), authz (clinical_gate), [S-23]
**Inferencia:** del bloque Cuidados (cap. 7: "antecedentes") y el diseño pendiente
desde Tanda 0: datos de salud de la PERSONA CUIDADA — un tercero que no es usuario y
no puede consentir en la plataforma. ESTA spec materializa [S-23].

## Descripción
El checklist documental del proceso de cuidados acredita la SITUACIÓN DE CUIDADO con
el mínimo indispensable: se prefiere acreditación ADMINISTRATIVA (Registro Social de
Hogares, credencial de discapacidad del tercero, certificado de rol de cuidador —
seed de validacion-documental.md [S-15]) por sobre informes médicos del tercero.
Cuando un documento contiene datos de salud del tercero, entra al régimen más
restringido del sistema: esquema clinical, acceso SOLO GDI/Secretaría con propósito,
y cobertura de la declaración responsable del cuidador.

## Perfiles y permisos
| Perfil | Puede |
|---|---|
| Estudiante | cargar los antecedentes; ver su propio checklist |
| Sede (DAE) | ver ESTADO del checklist (completo/incompleto) — jamás contenido [S-20][S-23] |
| Jefatura de Escuela | nada |
| Docente | nada |
| Secretaría General | ver antecedentes al resolver (clinical_gate, propósito registrado) |
| Equipo nacional GDI | evaluar antecedentes (clinical_gate, propósito registrado); configurar el catálogo documental de cuidados |
| Rectoría/Vicerrectorías | nada |

## Datos que toca
- Entidades: ítems de checklist de cuidados (misma maquinaria RF-005/RF-014),
  documentos del tercero {marca es_de_tercero, cubierto_por_declaración}.
- ¿Datos clínicos? SÍ — el caso más sensible del sistema: datos de salud de una
  persona que NO es usuaria. Reglas [S-23]: (1) minimización en el catálogo — GDI no
  puede agregar al checklist un requisito de informe médico del tercero sin marcar
  justificación (el panel lo exige); (2) todo documento del tercero referenciado a
  la declaración responsable que lo cubre; (3) los derechos del tercero se
  canalizan vía GDI fuera de plataforma (procedimiento documentado en el manual).

## Flujo principal
1. El checklist de cuidados (catálogo propio) lista lo mínimo: acreditación de rol
   + antecedente de la situación según el tipo de medida pedida.
2. Carga con validación de admisibilidad (RF-005: formato/vigencia); documentos con
   datos del tercero quedan marcados y enlazados a la declaración [S-23].
3. Faltantes → devolución automática (RF-014, misma maquinaria).
4. Todo acceso de GDI/Secretaría a estos antecedentes cruza el clinical_gate con
   propósito — la bitácora del caso de cuidados es la más auditada del sistema.

## Flujos alternos / casos borde
- El estudiante sube un informe médico del tercero NO pedido (sobre-aporte): se
  acepta al expediente clínico pero se marca sobre-aportado — y el evaluador puede
  devolverlo/excluirlo (minimización activa, no solo pasiva).
- Tercero que es TAMBIÉN estudiante AIEP (cuidado entre estudiantes): sus datos NO
  se cruzan con su eventual expediente propio — casos estancos (ver dudas).
- Revocación de la declaración responsable por el estudiante: el caso no puede
  seguir evaluándose (queda en espera + GDI decide con el procedimiento jurídico).

## Criterios de aceptación
- [ ] CA-1: checklist seed de cuidados exige acreditación administrativa (RSH/
      credencial/rol) y NO exige informe médico del tercero; agregar uno al catálogo
      exige justificación explícita.
- [ ] CA-2: documento del tercero queda marcado, enlazado a la declaración, y su
      acceso registra propósito en cada apertura.
- [ ] CA-3 (negativo — el más importante de la tanda): DAE/jefatura/docente no
      alcanzan NINGÚN antecedente de cuidados por ninguna vía (batería red team
      dedicada); un tercero-estudiante no ve ni cruza con su propio expediente.
- [ ] CA-4 (accesibilidad): carga y ayuda del checklist accesibles; lenguaje claro
      sobre qué se pide y POR QUÉ (transparencia con el cuidador); axe 0.

## Propiedades (fuzzing)
- P1: todo documento marcado es_de_tercero tiene declaración responsable vigente que
  lo cubre y vive en clinical.
- P2: ningún serializer fuera de GDI/Secretaría emite contenido de antecedentes de
  cuidados (allowlist — extensión de authz P1 al proceso 2).

## Fuera de alcance
- El texto legal de la declaración responsable (jurídica AIEP — placeholder seed
  marcado).
- Evaluación de fondo (RF-039).

## Dudas abiertas
- La MEDIA ya registrada (Tanda 0): validación jurídica del modelo de declaración
  responsable [S-23].
- Cuidado entre estudiantes AIEP: ¿procedimiento especial? Hoy: casos estancos.
