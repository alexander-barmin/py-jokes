#############
# Build stage
#############
#ARG FROM=python:3.12.4-bookworm
#ARG FROM=python:3.12.4-slim-bookworm
#ARG FROM=python:3.12.4-alpine3.20
ARG FROM=python:3.12.4-bookworm
FROM ${FROM} as build-stage

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update -qq \
    && apt-get upgrade \
      --yes -qq --no-install-recommends \
    && apt-get install \
      --yes -qq --no-install-recommends \
      git \
      curl \
      unzip \
      traceroute \
      iproute2 \
      iputils-ping \
      postgresql \
    && python3 -m venv /opt/app/venv \
    && /opt/app/venv/bin/python3 -m pip install --upgrade \
      pip

ADD https://github.com/alexander-barmin/py-jokes/archive/refs/heads/main.zip /
RUN unzip /main.zip

#############
# Main stage
#############
#ARG FROM=python:3.12.4-alpine3.20
ARG FROM=python:3.12.4-bookworm
FROM ${FROM} as main-stage

ARG USER=myapp
ARG ID=2000
RUN groupadd -g ${ID} ${USER} \
    && useradd -m -d /opt/app -g ${ID} -u ${ID} -s /sbin/nologin ${USER}
USER ${USER}
#RUN addgroup -g ${ID} ${USER} && \
#    adduser -D -G ${USER} -u ${ID} -s /sbin/nologin ${USER}

COPY --from=build-stage /py-jokes-main/app /opt/app
RUN python3 -m venv /opt/app/venv \
    && /opt/app/venv/bin/python3 -m pip install --upgrade pip

RUN /opt/app/venv/bin/pip install -r /opt/app/requirements.txt

EXPOSE 8080

WORKDIR /opt/app

ENV LANG=C.utf8 PATH=/opt/app/venv/bin:$PATH
ENTRYPOINT ["flask", "--app=py-jokes", "run", "--host=0.0.0.0", "--port=8080"]
