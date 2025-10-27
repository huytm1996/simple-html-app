FROM nginx:alpine
COPY index1.html /usr/share/nginx/html/index1.html
COPY index2.html /usr/share/nginx/html/index2.html
COPY default.conf /etc/nginx/conf.d/default.conf