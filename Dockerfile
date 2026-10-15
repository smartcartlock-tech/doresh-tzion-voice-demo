FROM python:3.11-slim
WORKDIR /app
COPY app.tgz .
RUN tar xzf app.tgz && rm app.tgz && pip install --no-cache-dir -r requirements.txt && playwright install --with-deps chromium && mkdir -p live runs tts
RUN sed -i 's/sid=uuid.uuid4().hex\[:8\]; SES\[sid\]/[x.close() for x in list(LV.values())]; LV.clear(); sid=uuid.uuid4().hex[:8]; SES[sid]/' server.py && sed -i "s/p.chromium.launch()/p.chromium.launch(args=['--disable-dev-shm-usage','--disable-gpu'])/" live.py && python3 -m py_compile server.py live.py
ENV PYTHONUNBUFFERED=1
CMD ["python3","server.py"]
