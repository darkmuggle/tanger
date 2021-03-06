#!/bin/bash
export PORT="${PORT:-80}"

if [ ! $(ls -1 /var/db/tang/*jwk) > /dev/null 2>&1 ]; then
    echo "Generating tang keys"
    /usr/libexec/tangd-keygen /var/db/tang
fi

/usr/libexec/tangd-update /var/db/tang /var/cache/tang

(sleep 5; out="$(/usr/bin/tang-show-keys ${PORT})"; sleep 1; cat <<EOM


============================================
Thumbprint: ${out}
      Port: ${PORT}
============================================
EOM
) &

while /bin/true;
do
    socat -v tcp-l:${PORT},fork exec:"/usr/libexec/tangd /var/cache/tang"
done
