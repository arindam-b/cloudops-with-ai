FROM cgr.dev/chainguard/python:latest-dev

ENV LANG=C.UTF-8
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PATH="/appli/venv/bin:$PATH"

WORKDIR /appli

RUN python -m venv /appli/venv
COPY . .

RUN pip install --no-cache-dir -r requirements.txt

ENTRYPOINT [ "python", "/appli/app.py" ]