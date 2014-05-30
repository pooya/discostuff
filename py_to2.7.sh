#!/bin/sh

PYTHON="/usr/bin/python"
PYTHON27="/usr/bin/python2.7"

for node in $(cat $1)
do
    echo "changing python at $node"
    ssh $node "sudo cp $PYTHON27 $PYTHON"
done
