FROM alpine:3.22.4 AS build

RUN apk add --no-cache curl unzip

RUN curl -o /pagila.zip https://github.com/devrimgunduz/pagila/archive/refs/heads/master.zip

RUN unzip /pagila.zip -d /tmp


FROM postgres:14.23-alpine3.23

COPY --from=build /tmp/pagila-master/pagila-schema.sql /docker-entrypoint-initdb.d/01-schema.sql
COPY --from=build /tmp/pagila-master/pagila-data.sql /docker-entrypoint-initdb.d/02-data.sql