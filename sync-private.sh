#!/usr/bin/env bash

# A script to sync a subset of private notes to be published
# Add new private notes at the end of this file.

set -e

ZK=$HOME/Documents/zk

assert_imported () {
    # Only import notes with "slug" field, which explicitly indicates that they
    # are to be published by neuron.
    (head -n 2 "$1" | grep "slug: " > /dev/null) \
        || (echo "error: needs slug to publish: $1"; exit 2)
}

cpnote () {
    assert_imported "$1"
    cp -v "$1" ./
}

rg --null -lU "^---\nslug: " $ZK | while IFS= read -r -d '' notefile; 
do
    cpnote "${notefile}"
done