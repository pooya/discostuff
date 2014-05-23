DDfs Rebalance.
====

This project was done by a Google Summer of Code student in Summer 2013.
However, certain functionalities were missing and there were a couple of
bugs in the source code.  We brought this project to work on top of the
latest version of Disco and merged it into the mainline repository.
In this project, we assign priorities to different nodes in the cluster and
optionaly send the new files (blobs) to the higher-priority nodes to balance the
cluster.  Moreover, when the new nodes are added, we rebalance the current
files (blobs) to these new nodes.
This feature is essential in the elastic environments like Amazon Elastic
Cloud (EC2) where nodes come and go and Disco should be able to utilize the
capacity of the new nodes more carefully.
