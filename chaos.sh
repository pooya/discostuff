#!/bin/sh

Pids=$(ps -eo pid,fname,cmd | grep worker | grep -v grep | sed 's/^ *//' | cut -d' ' -f1)
nPids=$(echo $Pids | wc -w)
if [ $nPids != 0 ]
then
    rand=$(($RANDOM % $nPids + 1))
    Pid=$(echo $Pids | cut -d' ' -f$rand)
    echo "Killing pid: " $Pid
    kill $Pid
    sleep 1
else
    echo "nothing to kill"
fi
