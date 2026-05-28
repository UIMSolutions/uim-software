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
COPY --from=builder /build/uim-itil-platform-service /app/uim-itil-platform-service

EXPOSE 8140

ENV ITIL_HOST=0.0.0.0
ENV ITIL_PORT=8140

CMD ["/app/uim-itil-platform-service"]
