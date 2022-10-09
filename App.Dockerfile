FROM node:16 as builder

WORKDIR /app
COPY . .
RUN npm i
RUN npm run build


FROM busybox:1.35 as app

# Create a non-root user to own the files and run our server
RUN adduser -D static
USER static
WORKDIR /app

# Copy the static website
# Use the .dockerignore file to control what ends up inside the image!
COPY --from=builder /app/build ./

# Run BusyBox httpd
CMD ["busybox", "httpd", "-f", "-v", "-p", "3000"]
HEALTHCHECK --interval=5s --timeout=1500ms --start-period=10s --retries=3 CMD ["/docker-healthcheck.sh", "3000"]
