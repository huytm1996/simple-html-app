FROM nginx:alpine

# Chuyển sang root để tạo thư mục
USER root

# Tạo thư mục conf.d
RUN mkdir -p /etc/nginx/conf.d/

# Copy file config và 2 file index
COPY default.conf /etc/nginx/conf.d/default.conf
COPY index1.html /usr/share/nginx/html/index1.html
COPY index2.html /usr/share/nginx/html/index2.html

# Quay lại user nginx
USER nginx
