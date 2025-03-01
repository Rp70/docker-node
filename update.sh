#!/usr/bin/env bash
set -e

cd versions
versions=( "$@" )
if [ ${#versions[@]} -eq 0 ]; then
    versions=( */ )
fi
versions=( "${versions[@]%/}" )
cd ..

for version in "${versions[@]}"; do
    echo "Updating $version"
    (
      rm -rf versions/$version
      mkdir -p versions/$version
      cp -ar README.md template/* versions/$version/
      sed -i -e 's/{{ version }}/'$version'/g' versions/$version/Dockerfile
    )
done
