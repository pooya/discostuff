#!/bin/sh

# Usage: ./healthcheck.sh nodes

# where nodes is a file that includes the name of the slave nodes like:

# $ cat nodes
# dev01
# dev02
# dev03

DISCO_NOT_INSTALLED=1
COMPILE_ERROR=2
CANNOT_SSH=3
NO_ERL_ON_MASTER=4
NO_ERL_ON_SLAVE=5
PING_FAILED=6

disco >/dev/null || exit $DISCO_NOT_INSTALLED

cat > pinger.erl <<EOF
-module(pinger).
-export([pingit/1]).

pingit([Node]) ->
    Remote = lists:flatten(io_lib:format("~w@~w", [slave, Node])),
    pong = net_adm:ping(list_to_atom(Remote)).
EOF

cat > pingee.erl <<EOF
-module(pingee).
-export([start/0]).

start() ->
    timer:sleep(10000),
    init:stop().
EOF

erl -s init stop -noshell || exit $NO_ERL_ON_MASTER
erl -compile pinger || exit $COMPILE_ERROR
erl -compile pingee || exit $COMPILE_ERROR

for node in $(cat $1)
do
    echo -n "inspecting $node "
    ssh $node "cat /dev/null" || exit $CANNOT_SSH
    ssh $node erl -s init stop -noshell || exit $NO_ERL_ON_SLAVE
    scp -q pingee.erl $node:/tmp/
    ssh $node "cd /tmp && erl -compile pingee && erl -sname slave -s pingee "\
                "start -noshell -detached" >>possible_error
    sleep 1
    erl -sname master -noshell -s pinger pingit $node -s init stop || exit $PING_FAILED
    echo "pass"
done
