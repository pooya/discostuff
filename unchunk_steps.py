from io import BytesIO
import zlib
import struct
import cPickle


if __name__ == "__main__":
    f = open("out.bin")
    s = f.read()
    version, is_compressed, checksum, hunk_size = struct.unpack("<BBIQ", s[:14])
    hunk = s[14: 14 + hunk_size]
    import zlib
    n1hunk = zlib.decompress(hunk)
    n2hunk = BytesIO(n1hunk)
    record = cPickle.load(n2hunk)
    print record
