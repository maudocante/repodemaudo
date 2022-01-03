FROM nextcloud:latest
MAINTAINER maudo cante <admin@gmail.com>

#COPY  ./ssl-cert-snakeoil.pem /etc/ssl/certs/
#COPY  ./ssl-cert-snakeoil.key /etc/ssl/private/

#RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/ssl-cert-snakeoil.key -out /etc/ssl/certs/ssl-cert-snakeoil.pem -subj "/C=GW/ST=SAB/L=Bisaau/O=Security/OU=Development/CN=cante.local"

COPY ./mkcert /root/mkcert
RUN  chown www-data /root/mkcert
RUN chmod +x /root/mkcert 
RUN cd /root/ && ./mkcert -install && ./mkcert  bombolomfm.local localhost 127.0.0.1 && cp ./bombolomfm.local+2.pem /etc/ssl/certs/ssl-cert-snakeoil.pem && cp ./bombolomfm.local+2-key.pem \
/etc/ssl/private/ssl-cert-snakeoil.key 
RUN mkdir -p /var/www/html/custom_apps/
#COPY  ./custom_apps /var/www/html/custom_apps/
#RUN cd /var/www/html
#RUN chown -R www-data /var/www/html/custom_apps/
#RUN apt-get install vim 
RUN a2enmod rewrite
RUN a2ensite default-ssl
RUN a2enmod ssl
#copy php.ini
COPY ./upload_max.ini /usr/local/etc/php/conf.d/

EXPOSE 80
EXPOSE 443
