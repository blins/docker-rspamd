#!/bin/sh
exec 2>&1

export PATH=/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin

[ -z "$HOSTNAME" ] || hostname $HOSTNAME

exec runsvdir -P /etc/service 'log: ...........................................................................................................................................................................................................................................................................................................................................................................................................'