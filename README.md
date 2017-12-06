# moodole
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
    image: treehouses/moodle:x86-pgsql-1.1
    container_name: moodle
    ports:
      - "80:80"
    volumes:
    - /home/pi/apache2:/var/run/apache2
    environment:
    - MOODOLE_DB_URL=moodledb
    - MOODOLE_DB_NAME=moodle
    - MOODOLE_DB_USER=moodle
    - MOODOLE_DB_PASS=moodle
    - MOODOLE_DB_PORT=5432
```

---

**For ARM:**
```
moodledb_rpi:
  image: arm32v7/postgres
  container_name: moodledb_rpi
  ports:
    - "5432:5432"
  environment:
    - POSTGRES_DATABASE=moodle
    - POSTGRES_USER=moodle
    - POSTGRES_PASSWORD=moodle
moodle_rpi:
  image: treehouses/moodle:arm
  container_name: moodle_rpi
  ports:
    - "8080:80"
  links:
    - moodledb_rpi
  environment:
    - MOODLE_URL=http://docker.ole.org:80
```
