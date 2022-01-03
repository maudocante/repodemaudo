FROM nextcloud:latest
MAINTAINER maudo cante <admin@gmail.com>
COPY ./mkcert /root/mkcert
RUN  chown www-data /root/mkcert
RUN chmod +x /root/mkcert 
RUN cd /root/ && ./mkcert -install && ./mkcert  bombolomfm.local localhost 127.0.0.1 && cp ./bombolomfm.local+2.pem /etc/ssl/certs/ssl-cert-snakeoil.pem && cp ./bombolomfm.local+2-key.pem \
/etc/ssl/private/ssl-cert-snakeoil.key 
RUN a2enmod rewrite
RUN a2ensite default-ssl
RUN a2enmod ssl
#copy php.ini
COPY ./upload_max.ini /usr/local/etc/php/conf.d/

EXPOSE 80
EXPOSE 443
