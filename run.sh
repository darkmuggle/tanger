#!/bin/bash

if [ ! $(ls -1 /var/db/tang/*jwk) > /dev/null 2>&1 ]; then
    echo "Generating tang keys"
    /usr/libexec/tangd-keygen /var/db/tang
fi

/usr/libexec/tangd-update /var/db/tang /var/cache/tang
chown -Rv tang:tang /var/db/tang /var/cache/tang

(sleep 3; /usr/bin/tang-show-keys) &

while /bin/true;
do
    socat -v tcp-l:80,fork exec:"/usr/libexec/tangd /var/cache/tang",su=tang
done
