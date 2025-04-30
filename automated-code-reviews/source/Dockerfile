FROM cgr.dev/chainguard/python:latest-dev

COPY requirements.txt .

RUN pip install -r requirements.txt --user

WORKDIR /app

COPY . .

ENTRYPOINT [ "python", "/app/main.py" ]
