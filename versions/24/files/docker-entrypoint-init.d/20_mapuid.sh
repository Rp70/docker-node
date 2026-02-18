#!/usr/bin/env bash

# Change uid and gid of node to match current dir's owner

set -e

MAP_WWW_UID=${MAP_WWW_UID:='no'}
if [ "$MAP_WWW_UID" != "no" ]; then
    if [ ! -d "$MAP_WWW_UID" ]; then
        MAP_WWW_UID=$PWD
    fi

    uid=$(stat -c '%u' "$MAP_WWW_UID")
    gid=$(stat -c '%g' "$MAP_WWW_UID")

    usermod -u $uid node 2> /dev/null && {
      groupmod -g $gid node 2> /dev/null || usermod -a -G $gid node
    }
    chown -cR node:node /home/node
fi
