#!/usr/bin/env bash

# Overwriting files inside container if there are any files mounted inside /entrypoint/overwrite folder, on every start.

set -e

if [ -d /entrypoint/overwrite ]; then
	echo "Overwriting files (if any)"
	cp -fvab /entrypoint/overwrite/* /
	echo
fi
