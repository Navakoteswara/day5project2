
# Stage 1: Download and extract CSS project files
FROM alpine:latest AS downloader

# Install necessary utilities
RUN apk --no-cache add curl unzip

# Define environment variables
#ENV PROJECT_URL=https://www.free-css.com/assets/files/free-css-templates/download/page294/electrochip.zip
ENV PROJECT_URL=https://www.free-css.com/assets/files/free-css-templates/download/page292/microo.zip

# Download and extract the CSS project
RUN mkdir -p /tmp/project && \
    curl -L $PROJECT_URL -o /tmp/project/project.zip && \
    unzip /tmp/project/micro.zip -d /tmp/project

# Stage 2: Serve files using Apache HTTP Server
FROM httpd:latest

# Copy project files from the downloader stage
COPY --from=downloader /tmp/project/electrochip-html /usr/local/apache2/htdocs/

# Expose HTTP port
EXPOSE 80

# Start Apache HTTP Server
CMD ["httpd-foreground"]


