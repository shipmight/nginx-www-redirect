FROM nginx:1.21-alpine
COPY nginx.conf /etc/nginx/conf.d/nginx-www-redirect.conf
