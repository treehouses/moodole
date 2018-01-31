# moodole

[![Build Status](https://travis-ci.org/treehouses/moodole.svg?branch=master)](https://travis-ci.org/treehouses/moodole)

Moodle Docker for Raspberry Pi

https://hub.docker.com/r/treehouses/moodle/

Moodle E Learning running on ARM with Raspberry Pi by Open Learning Exchange

---

## How to use

1. download docker-compose-ready.yml file
2. move to the folder which contains docker-compose-ready.yml
3. run command to start moodle:
 ```shell
docker-compose -f docker-compose-ready.yml up -d
 ```
4. run command to stop moodle:
 ```shell
docker-compose -f docker-compose-ready.yml stop
 ```
5. delete environment:
 ```shell
docker-compose -f docker-compose-ready.yml down
 ```
6. See if the docker containers running
  ```shell
 docker ps
  ```
7. view container log
 ```shell
 docker logs {{container_id}}
 ```

---

## Different versions of docker-compose-ready.yml file

**For x86:**

```dockerfile
version: '2'
services:
  moodledb:
    image: postgres
    container_name: moodledb
    environment:
    # MAKE SURE THIS ONE SAME WITH THE MOODLE
    - POSTGRES_DATABASE=moodle
    - POSTGRES_USER=moodle
    - POSTGRES_PASSWORD=moodle
  moodle:
    image: treehouses/moodle:latest
    container_name: moodle
    ports:
      - "80:80"
    environment:
    - NGINX_PORT=80
    - MOODOLE_DB_URL=moodledb
    - MOODOLE_DB_NAME=moodle
    - MOODOLE_DB_USER=moodle
    - MOODOLE_DB_PASS=moodle
    - MOODOLE_DB_PORT=5432
    - MOODOLE_MAX_BODY_SIZE=200M
    - MOODOLE_BODY_TIMEOUT=300s
```

---

**For x86 alpine:**

```dockerfile
version: '2'
services:
  moodledb:
    image: postgres
    container_name: moodledb
    environment:
    # MAKE SURE THIS ONE SAME WITH THE MOODLE
    - POSTGRES_DATABASE=moodle
    - POSTGRES_USER=moodle
    - POSTGRES_PASSWORD=moodle
  moodle:
    image: treehouses/moodle:alpine-latest
    container_name: moodle
    ports:
      - "80:80"
    environment:
    - NGINX_PORT=80
    - MOODOLE_DB_URL=moodledb
    - MOODOLE_DB_NAME=moodle
    - MOODOLE_DB_USER=moodle
    - MOODOLE_DB_PASS=moodle
    - MOODOLE_DB_PORT=5432
    - MOODOLE_MAX_BODY_SIZE=200M
    - MOODOLE_BODY_TIMEOUT=300s
```

---

**For ARM:**

```dockerfile
version: '2'
services:
  moodledb_rpi:
    image: arm32v7/postgres
    container_name: moodledb_rpi
    environment:
    # MAKE SURE THIS ONE SAME WITH THE MOODLE
    - POSTGRES_DATABASE=moodle
    - POSTGRES_USER=moodle
    - POSTGRES_PASSWORD=moodle
  moodle_rpi:
    image: treehouses/moodle:rpi-latest
    container_name: moodle_rpi
    ports:
      - "80:80"
    environment:
    - NGINX_PORT=80
    - MOODOLE_DB_URL=moodledb_rpi
    - MOODOLE_DB_NAME=moodle
    - MOODOLE_DB_USER=moodle
    - MOODOLE_DB_PASS=moodle
    - MOODOLE_DB_PORT=5432
    - MOODOLE_MAX_BODY_SIZE=200M
    - MOODOLE_BODY_TIMEOUT=300s
```

---

**For ARM alpine:**

```dockerfile
version: '2'
services:
  moodledb_rpi_alpine:
    image: arm32v7/postgres
    container_name: moodledb_rpi_alpine
    environment:
    # MAKE SURE THIS ONE SAME WITH THE MOODLE
    - POSTGRES_DATABASE=moodle
    - POSTGRES_USER=moodle
    - POSTGRES_PASSWORD=moodle
  moodle_rpi_alpine:
    image: treehouses/moodle:rpi-alpine-latest
    container_name: moodle_rpi_alpine
    ports:
      - "80:80"
    environment:
    - NGINX_PORT=80
    - MOODOLE_DB_URL=moodledb_rpi_alpine
    - MOODOLE_DB_NAME=moodle
    - MOODOLE_DB_USER=moodle
    - MOODOLE_DB_PASS=moodle
    - MOODOLE_DB_PORT=5432
    - MOODOLE_MAX_BODY_SIZE=200M
    - MOODOLE_BODY_TIMEOUT=300s
```
