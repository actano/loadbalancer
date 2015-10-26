# Loadbalancer

This repository provides a loadbalancer in a docker container with is able to be reconfigured on the fly, i.e.
without packet loss.

## Usage

### Building docker image

    docker build -t actano/loadbalancer .

### Starting container
To start a haproxy listening on port 80 using the config file `./haproxy.cfg`

    docker run -d --name loadbalancer -p 80:80 -v `PWD`/haproxy.cfg:/etc/haproxy/haproxy.cfg:ro actano/loadbalancer

### Graceful reconfiguration
To reconfigure haproxy without packet loss, change the config file which is mounted into the container
and send the `SIGHUP` signal to the running container:

    docker kill -s SIGHUP loadbalancer

To be more resilient the config file is checked for validity before doing the switch. If the updated config
is invalid the proxy keeps running with the old settings.
