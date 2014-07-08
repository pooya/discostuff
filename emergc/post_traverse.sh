#!/bin/sh
# Usage: ./post_traverse.sh nodes

rm -rf /tmp/node_blobs
mkdir -p /tmp/node_blobs
for i in $(cat $1)
do
    scp $i:/tmp/blobs /tmp/node_blobs/blobs_$i
done
cd /tmp/node_blobs
cat blobs_* | sort | uniq > all_blobs

rm -rf /tmp/per_node_blobs
mkdir /tmp/per_node_blobs

while read a b
do
echo $b >> /tmp/per_node_blobs/$a
done < all_blobs

for file in /tmp/per_node_blobs/*
do
    node=$(basename $file)
    echo "processing node $node"
    echo "==============================================================="
    total_lines=$(wc -l $file | awk '{print $1}')
    for begin in $(seq 1 20000 $total_lines)
    do
        end=$(($begin + 20000))
        blobs=$(sed "$begin,$end!d" $file | awk -F'\\\\$' '{printf "%s ", $1}END{print ""}')
        ssh $node "rm -f $blobs &" || exit 1
    done
    echo "==============================================================="
done
