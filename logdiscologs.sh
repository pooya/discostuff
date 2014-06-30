#!/bin/sh

LogPath="/var/log/disco"

Date=20$(date --date="1 days ago" +"%y-%m-%d")
Dir=$(mktemp -d)

echo "Dir " $Dir " Date " $Date
cp ${LogPath}/disco.log.$Date* $Dir || exit 1
tar cfz ${Dir}.tar.gz $Dir || exit 2
ddfs push disco:logs:$Date ${Dir}.tar.gz
