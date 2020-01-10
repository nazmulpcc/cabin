#!/bin/bash

if [[ $DOMAIN == "local" ]]; then
    if [ ! -d /etc/letsencrypt/live/local ]; then
        sudo mkdir -p /etc/letsencrypt/live/local
    fi
    sudo openssl genrsa -out "/etc/letsencrypt/live/local/privkey.pem" 2048
    sudo openssl req -new -key "/etc/letsencrypt/live/local/privkey.pem" -out "/etc/letsencrypt/live/local/cert.pem" -subj "/CN=default/O=default/C=UK"
    sudo openssl x509 -req -days 365 -in "/etc/letsencrypt/live/local/cert.pem" -signkey "/etc/letsencrypt/live/local/privkey.pem" -out "/etc/letsencrypt/live/local/fullchain.pem"
    echo "Generated local certificates"
else
    echo "dns_cloudflare_email = $CERTBOT_CLOUDFLARE_EMAIL" > ~/cloudflare.ini
    echo "dns_cloudflare_api_key = $CERTBOT_CLOUDFLARE_API"  >> ~/cloudflare.ini

    if [ ! -d /etc/letsencrypt/live/$DOMAIN ]; then
        sudo certbot certonly \
            --dns-cloudflare \
            --dns-cloudflare-credentials ~/cloudflare.ini \
            --agree-tos \
            --email $CERTBOT_EMAIL \
            --non-interactive \
            -d $DOMAIN -d *.$DOMAIN
        if [ ! -d /etc/letsencrypt/live/$DOMAIN ]; then
            sudo cp -r /etc/letsencrypt/live/$DOMAIN* /etc/letsencrypt/live/$DOMAIN
        fi
    fi
    rm ~/cloudflare.ini
fi

mkdir /tmp/ssl
sudo cat /etc/letsencrypt/live/$DOMAIN/fullchain.pem > /tmp/ssl/fullchain.pem
sudo cat /etc/letsencrypt/live/$DOMAIN/privkey.pem > /tmp/ssl/privkey.pem
sudo cat /etc/letsencrypt/live/$DOMAIN/cert.pem > /tmp/ssl/cert.pem

sudo cp /tmp/ssl/* /etc/nginx-ssl