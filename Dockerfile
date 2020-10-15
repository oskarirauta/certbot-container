FROM alpine:latest

RUN \
     apk --no-cache update && \
     apk --no-cache upgrade && \
     apk --no-cache add certbot
        
RUN \
     mkdir -p /etc/letsencrypt && \
     mkdir -p /scripts /scripts/entrypoint.d /scripts/certbot && \
     touch /scripts/certbot/renew.sh

RUN rm -f /var/cache/apk/*

ADD entrypoint.sh /scripts/entrypoint.sh
ADD certbot-he-hook.sh /scripts/certbot/certbot-he-hook.sh

VOLUME ["/etc/letsencrypt"]
VOLUME ["/scripts/entrypoint.d"]
VOLUME ["/scripts/certbot"]

ENTRYPOINT ["/scripts/entrypoint.sh"]
CMD ["/usr/sbin/crond", "-f", "-d", "8"]
