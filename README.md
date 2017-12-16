# Docker-OneDrive



## Introduction

This is a useful tool to synchronize your data between OneDrive (personal account only) and any environment that supports Docker. It uses [Ubuntu](https://hub.docker.com/_/ubuntu/) as base layer and [OneDrive Free Client](https://github.com/skilion/onedrive).



## Quick Start

```shell
mkdir onedrive && cd onedrive
```
* Follow the url displayed
* Authenticate yourself on Microsoft cloud
* Copy the link of the downloaded file you get from Microsoft
* Paste the link in to the console

```shell
docker run -d --restart on-failure --name onedrive -v `pwd`/config:/root/.config -v `pwd`/data:/root/OneDrive olegfiksel/docker-onedrive
docker logs -f onedrive
```

## Advanced Use

#### Step 1 - Register Your App

* Visit [Official Guide](https://dev.onedrive.com/app-registration.htm) for reference.


* Visit [Microsoft Application Registration Portal](https://apps.dev.microsoft.com/?referrer=https%3A%2F%2Fdev.onedrive.com%2Fapp-registration.htm) to add an app.

#### Step 2 - Retrieve Your Client ID

* Choose `Mobile application` in Platforms.
* The client ID is then available.

#### Step 3 - Apply the Client ID

* Create file `onedrive.conf` in your convenient place with the following content:

```
client_id = "";
sync_dir = "/onedrive"
skip_file = ".*|~*"
skip_dir = ".*"
```

* Copy and paste your client ID to `clien_id` parameter.
* For reference of `onedrive.conf` settings, please see [this configuration](https://github.com/skilion/onedrive#configuration).

#### Step 4 - Re-create Docker Containers

```
docker rm docker-onedrive
docker run -it --restart on-failure --name docker_onedrive
  -v /path/to/onedrive:/onedrive
  -v /path/to/onedrive.conf:/usr/local/etc/onedrive.conf
  olegfiksel/docker-onedrive
```

* Follow `step 3` and `step 4` in `Quick Start`.



## Reference

* [OneDrive Free Client](https://github.com/skilion/onedrive)



## License

* [GNU General Public License v3](http://www.gnu.org/licenses/gpl-3.0.en.html)
