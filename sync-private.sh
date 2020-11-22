#!/usr/bin/env bash

# A script to sync a subset of private notes to be published
# Add new private notes at the end of this file.

set -e

ZK=$HOME/Documents/zk

assert_imported () {
    # The "imported" YAML field is just to remind myself not to edit this
    # manually (outside of private Zettelkasten, from which it is copied over)
    (grep "imported: true" "${ZK}/$1.md" > /dev/null) || (echo "error: not flagged as imported: $1"; exit 2)
}

cpnote () {
    assert_imported "$1"
    cp -v "${ZK}/$1.md" ./$2.md
}

cpnote "Linux logs from previous boot" last-boot-logs