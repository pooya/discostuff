#!/bin/sh

# Usage: ./cookie.sh nodes

# where nodes is a file that includes the name of the slave nodes.

for node in $(cat $1)
do
    echo $node
    ssh $node "yes | rm -f ~/.erlang.cookie" || exit 1
    scp ~/.erlang.cookie $node: || exit 1
done
