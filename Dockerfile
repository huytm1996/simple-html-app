FROM nginx:alpine

ARG INDEX_FILE=index.html
COPY ${INDEX_FILE} /usr/share/nginx/html/index.html
