#############
# Build stage
#############
#ARG FROM=python:3.12.4-bookworm
#ARG FROM=python:3.12.4-slim-bookworm
ARG FROM=python:3.12.4-alpine3.20
FROM ${FROM} as build-stage

ADD https://github.com/alexander-barmin/py-jokes/archive/refs/heads/main.zip /
RUN unzip /main.zip

#############
# Main stage
#############
ARG FROM=python:3.12.4-alpine3.20
FROM ${FROM} as main-stage

COPY --from=build-stage /py-jokes-main/app /opt/app

ARG USER=myapp
ARG ID=2000

RUN addgroup -g ${ID} ${USER} && \
    adduser -D -G ${USER} -u ${ID} -s /sbin/nologin ${USER}
USER ${USER}

ADD ./app/requirements.txt /requirements.txt
RUN pip3 install -r /requirements.txt
