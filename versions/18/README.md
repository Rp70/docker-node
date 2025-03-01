# Node Docker image with advanced customs
- Versions: 18
- Container base: Debian, slim image.

## Features
- Overwrite files from host to container on every start, by mounting files from host to inside /entrypoint/overwrite//
- Replace environment-like string in files using environment variables passed to the container. 
- Change uid and gid of node to match current dir's owner
- [not-tested] Use rsyslog socket if available

