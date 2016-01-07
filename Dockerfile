FROM haproxy:1.6.3

COPY run.sh /run.sh
ENTRYPOINT ["/run.sh"]
