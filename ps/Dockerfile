FROM alpine:3.20 AS base
RUN apk add --no-cache ldc dub gcc musl-dev

FROM base AS build
WORKDIR /build
COPY dub.sdl ./
COPY source/ source/
RUN dub build --compiler=ldc2 -b release

FROM alpine:3.20
RUN apk add --no-cache libgcc
WORKDIR /app
COPY --from=build /build/uim-ps-platform-service .
EXPOSE 8121
ENV PS_HOST=0.0.0.0
ENV PS_PORT=8121
CMD ["./uim-ps-platform-service"]
