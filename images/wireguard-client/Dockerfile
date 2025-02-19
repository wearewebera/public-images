FROM webera/base

RUN apt update && \
    apt install -y wireguard-tools \
                   iproute2

ENTRYPOINT [ "/usr/bin/bash", "-c", "wg-quick up /etc/wireguard/wg0.conf && tail -f /dev/null" ]