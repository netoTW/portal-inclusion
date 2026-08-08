#!/usr/bin/env bash
# Arranque de la API en dev: espera la base, migra, carga seed y sirve /docs.
set -euo pipefail

echo "api: esperando a Postgres…"
python - <<'PY'
import time

from sqlalchemy import create_engine, text

from app.config import get_settings

for intento in range(30):
    try:
        with create_engine(get_settings().database_url).connect() as conn:
            conn.execute(text("SELECT 1"))
        break
    except Exception:
        time.sleep(2)
else:
    raise SystemExit("api: Postgres no respondió en 60s")
PY

echo "api: aplicando migraciones…"
alembic upgrade head

echo "api: cargando datos seed…"
python -m app.seed

echo "api: sirviendo en :8000 (/docs para la OpenAPI interactiva)"
exec uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload
