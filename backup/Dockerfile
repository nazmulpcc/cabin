FROM alpine:3.12

RUN apk add --no-cache \
    borgbackup \
    rclone \
    mariadb-backup \
    mariadb-client \
    findutils

COPY ./backup.sh /srv/backup.sh
COPY ./restore.sh /srv/restore.sh

CMD [ "/srv/backup.sh" ]