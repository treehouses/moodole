# moodole

[![Build Status](https://travis-ci.org/ole-vi/moodole.svg?branch=master)](https://travis-ci.org/ole-vi/moodole)

Moodle Docker for Raspberry Pi

https://hub.docker.com/r/treehouses/moodle/

Moodle E Learning running on ARM with Raspberry Pi by Open Learning Exchange

---

**For x86:**
```
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
    build: .
    container_name: moodle
    ports:
      - "80:80"
    environment:
    - MOODOLE_DB_URL=moodledb
    - MOODOLE_DB_NAME=moodle
    - MOODOLE_DB_USER=moodle
    - MOODOLE_DB_PASS=moodle
    - MOODOLE_DB_PORT=5432
    - MOODOLE_MAX_BODY_SIZE=300M
    - MOODOLE_BODY_TIMEOUT=700s
```

---

**For ARM:**
```
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
    volumes:
    - /home/pi/apache2:/var/run/apache2
    environment:
    - MOODOLE_DB_URL=moodledb_rpi
    - MOODOLE_DB_NAME=moodle
    - MOODOLE_DB_USER=moodle
    - MOODOLE_DB_PASS=moodle
    - MOODOLE_DB_PORT=5432
    - MOODOLE_POST_MAX_SIZE=200M
    - MOODOLE_UPLOAD_MAX_FILESIZE=200M
```
