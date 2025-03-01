#!/usr/bin/env bash

# Replace environment-like string in files using environment variables passed to the container.

set -e

ENVIRONMENT_REPLACE=${ENVIRONMENT_REPLACE:=''}
if [ "$ENVIRONMENT_REPLACE" != '' ]; then
	SHELLFORMAT='';
	for varname in `env | cut -d'='  -f 1`; do
		SHELLFORMAT="\$$varname $SHELLFORMAT";
	done
	SHELLFORMAT="'$SHELLFORMAT'"
	
	for envfile in $ENVIRONMENT_REPLACE; do
		echo "Replacing variables in $envfile"
		for configfile in `find $envfile -type f ! -path '*~'`; do
			echo $configfile
			# This will mess files with escaped chars.
			# It will mess: return 200 'User-Agent: *\nDisallow: /';
			#content=`cat $configfile`
			#echo "$content" | envsubst "$SHELLFORMAT" > $configfile
			
			# Temp file is slow but won't mess files with escaped chars.
			cp -f $configfile /dev/shm/envsubst.tmp
			envsubst "$SHELLFORMAT" < /dev/shm/envsubst.tmp > $configfile
		done
	done
	
	rm -f /dev/shm/envsubst.tmp
fi
