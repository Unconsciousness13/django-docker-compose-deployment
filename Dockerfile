FROM python:3.9-alpine
LABEL maintainer="pako.es"

ENV PYTHONUNBUFFED 1

COPY ./requirements.txt /requirements.txt
COPY ./app /app

WORKDIR /app
EXPOSE 8000

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    apk add --update --no-cache postgresql-client && \
    apk add --update --no-cache --virtual .tmp-deps \
        build-base postgresql-dev musl-dev && \
    /py/bin/pip install -r /requirements.txt && \
    apk del .tmp-deps && \
    mkdir -p /vol/web/static && \
    mkdir -p /vol/web/media && \
    chown -R root:root /vol && \
    chmod -R 755 /vol



ENV PATH="/py/bin:$PATH"

USER root