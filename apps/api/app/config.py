"""Configuración por entorno. Todo secreto/parametrizable entra por variables
de entorno o .env (ver .env.example en la raíz); nada hardcodeado."""

from functools import lru_cache

from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    """Valores por defecto = desarrollo local fuera de docker (localhost)."""

    model_config = SettingsConfigDict(env_file=".env", extra="ignore")

    app_env: str = "dev"
    database_url: str = "postgresql+psycopg://portal:portal_dev@localhost:5432/portal"
    redis_url: str = "redis://localhost:6379/0"
    minio_endpoint: str = "http://localhost:9000"
    minio_bucket: str = "portal-documentos"


@lru_cache
def get_settings() -> Settings:
    return Settings()
