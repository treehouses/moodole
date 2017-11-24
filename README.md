# moodole
Moodle Docker for Raspberry Pi

https://hub.docker.com/r/treehouses/moodle/

Moodle E Learning running on ARM with Raspberry Pi by Open Learning Exchange

---

**For x86**
```
# moodledb is the database host
moodledb:
  image: mysql
  container_name: moodledb
  ports:
    - "4000:3306"
  environment:
    - MYSQL_DATABASE=moodle
    - MYSQL_USER=moodle
    - MYSQL_PASSWORD=moodle
    - MYSQL_ALLOW_EMPTY_PASSWORD=yes
moodle:
  image: treehouses/moodle:x86
  container_name: moodle
  ports:
    - "80:80"
  links:
    - moodledb
  environment:
    - MOODLE_URL=http://127.0.0.1:80 
```

---

**For ARM: **
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
