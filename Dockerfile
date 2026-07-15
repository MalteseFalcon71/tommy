FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    FIRSTDRAFT_HOST=0.0.0.0 \
    FIRSTDRAFT_ACCOUNT_DATABASE=/data/firstdraft-accounts.sqlite3

RUN apt-get update \
    && apt-get install -y --no-install-recommends libreoffice-writer fonts-liberation \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY outputs/requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

COPY outputs/ /app/outputs/
COPY private/ /app/private/
RUN mkdir -p /data

EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=5s --start-period=40s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://127.0.0.1:' + __import__('os').environ.get('PORT', '8000') + '/healthz', timeout=3)" || exit 1

CMD ["python", "outputs/server.py"]
