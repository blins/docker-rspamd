FROM debian:latest
RUN apt-get update \
    && export DEBIAN_FRONTEND="noninteractive" \
    && apt-get install -y --no-install-recommends ca-certificates gnupg curl \
    && curl -sL https://rspamd.com/apt-stable/gpg.key | apt-key add - \
    && echo "deb http://rspamd.com/apt-stable/ stretch main" > /etc/apt/sources.list.d/rspamd.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends rspamd \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
COPY rspamd.conf /etc/rspamd/rspamd.conf
CMD ["/usr/bin/rspamd","-f", "-u", "_rspamd", "-g", "_rspamd"]

EXPOSE 11333 11334
