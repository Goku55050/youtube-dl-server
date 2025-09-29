FROM python:3.13-alpine
ENV COOKIEFILE=
RUN adduser -D -h /usr/src/app python

RUN apk add --no-cache deno

RUN mkdir -p /usr/src/app/.venv && chown python:python -R /usr/src/app
WORKDIR /usr/src/app

COPY --chown=python:python Pipfile Pipfile.lock /usr/src/app/

USER python
RUN pip install --user pipenv && python3 -m pipenv install --deploy
COPY --chown=python:python youtube_dl_server.py /usr/src/app/

EXPOSE 8080

CMD ["python3", "-m", "pipenv", "run", "execute"]
