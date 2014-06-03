#!/bin/sh

Pids=$(ps aux | grep worker | grep -v grep | awk '{print $2}')
nPids=$(echo $Pids | wc -w)
if [ $nPids != 0 ]
then
    rand=$(($RANDOM % $nPids + 1))
    Pid=$(echo $Pids | cut -d' ' -f$rand)
    echo "Killing pid: " $Pid
    kill $Pid
else
    echo "nothing to kill"
fi
