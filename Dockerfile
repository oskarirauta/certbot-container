FROM alpine:latest

#ENV \
#    ENV1="" \
#    ENV2=""

RUN \
     apk --no-cache update && \
     apk --no-cache upgrade && \
     apk --no-cache add certbot
        
RUN \
        mkdir -p /scripts /scripts/entrypoint.d

RUN     rm -f /var/cache/apk/*

ADD entrypoint.sh /scripts/entrypoint.sh

VOLUME ["/scripts/entrypoint.d"]

ENTRYPOINT ["/scripts/entrypoint.sh"]
CMD ["/usr/sbin/crond", "-d", "8"]
