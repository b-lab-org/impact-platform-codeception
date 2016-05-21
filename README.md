# Impact Platform: Codeception
[Docker](https://www.docker.com/) container for [Codeception](http://codeception.com/).

## Overview
Use with the [data container](https://github.com/b-lab-org/impact-platform-data), [memcached container](https://github.com/b-lab-org/impact-platform-memcached) and [postgres container](https://github.com/b-lab-org/impact-platform-pg).

Run a Codeception command from the `/data/www` directory.

## Docker-Compose Usage
```
codeception:
    image: impactbot/impact-platform-codeception
    volumes_from:
        - data
    links:
        - pg:pg
        - memcached:memcached
```

For `acceptance` and `functional` tests, map the [nginx container](https://github.com/b-lab-org/impact-platform-nginx) to the host name:
```
links:
  - nginx:my.awesome.host
```
