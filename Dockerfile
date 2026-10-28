FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN useradd --system --uid 10001 --no-create-home appuser
USER appuser

EXPOSE 8003

CMD ["gunicorn", "--bind", "0.0.0.0:8003", "--workers", "2", "app:app"]
