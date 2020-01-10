sudo service supervisor start

if [ ! -f /etc/nginx-ssl/cert.pem ]; then
    bash /home/${WORK_USER}/certbot.sh
fi