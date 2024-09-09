# Use Ubuntu as base image
FROM ubuntu

# Install curl and unzip
RUN apt-get update && \
    apt-get install -y curl unzip && \
    rm -rf /var/lib/apt/lists/*

# ARG for architecture (buildx will set TARGETARCH)
ARG TARGETARCH

# Print the architecture to make sure it's correct
RUN echo "Building for architecture: $TARGETARCH"

# Download, unzip, and install rclone based on the architecture
RUN if [ "$TARGETARCH" = "amd64" ]; then \
        curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip; \
    elif [ "$TARGETARCH" = "arm64" ]; then \
        curl -O https://downloads.rclone.org/rclone-current-linux-arm64.zip; \
    else \
        echo "Unsupported architecture: $TARGETARCH"; exit 1; \
    fi && \
    ls -lh && \
    unzip rclone-current-linux-*.zip && \
    cd rclone-*-linux-* && \
    cp rclone /usr/bin/ && \
    chown root:root /usr/bin/rclone && \
    chmod 755 /usr/bin/rclone && \
    rm -rf rclone-current-linux-*.zip rclone-*-linux-*

# Create a directory for data
RUN mkdir -p /data

# Set environment variable for rclone config file
ENV RCLONE_CONFIG /rclone/config/rclone.conf

# Copy the sync script to the container
COPY sync.sh /sync.sh
RUN chmod +x /sync.sh

# Set additional environment variables
ENV INTERVAL 3600
ENV DRY_RUN false
ENV REMOTE remote

# Define the default command to run the sync script
CMD ["/sync.sh"]
