FROM python:3.11-slim

WORKDIR /app

RUN pip install psutil prometheus_client

COPY metrics.py .

CMD ["python", "-u", "metrics.py"]
