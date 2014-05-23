Support for Erlang 17.
=====

Disco now works with Erlang 17.  In order to make disco work on erlang 17, I had
to add type information to all of the data structures.  For example, all of the
dictionaries and sets are now typed.  In this process two bugs in Erlang 17.0 have
been uncovered:

http://erlang.org/pipermail/erlang-bugs/2014-April/004321.html

http://erlang.org/pipermail/erlang-questions/2014-April/078647.html

These types can serve as a good documentation and make dialyzer's job easier.
We still have to use the nowarn_deprecated_type flag with the erlang
compiler becasuse of a dialyzer bug.  Another bug in Erlang 17 was uncovered with
travis-ci builds:

http://erlang.org/pipermail/erlang-bugs/2014-May/004413.html
