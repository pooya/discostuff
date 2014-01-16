#!/bin/bash

OUT=/tmp/out
DISCO_PATH=/home/shayan/disco

cd $DISCO_PATH/lib || exit 2
sudo python setup.py install || exit 3

cd $DISCO_PATH
COMMIT_SHA=$(git log -1 | head -n 1 | cut -f2 -d' ')
echo $COMMIT_SHA

sudo make install || exit 1
Commands="cd $DISCO_PATH &&\
        git fetch &&\
        git checkout $COMMIT_SHA &&\
        sudo make install-node &&\
        cd $DISCO_PATH/lib &&\
        sudo python setup.py install"

while read node; do
    echo "Going to execute $Commands on $node"
    ssh  </dev/null $node $Commands
     ret=$?
     if [ $ret -ne 0 ]
     then
        echo "Node $node failed with $ret"
        exit 2
     fi
done < $DISCO_PATH/nodes

disco start || exit 1

for i in 1
do
    while read test; do
      echo "disco test $test"
      disco test $test 2>$OUT
      tail -n 1 $OUT | grep OK
      if [ $? -ne 0 ]
      then
        exit 1
      fi
    done < $DISCO_PATH/testcases
done

pgrep beam | xargs kill
