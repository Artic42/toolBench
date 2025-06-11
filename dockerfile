FROM alpine:3.22

RUN apk add openssh

EXPOSE 22

CMD ["/bin/sh"]

