Profile and speed up the Disco tasks.
=====

Use python string split instead of regex for parsing sorted files.
Regex will be very slow for large key value pairs.
Fsync is only necessary when we are concerned about losing data when system
crashes and it is not a concern for the output of disk sort.
