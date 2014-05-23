Disco Integration with Redis
======
Redis is a popular data structure repository which can be used to store
key-values.  In this project, we added the support for reading the inputs
from redis server(s) and writing outputs to them.  This will be useful for
anyone who has data already in the redis server and wants to run map-reduce
jobs on them or anyone who wants to save the results of a job directly in
Redis.
Moreover, a mechanism has been designed and implemented that lets us use
redis server(s) as a storage service for intermediate results of map-reduce.
Given that the redis servers are memory-backed, this will speed up some
specific map-reduce jobs which can utilize these redis servers.

In Disco The disk accesses can be one of the huge contributing factors in the total
run-time of a lot of jobs.  These disk accesses include (1) reading the inputs,
(2) writing to the outputs and (3) writing and reading the intermediate stage
results.  Internally, disco stores these results in a data directory which may be
on a fast SSD drive.

Instead of building a custom solution, we wanted to use third-party services like
redis to improve this stage of the map-reduce jobs.
While the main redis implementation is bound by the
physical memory, there are other implementations (like ardb) which do not have this
limitation and use different key-value stores (leveldb) to provide more space than the
total physical memory (We use a generic redis client which should work with
different implementations).

One of the problems with this approach is the assignment of the tasks to
different redis servers. Having a centralized server is not a good idea because
it results in always sending data from the producer to the redis server and then
from the redis server to the consumer, even though the producer task and
the consumer task live on the same physical machine.  Instead, we can use a
local redis server per Disco worker node.

Another issue is the lack of namespaces in redis.  We have to make sure that
there is no collision between the outputs of different map-reduce tasks.  This is achieved
by using a separate database id for each task.  One requirement is that each server
has enough databases for all of the tasks of a job.  For example, if a job creates 20,000
map tasks and the results of the maps are stored in redis, the redis servers should
be configured with at least 20,000 databases.

Also, each job assumes that it owns all of the databases on a certain port.  For
running multiple jobs concurrently (all of them using redis for intermediate
results), we have to use a separate redis server (on a different port number).
Also, to prevent such clashes, we will have to use multiple redis servers if a job has
more than one stage that stores the intermediate results in redis.  All of the redis
servers are purged before being used as an intermediate server.

The selection of the redis_server for each task is actually delegated to the creator of
the jobs, but this approach is the best I could come up with.

Different redis servers can also be used as the input or output of a map-reduce
job, but that is not relevant to this discussion and probably not as useful.
