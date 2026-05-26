FROM debian:stable-slim as build

RUN apt-get update && apt-get install curl unzip -y

RUN curl -o /sample.zip https://downloads.mysql.com/docs/world-db.zip

RUN unzip -j /sample.zip '**/*.sql' -d sampledb

FROM mariadb:lts

COPY --from=build /sampledb /docker-entrypoint-initdb.d/