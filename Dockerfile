FROM i386/ubuntu:latest AS base
RUN export DEBIAN_FRONTEND=noninteractive && \
    echo tzdata tzdata/Zones/Europe select London | debconf-set-selections && \
    echo tzdata tzdata/Zones/Etc select UTC | debconf-set-selections && \
    apt-get update && apt-get install -y \
    libmysqlclient20 \
    liblua5.1 \
    build-essential \
    make \
    libmysqlclient-dev \
    lua5.1 \
    mysql-client-5.7 \
    rsync \
    cron \
    nano && \
    apt-get clean

FROM base AS rtk
LABEL prune=true
COPY cron-init.sh /usr/local/app/entrypoint/cron-init.sh
COPY crontab /etc/cron.d/crontab
COPY ./rtk /root/rtk
RUN cd /root/rtk && \
    make all && \
    chmod +x /root/rtk/check-mithia-server-state && \
    chmod +x /root/rtk/shutdown-mithia-servers && \
    chmod +x /root/rtk/login-server && \
    chmod +x /root/rtk/char-server && \
    chmod +x /root/rtk/map-server && \
    chmod +x /usr/local/app/entrypoint/cron-init.sh && \
    chmod 0644 /etc/cron.d/crontab && \
    touch /var/log/cron.log
