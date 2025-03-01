#!/usr/bin/env bash

CMD=${CMD:=$1}
RUN_AS_USER=${RUN_AS_USER:='node'}
RUN_AS_GROUP=${RUN_AS_GROUP:='node'}

set -e
if [ "$STARTUP_DEBUG" = 'yes' ]; then
    set -x
fi

if [ -e /entrypoint-hook-start.sh ]; then
	. /entrypoint-hook-start.sh
fi

for f in /docker-entrypoint-init.d/*.sh; do
    . "$f"
done

if [ -e /entrypoint-hook-end.sh ]; then
	. /entrypoint-hook-end.sh
fi

# Correct broken stuff caused by hooks, inherited docker images, mounts from host.
chmod a+rwxt /tmp

# Run command
if [ "$CMD" != 'startup' ]; then
    exec gosu $RUN_AS_USER:$RUN_AS_GROUP "$@"
    exit $?
else
    shift
fi


exec gosu $RUN_AS_USER:$RUN_AS_GROUP /usr/local/bin/docker-entrypoint.sh "$@"
