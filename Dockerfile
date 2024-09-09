# Use Ubuntu as base image
FROM ubuntu

RUN apt-get update && \
    apt-get install -y curl unzip && \
    rm -rf /var/lib/apt/lists/*

ARG TARGETARCH

RUN if [ "$TARGETARCH" = "amd64" ]; then \
        curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip; \
    elif [ "$TARGETARCH" = "arm64" ]; then \
        curl -O https://downloads.rclone.org/rclone-current-linux-arm64.zip; \
    else \
        echo "Unsupported architecture: $TARGETARCH"; exit 1; \
    fi && \
    unzip rclone-current-linux-*.zip && \
    cd rclone-*-linux-* && \
    cp rclone /usr/bin/ && \
    chown root:root /usr/bin/rclone && \
    chmod 755 /usr/bin/rclone && \
    rm -rf rclone-current-linux-*.zip rclone-*-linux-*

RUN mkdir -p /data

ENV RCLONE_CONFIG /rclone/config/rclone.conf

COPY sync.sh /sync.sh
RUN chmod +x /sync.sh

ENV INTERVAL 3600
ENV DRY_RUN false
ENV REMOTE remote

CMD ["/sync.sh"]
