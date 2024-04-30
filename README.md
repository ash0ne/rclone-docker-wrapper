# Rclone OneDrive Docker Wrapper

A docker wrapper around rclone that syncs to OneDrive from Docker/unRAID everyday.

The only thing that this docker container does is sync/backup whatever you mount at `/data` to a directory named `/rclone-backup` in your OneDrive.
I might considere adding other remote sources later.

## How to use

- Run the below docker command and replace the `user` and `password` with your desired values.
  > Note: This is **not** the password of your OneDrive. It is the username and password you use to rclone remote management API.

  ```
  docker run -d --name rclone --restart=unless-stopped -p 5572:5572 -v /mnt/user/appdata/rclone/config:/config/rclone -v /mnt/user/appdata/rclone/rclone-dashboard/sync_script:/sync_script -v /mnt/user/docs:/data -e PHP_TZ=Europe/London a0ne/rclone-docker-wrapper:latest rcd --rc-addr 0.0.0.0:5572 --rc-user <user> --rc-pass <password> -vv --checksum --transfers=4 --checkers=4 --contimeout=60s --timeout=300s --retries=3 --low-level-retries=10 --stats=1s --stats-file-name-length=0
  ```

- Once the container is up, interactively configure rclone in another Linux/Windows machine that has a browser and copy over the `rclone.conf` to the `/config/rclone` of the Docker container.
- The easiest way to do this is to `cd` into the conf mount on your docker host; do a `vi rclone.conf` and copy paste the `rclone.conf` contents.
