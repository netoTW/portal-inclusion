"""Portal de Inclusión y Cuidados — API.

Capa de orquestación HTTP (FastAPI). No contiene lógica de negocio: los
módulos funcionales viven en /packages y se montan aquí como routers a medida
que cada tarea de la cola los construye. El scaffold entrega la app operativa
con OpenAPI interactiva (/docs), health checks, configuración por entorno,
conexión a Postgres/Redis y migraciones Alembic (esquemas public + clinical).
"""

__version__ = "0.1.0"
