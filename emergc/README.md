Deleting the blobs of the deleted tags
======================================

Note: This approach only works when the blobs are not pointed at by more than
one tag.

Step 1
======

Run the following commands on the erlang shell of disco debug on the master:
```
    Tags = element(2, sys:get_state(whereis(ddfs_master))).
    Pid = gb_trees:get(<<"+deleted">>, Tags).
    {ok, Content} = element(3, sys:get_state(Pid)).
    Data = element(6, Content).
    Path = "/tmp/out".
    file:write_file(Path, Data).
```

The will write write the content of the deleted tags into the /tmp/out file.


Step 2
======
Fix the format of the deleted tags:
```
    sed -e 's/tag:\/\//\n/g' /tmp/out > tags
```
In this new file format, each line includes a deleted tag name. You might want to
take a look at these tags and remove any tags that might point to some blobs
that might be still in use. You may also choose some parts of these tags to
break down the gc operation.

Step 3
======
Run the traverse_all.sh script to go through all of the tag files in all of the
nodes in the cluster and extract the location of the blobs in these tag files.
These blob locations will be set in a file named /tmp/blobs. This operation will
take some time.


Step 4
======
When the operations in step 3 finish (you have to manually check to see if they
have finished), you can start this step. Please note that even if the operations
in step 3 do not finish, you can go ahead with this step but it will not remove
all of the deleted blobs. In this step, run the post_traverse.sh script to
actually delete the blobs.
Note: We issue a single rm command per node because it should be significantly
faster than issuing multiple rm commands. This requires a recent system with an
rm command that accepts a large number of inputs.

