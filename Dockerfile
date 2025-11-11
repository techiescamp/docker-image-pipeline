
FROM alpine:3.20

# Create non-root user
RUN addgroup -S app && adduser -S -G app -u 10001 app

WORKDIR /app
COPY web/ /app

EXPOSE 8080
USER 10001

# BusyBox httpd is included in Alpine base
CMD ["sh","-c","busybox httpd -f -p 0.0.0.0:8080 -h /app"]
