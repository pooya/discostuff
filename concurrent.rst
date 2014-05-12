Disco Concurrent Stages
===========

Failure Recovery
----------

In the concurrent stage model, the failure recovery is kept simple to control the
complexity in the first iteration.

If a task fails, all of the tasks that have consumed the outputs of this task will fail.
No matter they have finished or not.

instead of t_00 --> t'_00  is created.

if a task of the next stage has not consumed the output of this task, there is
no need to fail it.

It is assumed that the order of the inputs is not important.  The inputs will be
consumed as soon as they are available.


.. image:: images/S0_failure.png
    :height: 400px
    :width: 800px
    :align: center
    :scale: 75 %
    :alt: a task in the first stage fails


.. image:: images/S0_failure_recovery.png
    :height: 400px
    :width: 800px
    :align: center
    :scale: 75 %
    :alt: recovery from the previous failure
