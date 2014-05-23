Add an XML reader to Disco and an example for parsing Wikipedia corpus:
=========

The example shows the usage of Disco for running tasks on a huge data set
like all of the pages of English Wikipedia.  The example is available in the
main Disco source code repository.  The input that the Wikimedia foundation
publishes is in XML format, therefore, we had to add a parser to consume
this input and run different jobs on them.

We had to create a mechanism to consume this input even though the size of
the input is much larger than the available memory.
