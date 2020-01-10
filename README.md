**Cabin** is a set of common services needed mostly while working with *PHP* or *NodeJS* projects. 

# Setup
Copy the `.env.example` file to `.env` and set necessary values. See available options below.

## Configuration Options 
- `COMPOSE_PROJECT_NAME` : Configure project name. Generated docker containers' name will be prefixed with this value.
- `TIMEZONE` : Set your timezone, see https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List
- `PROJECT_PATH` : Your root project folder which will be mounted at `/var/www` in containers which need access to your code files.
- `DOMAIN` : Used to generate certificated, set to `local` to generate certs for local usage. For actual domains, you need to specify `CERTBOT_EMAIL`, `CERTBOT_CLOUDFLARE_EMAIL` and `CERTBOT_CLOUDFLARE_API`. Also, your domain must be added in your Cloudflare account. Other ways of obtaining certificates will be added later. Contributions welcome.
- `MYSQL_` : Your MySQL database settings.
- `NGINX_SITES` : Specify where your nginx configuration files are. This allows you to write your own custom config files.
- `WORK_USER` : Should be your local username for Mac and Linux.
- `HOST_USER_ID` and `HOST_GROUP_ID` : You can find these values with `id -u` and `id -g` respectively. This is needed to map file permissions.
- `PMA_PORT` : PhpMyadmin Port.