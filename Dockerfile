FROM python:3.12-slim

WORKDIR /app

RUN groupadd --system appgroup && \
    useradd --system --gid appgroup appuser

COPY app/requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY app/ ./app/

RUN chown -R appuser:appgroup /app

USER appuser

EXPOSE 5000

CMD ["python", "app/main.py"]