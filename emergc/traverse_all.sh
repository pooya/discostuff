#!/bin/sh
# Usage: ./traverse_all.sh nodes

for node in $(cat $1)
do
    scp tags $node:
    scp traverse.py $node:
    ssh $node "rm -f /tmp/blobs"
    ssh $node "python traverse.py &"
done
