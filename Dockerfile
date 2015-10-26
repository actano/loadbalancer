FROM haproxy

COPY run.sh /run.sh
ENTRYPOINT ["/run.sh"]
