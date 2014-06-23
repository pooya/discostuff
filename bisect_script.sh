#!/bin/bash

OUT=/tmp/out
DISCO_PATH=/home/shayan/disco
DISCO_ROOT="/usr/var/disco"

cd $DISCO_PATH/lib || exit 2
sudo python setup.py install || exit 3

cd $DISCO_PATH
COMMIT_SHA=$(git log -1 | head -n 1 | cut -f2 -d' ')
echo $COMMIT_SHA

Commands="cd $DISCO_PATH &&\
        git fetch origin &&\
        git fetch upstream &&\
        git checkout $COMMIT_SHA &&\
        yes no | sudo make uninstall &&\
        sudo make install &&
        sudo make install-node &&\
        sudo chown -R $USER $DISCO_ROOT &&\
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

yes no | sudo make uninstall || exit 1
sudo make install || exit 1
sudo make install-tests || exit 1
sudo make install-examples || exit 1
sudo chown -R $USER $DISCO_ROOT || exit 1

disco start || exit 1

for i in 1
do
    cd $DISCO_PATH/tests/ && python testcases.py  | cut -d'.' -f1 | sort | uniq | while read test; do
      grep -q $test $DISCO_PATH/tests/blacklist
      if [ $? -eq 0 ]
      then
          echo "Skipping test $test"
          continue
      fi
      echo "disco test $test"
      disco test $test 2>$OUT
      tail -n 1 $OUT | grep OK
      if [ $? -ne 0 ]
      then
        exit 1
      fi
    done
done

pgrep beam | xargs kill
