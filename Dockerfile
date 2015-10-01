FROM haproxy

COPY run.sh /run.sh

EXPOSE 80
ENTRYPOINT ["/run.sh"]
