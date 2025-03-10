FROM alpine:latest

WORKDIR /app

# Add the Pocketbase executable
ADD https://github.com/pocketbase/pocketbase/releases/download/v0.XX.X/pocketbase_0.XX.X_linux_amd64.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /app/ && rm /tmp/pb.zip
RUN chmod +x /app/pocketbase

# Create a simple health check endpoint
RUN echo '#!/bin/sh' > /app/health.sh
RUN echo 'curl -f http://localhost:$PORT/api/health || exit 1' >> /app/health.sh
RUN chmod +x /app/health.sh

EXPOSE 8080

CMD ["/bin/sh", "-c", "/app/pocketbase serve --http=0.0.0.0:$PORT"]
