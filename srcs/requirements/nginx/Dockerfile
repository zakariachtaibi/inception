FROM debian:bookworm

RUN apt update && apt install -y \
    nginx \
    openssl && \
    rm -rf /var/lib/apt/lists/*

# Generate self-signed SSL certificate
RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=MA/ST=Morocco/L=Khouribga/O=1337/OU=Student/CN=localhost"

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/run/nginx && \
    mkdir -p /var/www/html && \
    chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
