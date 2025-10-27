FROM nginx:alpine



# Copy file config và 2 file index

COPY index1.html /usr/share/nginx/html/index1.html
COPY index2.html /usr/share/nginx/html/index2.html

