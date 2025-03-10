FROM alpine:latest

WORKDIR /app

# Install necessary packages
RUN apk add --no-cache ca-certificates unzip

# Set PocketBase version - check for the latest at https://github.com/pocketbase/pocketbase/releases
ARG PB_VERSION=0.22.4

# Download and unzip PocketBase
ADD https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /app && rm /tmp/pb.zip

# Expose the default PocketBase port
EXPOSE 8080

# Create directory for data
RUN mkdir -p /app/pb_data

# Make the binary executable
RUN chmod +x /app/pocketbase

# Start PocketBase
CMD ["/app/pocketbase", "serve", "--http=0.0.0.0:8080", "--dir=/app/pb_data"]
