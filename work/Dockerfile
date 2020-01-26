FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get -y install nano sudo git wget openssh-client inetutils-ping mysql-client unzip

RUN apt-get -yq install software-properties-common
RUN add-apt-repository -y ppa:ondrej/php
RUN apt-get update

RUN apt-get -yq install \
    php7.3 \
    php7.3-gmp \
    php7.3-curl \
    php7.3-gd \
    php7.3-mbstring \
    php7.3-bcmath \
    php7.3-soap \
    php7.3-zip \
    php7.3-xml \
    php7.3-mysql

RUN wget https://raw.githubusercontent.com/composer/getcomposer.org/76a7060ccb93902cd7576b67264ad91c8a2700e2/web/installer -O - -q | php -- --install-dir=/usr/local/bin --filename=composer

RUN add-apt-repository -y ppa:certbot/certbot && \
    apt-get install -yq certbot python3-certbot-dns-cloudflare curl

ARG WORK_USER=cabin
ARG HOST_USER_ID=1000
ARG HOST_GROUP_ID=1001

RUN adduser ${WORK_USER} --disabled-password --gecos '' --uid ${HOST_USER_ID} && \
    usermod ${WORK_USER} -a -G sudo && \
    groupmod -g ${HOST_GROUP_ID} ${WORK_USER} && \
    echo "${WORK_USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    apt-get install -y nodejs && \
    apt-get remove cmdtest

# COPY ./supervisor/*.conf /etc/supervisor/conf.d/
# RUN sed -i "s/WORK_USER$/${WORK_USER}/g" /etc/supervisor/conf.d/*.conf
RUN npm i -g yarn

USER ${WORK_USER}

COPY certbot.sh /home/${WORK_USER}
COPY ./init.sh /home/$WORK_USER/init.sh

RUN sudo chown -R ${WORK_USER}:${WORK_USER} /home/${WORK_USER}

WORKDIR /var/www

ENTRYPOINT /bin/bash /home/$WORK_USER/init.sh && /bin/bash