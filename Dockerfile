FROM alpine
RUN apk add --no-cache git docker
COPY docker-get /
ENTRYPOINT [ "/docker-get" ]