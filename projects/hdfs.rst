Disco on top of HDFS
=====

Hdfs or hadoop distributed filesystem is the main filesystem used in the
hadoop ecosystem.  In this project, we added a way for Disco to read the
inputs from HDFS and write the outputs to it.  This integration is in the
core of the Disco project which means all of the workers (not only the
python worker) can use it.
