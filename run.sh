#!/bin/bash
export PORT="${PORT:-80}"

if [ ! $(ls -1 /var/db/tang/*jwk) > /dev/null 2>&1 ]; then
    echo "Generating tang keys"
    /usr/libexec/tangd-keygen /var/db/tang
fi

/usr/libexec/tangd-update /var/db/tang /var/cache/tang
me=$(whoami | id -u)
chown -Rv "${me}:${me}" /var/db/tang /var/cache/tang

while /bin/true;
do
    socat -v tcp-l:${PORT},fork exec:"/usr/libexec/tangd /var/cache/tang",su="${me}"
done
