#!/bin/bash

OUT=/tmp/out
SETTING_FILE=/etc/disco/settings.py

cd disco
find . -name '*.beam' | sudo xargs rm -f
find . -name '*.pyc' | sudo xargs rm -f

cd lib || exit 2
sudo python setup.py install || exit 3
cd ..

sudo gmake install || exit 5
sudo gmake install-tests || exit 5
sudo chown -R $USER /usr/local/var/disco
sudo sed -i "s/= 3/= 1/g" $SETTING_FILE
disco start || exit 6

cd tests
python testcases.py | cut -d'.' -f1 | sort | uniq | while read test; do
  grep -q $test ../../shayan/blacklist
  if [ $? -eq 0 ]
  then
      echo "Skipping test $test"
      continue
  fi
  echo -n "disco test $test "
  disco test $test 2>$OUT
  tail -n 1 $OUT | grep OK
  if [ $? -ne 0 ]
  then
    echo "failed."
    exit 7
  fi
done

pgrep beam | xargs kill
