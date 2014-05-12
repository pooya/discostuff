Disco Concurrent Stages
===========

Failure Recovery
----------

In the concurrent stage model, the failure recovery is kept simple to minimize the
complexity of the implementation.
If a task fails, all of the tasks that could have consumed the outputs of this task
will fail.

For example, consider the following pipeline:
In these figures:
Tasks are shown with boxes. White box means the task has not started yet, orange box
means the task is running, green box means task finished successfully and red box means
the task has failed.

Data is shown with ovals. The green oval means an input that is available for
consumption and white oval means a data that is not available yet.


Tasks t_00 and t_01 belong to the first stage which will run concurrently with
the second stage.  That means, as soon as the outputs of these tasks are
available, they will be consumed by the tasks of the next stage.

.. image:: images/failure_S0.png
    :height: 400px
    :width: 800px
    :align: center
    :scale: 75 %
    :alt: a task in the first stage fails

Now assume task t_00 fails.  The failure is propagated and all of the tasks that
could have consume the inputs of this task will fail.
This means tasks t_10 and t_11 in this figure will fail and restart.

As you see it is a wasteful operation in this case because task t_10 has already
finished successfully. However, in order to simplify the failure recovery, all
of such tasks will be restarted on such a failure.  These failures might
propagate to the future stages if there is any tasks running.

.. image:: images/failure_S0_recovery.png
    :height: 400px
    :width: 800px
    :align: center
    :scale: 75 %
    :alt: recovery from the previous failure


Please note that whether we persist the outputs of a task or not is orthogonal
to the concurrent stages.  We might be able to speed up the pipeline by avoiding
persistence of data on disk, however, if there is a failure, we have to
backtrack and start over the tasks that produced such outputs.

It is also assumed that the order of the inputs is not important.  The inputs will be
consumed as soon as they are available.  Usually if the user does not specify an
order, he or she will not care about the order at all.
