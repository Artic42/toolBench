FROM alpine:3.22

RUN apk add openssh

COPY entrypoint.sh /

EXPOSE 22

ENTRYPOINT ["/entrypoint.sh"]


