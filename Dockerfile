FROM python:3.8-alpine as build
WORKDIR /app
COPY requirements.txt .
RUN apk --no-cache --update add build-base
RUN pip wheel -r requirements.txt -w /wheels

FROM python:3.8-alpine
WORKDIR /app
COPY --from=build /wheels /wheels
COPY --from=build /app/requirements.txt .
RUN pip install -r requirements.txt -f /wheels && rm -rf /wheels && rm -rf /root/.cache/*
COPY server.py .
CMD ["python", "server.py"]
EXPOSE 8080
LABEL org.opencontainers.image.source https://github.com/pere3/asynchttp-hello
