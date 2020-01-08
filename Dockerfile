# Using sha instead of tag for instrumenta/conftest:v0.16.0
FROM instrumenta/conftest@sha256:a825f1662ce371abb894971814e38c0b9463d6b5872d919e7109badaa284e74f

RUN apk add --no-cache \
    jq \
    coreutils \
    ca-certificates

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
