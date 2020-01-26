FROM node:13.6.0-alpine3.10

ARG WORK_USER=cabin
ARG HOST_USER_ID=1000
ARG HOST_GROUP_ID=1001
ARG NODEJS_STARTUP

ENV PATH /app/node_modules/.bin:$PATH

RUN npm install pm2 -g

RUN apk add python make g++

# RUN adduser ${WORK_USER} --disabled-password --gecos '' --uid ${HOST_USER_ID} && \
#     usermod ${WORK_USER} -a -G sudo && \
#     groupmod -g ${HOST_GROUP_ID} ${WORK_USER}

# USER ${HOST_USER_ID}

COPY ./init.sh /root/init.sh

WORKDIR /var/www

CMD ["/bin/sh", "/root/init.sh"]