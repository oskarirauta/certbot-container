FROM alpine:latest

#ENV \
#    ENV1="" \
#    ENV2=""

RUN \
     apk --no-cache update && \
     apk --no-cache upgrade && \
     apk --no-cache add certbot
        
RUN \
     mkdir -p /etc/letsencrypt && \
     mkdir -p /scripts /scripts/entrypoint.d /scripts/certbot

RUN rm -f /var/cache/apk/*

ADD entrypoint.sh /scripts/entrypoint.sh

RUN \
     touch /scripts/certbot/renew.sh && \
     touch /scripts/certbot/certonly.sh

VOLUME ["/etc/letsencrypt"]
VOLUME ["/scripts/entrypoint.d"]
VOLUME ["/scripts/certbot"]

ENTRYPOINT ["/scripts/entrypoint.sh"]
CMD ["/usr/sbin/crond", "-f", "-d", "8"]
