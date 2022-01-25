FROM alpine:latest

ENV LANG="en_US.UTF-8" \
    LC_ALL="C.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    TERM="xterm"

RUN apk --update add \
      curl \
      bash \
      ca-certificates \
      jq \
      vim \
      && \
    rm -rf /tmp/src && \
    rm -rf /var/cache/apk/*

ADD ./backup.sh /backup.sh

RUN chmod u+x  /backup.sh

ENV P_USER="root" \
    P_PASS="password" \
    P_URL="http://example.com:9000" \
    BACKUP_EXPIRY_DAYS="365"

# Configure cron
COPY ./crontab /etc/cron/crontab

# Init cron
RUN crontab /etc/cron/crontab

CMD ["crond", "-f"]
