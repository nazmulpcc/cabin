FROM mariadb:10.4.11-bionic

ARG TIMEZONE=UTC
ENV TIMEZONE ${TIMEZONE}
RUN ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && echo $TIMEZONE > /etc/timezone && chown -R mysql:root /var/lib/mysql/

COPY my.cnf /etc/mysql/conf.d/my.cnf

CMD ["mysqld"]

EXPOSE 3306
