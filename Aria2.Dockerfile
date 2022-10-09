FROM alpine as certs
RUN apk update && apk add ca-certificates

FROM busybox:1.35 as app

# Create a non-root user to own the files and run our server
RUN adduser -D static
USER static
WORKDIR /app

# Copy the static website
# Use the .dockerignore file to control what ends up inside the image!
COPY --from=certs /etc/ssl/certs /etc/ssl/certs
COPY ./extra/aria2_arm_32 ./aria2
COPY extra/aria2.conf .
RUN mkdir "downloads"
CMD ["./aria2", "--conf-path", "aria2.conf", "-d", "downloads", "--disable-ipv6"]
