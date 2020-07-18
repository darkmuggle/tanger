FROM fedora

VOLUME /var/db/tang
VOLUME /var/cache/tang

RUN dnf install -y \
        clevis tang \
        dumb-init \
        socat

COPY run.sh /usr/local/sbin

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/usr/local/sbin/run.sh"]
