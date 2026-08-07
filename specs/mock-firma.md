# Mock Firma — proveedor de firma electrónica simulado

**Vive en:** `/mocks/firma` · **Sirve a:** FirmaAdapter (contracts) [S-07] y RF-024.

## Superficie (2 endpoints + panel)
- `POST /firmar` {documento, firmante} → {id_tramite} · `GET /estado/{id}` →
  {pendiente | firmado(constancia) | rechazado(motivo)}.
- Panel fake mínimo: lista de trámites pendientes con botones "firmar"/"rechazar" —
  permite demos realistas del ciclo de RF-024 (Secretaría revisa → firma → efectos)
  y pruebas manuales del flujo de devolución.
- La "constancia" del mock: hash del documento + timestamp + folio de trámite —
  estructuralmente análoga a la real para que RF-024/028 no cambien al conmutar.

## Reglas
- Interfaz del FirmaAdapter en contracts = contrato único; el proveedor real [S-07]
  se integra implementándola (cambio de configuración, no de código de negocio).
- Escenarios simulables por flag: proveedor caído (RF-024 "nunca se firma sin
  proveedor"), latencia alta, rechazo.
- Modo auto-firma (flag SOLO para e2e): firma automática tras N segundos — los e2e
  de flujos largos no requieren click humano; PROHIBIDO en la demo (la demo muestra
  el panel).

## Criterios de aceptación
- [ ] CA-1: ciclo completo RF-024 contra el mock: cola → panel → firmar → constancia
      → efectos disparados; rechazo → devolución con motivo.
- [ ] CA-2: proveedor caído → la cola retiene con alerta, nada se firma ni notifica
      (RF-024 flujo alterno verificado).
- [ ] CA-3: test de contrato de la interfaz FirmaAdapter (mock la implementa
      completa).

## Dudas
- [S-07] Proveedor y tipo de firma reales; subrogancia (dudas ya registradas).
