FROM debian:buster-slim
ENV TINI_VERSION=0.18.0
COPY haproxy-run /etc/service/haproxy/run
COPY rspamd-run /etc/service/rspamd/run
COPY run.sh /run.sh

RUN apt-get update \
    && export DEBIAN_FRONTEND="noninteractive" \
    && apt-get install -y --no-install-recommends ca-certificates gnupg curl \
    && curl -sL https://rspamd.com/apt-stable/gpg.key | apt-key add - \
    && echo "deb http://rspamd.com/apt-stable/ buster main" > /etc/apt/sources.list.d/rspamd.list \
    && echo "deb http://http.debian.net/debian buster-backports contrib non-free main" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends -t buster-backports haproxy runit procps \
    && apt-get install -y rspamd \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
	&& chmod +x /etc/service/haproxy/run /etc/service/rspamd/run \
	&& curl -s -L -o /tmp/tini_${TINI_VERSION}-amd64.deb https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}-amd64.deb \
	&& dpkg -i /tmp/tini_${TINI_VERSION}-amd64.deb \
	&& rm /tmp/tini_${TINI_VERSION}-amd64.deb \
	&& chmod +x /run.sh

COPY rspamd.conf /etc/rspamd/rspamd.conf

ENTRYPOINT ["tini"]
CMD ["/run.sh"]
