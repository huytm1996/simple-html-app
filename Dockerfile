FROM nginx:alpine
# Copy cả hai file vào image
COPY index1.html /usr/share/nginx/html/
COPY index2.html /usr/share/nginx/html/

# Dùng file được chọn làm index.html chính
RUN cp /usr/share/nginx/html/${INDEX_FILE} /usr/share/nginx/html/index.html


