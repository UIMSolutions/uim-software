FROM alpine:3.20 AS builder

RUN apk add --no-cache \
    ldc \
    dub \
    gcc \
    musl-dev \
    openssl-dev \
    openssl-libs-static \
    zlib-dev \
    zlib-static \
    libgcc \
    libstdc++

WORKDIR /build
COPY . .

RUN dub build --compiler=ldc2 -b release --config=defaultRun

FROM alpine:3.20

RUN apk add --no-cache libgcc libstdc++ openssl

WORKDIR /app
COPY --from=builder /build/uim-team-platform-service /app/uim-team-platform-service

EXPOSE 8150

ENV TEAM_HOST=0.0.0.0
ENV TEAM_PORT=8150

CMD ["/app/uim-team-platform-service"]
