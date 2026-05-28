# Stage 1: Build
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

# Stage 2: Runtime
FROM alpine:3.20

RUN apk add --no-cache libgcc libstdc++ openssl

WORKDIR /app
COPY --from=builder /build/uim-lean-platform-service /app/uim-lean-platform-service

EXPOSE 8130

ENV LEAN_HOST=0.0.0.0
ENV LEAN_PORT=8130

CMD ["/app/uim-lean-platform-service"]
