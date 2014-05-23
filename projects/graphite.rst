Graphite Integration
======

Graphite is a tool used for monitoring the status of the system.  A system
can send arbitrary data point to Graphite and they will be compiled into
graphs on the remote node.  In order to integrate disco with graphite, we
used the folsomite tool.  Folsomite is a tool that uses folsom and among
other things, can be used to export different data points to a Graphite
server.
This functionality is diabled by default but can be enabled by setting the
remote host and an environment variable.
