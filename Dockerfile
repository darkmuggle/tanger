FROM registry.fedoraproject.org/fedora-minimal:32

VOLUME /var/db/tang
VOLUME /var/cache/tang

RUN microdnf install -y \
        clevis tang \
        dumb-init \
        socat && \
        microdnf clean all && rm -rf /var/cache/yum

COPY run.sh /usr/local/sbin

ENV PORT=80

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/usr/local/sbin/run.sh"]
