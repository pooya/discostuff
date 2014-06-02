#!/bin/sh

# Usage: ./cookie.sh nodes
# tries to kill a couple of workers in the cluster.
# You should set the CHAOS environment variable before starting this script.

for node in $(cat $1)
do
    echo -n "Node $node "
    ssh $node "$CHAOS"
done
