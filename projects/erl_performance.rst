Erlang perf improvements
=====

Erlang is only used as the control plane in Disco.  However, it still was
the bottleneck in some of the operations we needed.  Therefore, we spent
some time finding and fixing these bottlenecks.  More info about this
performance issue and the tools we consulted are available at:
http://pooya.github.io/erlang/debug/2014/03/09/debuggin-an_erlang-performance-issue.html
