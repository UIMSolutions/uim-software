FROM alpine:3.20 AS base
RUN apk add --no-cache ldc dub gcc musl-dev

FROM base AS build
WORKDIR /build
COPY dub.sdl dub.selections.json ./
COPY source/ source/
RUN dub build --compiler=ldc2 -b release

FROM alpine:3.20
RUN apk add --no-cache libgcc
WORKDIR /app
COPY --from=build /build/uim-ewm-platform-service .
EXPOSE 8132
ENV EWM_HOST=0.0.0.0
ENV EWM_PORT=8132
CMD ["./uim-ewm-platform-service"]
