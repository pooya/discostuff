#!/bin/sh

PYTHON="/usr/bin/python"
PYTHON26="/usr/bin/python2.6"

for node in $(cat $1)
do
    echo "changing python at $node"
    ssh $node "sudo cp $PYTHON26 $PYTHON"
done
