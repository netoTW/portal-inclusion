# API en dev. Contexto de build = raíz del repo (ver docker-compose.yml):
# la API orquesta módulos de /packages, que se montan en /srv/packages.
FROM python:3.12-slim

WORKDIR /srv/api

COPY apps/api/pyproject.toml ./pyproject.toml
COPY apps/api/app ./app
RUN pip install --no-cache-dir -e .

COPY apps/api/alembic.ini ./alembic.ini
COPY apps/api/alembic ./alembic
COPY apps/api/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 8000
ENTRYPOINT ["docker-entrypoint.sh"]
