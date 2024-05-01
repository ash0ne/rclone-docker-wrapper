# Use Ubuntu as base image
FROM ubuntu

RUN apt-get update && \
    apt-get install -y rclone curl

RUN mkdir -p /data

ENV RCLONE_CONFIG /rclone/config/rclone.conf

COPY sync.sh /sync.sh
RUN chmod +x /sync.sh

ENV INTERVAL 3600
ENV DRY_RUN false
ENV REMOTE remote

CMD ["/sync.sh"]
