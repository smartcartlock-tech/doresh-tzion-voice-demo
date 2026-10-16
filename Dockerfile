FROM python:3.11-slim
WORKDIR /app
COPY 1-app8.tgz app.tgz
RUN tar xzf app.tgz && rm app.tgz && pip install --no-cache-dir -r requirements.txt && playwright install --with-deps chromium && mkdir -p live runs tts
ENV PYTHONUNBUFFERED=1
CMD ["python3","server.py"]
