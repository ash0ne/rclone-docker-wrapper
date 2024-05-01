# Rclone Docker Wrapper

A docker wrapper for rclone that syncs to any remote from Docker/unRAID.

The only thing that this docker container does is sync(backup) whatever you mount at `/data` to a directory named `/rclone-backup` in your remote. I might see if it is worth adding support for more than one source and remote but for now, it'll be a single source to a single remote.

## How to use

- Interactively configure rclone in another Linux/Windows machine that has a browser with the remote you want and copy over the `rclone.conf` to any `/path/to/config` on the host which we'll mount as a volume at `/config/rclone` of the Docker container.

- Run the below docker command and replace the `REMOTE` with your remote name. The remote name must be the same you used in your `rclone.conf`
  > Note: The `/path/to/config` on the host must be writable from within the container as some remotes need to write back the `access_token` after refresh.

```
docker run -d --name rclone-container \
-v /path/to/data:/data \
-v /path/to/config:/rclone/config \
-e INTERVAL=3600 \
-e REMOTE=onedrive a0ne/rclone-docker-wrapper:latest
```

#### Options

- **INTERVAL** - The sync frequencey in seconds.
- **DRY_RUN** - Only does a dry run if set to true.
- **REMOTE** - The name of the remote that you want to back-up into.
