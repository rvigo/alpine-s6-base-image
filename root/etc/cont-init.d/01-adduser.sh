#!/usr/bin/with-contenv sh

PUID=${PUID:-777}
PGID=${PGID:-777}

/usr/sbin/usermod -o -u "$PUID" abc
/usr/sbin/groupmod -o -g "$PGID" abc


echo '
-------------------------------------
GID/UID
-------------------------------------'
echo "
User uid:    $(id -u abc)
User gid:    $(id -g abc)
-------------------------------------
"

chown abc:abc /app
chown abc:abc /config
chown abc:abc /defaults
