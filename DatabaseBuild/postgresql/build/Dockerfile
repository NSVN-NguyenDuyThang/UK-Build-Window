FROM postgres:14.5
USER root

ARG POSTGRES_USER postgres
ARG POSTGRES_PASSWORD
ARG DB_NAME

ENV POSTGRES_USER $POSTGRES_USER
ENV POSTGRES_PASSWORD $POSTGRES_PASSWORD
ENV DB_NAME $DB_NAME
RUN apt-get update -y
RUN apt-get install zip unzip -y
COPY start.sh /docker-entrypoint-initdb.d/
RUN sed -i 's/\r$//' /docker-entrypoint-initdb.d/start.sh
USER postgres
WORKDIR /usr/src/app
COPY pg_restore.zip /usr/src/app

EXPOSE 5432