FROM phpmyadmin/phpmyadmin

RUN echo "upload_max_filesize = 256M" > /usr/local/etc/php/conf.d/upload.ini && \
	echo "post_max_size = 256M" >> /usr/local/etc/php/conf.d/upload.ini

# Add volume for sessions to allow session persistence
VOLUME /sessions

# We expose phpMyAdmin on port 80
EXPOSE 80
