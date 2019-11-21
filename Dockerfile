FROM instrumenta/conftest:v0.10.0

RUN apk add --no-cache jq coreutils ca-certificates

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
