# SSO M365 — autenticación institucional real

**Vive en:** IdentityAdapter (contracts) + tenant M365 Developer Program (dev) →
tenant AIEP (prod). Integración cap. 9: "autenticación institucional (SSO), correo,
calendario y gestión de usuarios". Decisión marco: ADR-001 (Entra ID).
**NO se mockea** (specs/arquitectura.md): el tenant dev es real — el SSO es de las
cosas que fallan distinto en real que en mock.

## Diseño
- OIDC contra Entra ID: login institucional → sesión de la plataforma con el usuario
  resuelto (vínculo identidad↔estudiante/funcionario, RF-004).
- El **login dev "actuar como"** (design-system.md) y el SSO real son DOS
  implementaciones del mismo IdentityAdapter: las vistas no cambian; `AUTH_MODE`
  conmuta. El build de producción EXCLUYE el modo dev (design-system CA-4).
- Roles: el rol de plataforma (los 7 perfiles) NO viene del token — se administra en
  la plataforma (GDI asigna, auditado); Entra autentica, authz autoriza. (Grupos de
  Entra como fuente de rol: decisión de levantamiento con TI — de momento no, para
  no acoplar la matriz a un directorio que no controlamos.)
- Correo saliente (RF-065) vía Graph/SMTP del tenant; en dev, el tenant Developer
  (o captura local tipo mailpit para e2e — flag).
- Tarea manual previa (Pablo, ~20 min): crear tenant M365 Developer Program y app
  registration; credenciales por .env (nunca commiteadas).

## Criterios de aceptación
- [ ] CA-1: login SSO real (tenant dev) → sesión correcta con perfil asignado;
      usuario sin rol asignado → pantalla "sin acceso, contacta a GDI" (nunca un
      rol por defecto).
- [ ] CA-2: `AUTH_MODE=dev` ↔ `AUTH_MODE=sso` conmutan sin tocar vistas ni negocio;
      el build prod no contiene el módulo dev.
- [ ] CA-3 (negativo): token válido de Entra SIN usuario de plataforma no accede a
      nada (la autenticación no implica autorización); sesiones expiran según
      config; logout limpia.
- [ ] CA-4: correos de RF-065 salen por el tenant en el entorno que corresponde.

## Dudas
- Política del tenant AIEP: ¿grupos de Entra como fuente de roles? ¿cuentas de
  estudiantes con licencia de correo? ¿vigencia post-egreso? (esta última ya ALTA→
  MEDIA en DUDAS.md, RF-026) — levantamiento con TI.
