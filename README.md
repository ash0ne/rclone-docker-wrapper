# Rclone OneDrive Docker Wrapper

<<<<<<< HEAD
A docker wrapper around rclone that syncs to OneDrive from Docker/unRAID everyday.
=======
A docker wrapper for rclone that syncs to any remote from Docker/unRAID.
>>>>>>> 485242c (feat: Re-doing the implementation using a Ubuntu base)

The only thing that this docker container does is sync(backup) whatever you mount at `/data` to a directory named `/rclone-backup` in your remote. I might see if it is worth adding support for more than one source and remote but for now, it'll be a single source to a single remote.

## How to use

<<<<<<< HEAD
- Run the below docker command and replace the `user` and `password` with your desired values.
  > Note: This is **not** the password of your OneDrive. It is the username and password you use to rclone remote management API.

  ```
  docker run -d --name rclone --restart=unless-stopped -p 5572:5572 -v /mnt/user/appdata/rclone/config:/config/rclone -v /mnt/user/appdata/rclone/rclone-dashboard/sync_script:/sync_script -v /mnt/user/docs:/data -e PHP_TZ=Europe/London a0ne/rclone-docker-wrapper:latest rcd --rc-addr 0.0.0.0:5572 --rc-user <user> --rc-pass <password> -vv --checksum --transfers=4 --checkers=4 --contimeout=60s --timeout=300s --retries=3 --low-level-retries=10 --stats=1s --stats-file-name-length=0
  ```
=======
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
>>>>>>> 485242c (feat: Re-doing the implementation using a Ubuntu base)

#### Options

- **INTERVAL** - The sync frequencey in seconds.
- **DRY_RUN** - Only does a dry run if set to true.
- **REMOTE** - The name of the remote that you want to back-up into.
