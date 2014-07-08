del_tags = []
all_blobs = open("/tmp/blobs", "a")
disco_path= "/tmp/disco/"

def append_tag_file(tag_file):
    import json
    f = open(tag_file)
    d = json.load(f)
    if len(d["urls"]) == 0:
        return
    urls = d["urls"][0]
    for url in urls:
        if url[0:8] == "disco://":
            sp = url.split('/', 3)
            print >> all_blobs, sp[2], "'" + disco_path + sp[3] + "'"

def traverse(root_dir):
    import os
    for root, _, files in os.walk(root_dir):
        if len(root.split('/')[-1]) == 2:
            for tag_file in files:
                if tag_file.split('$')[0] in del_tags:
                    append_tag_file(root + "/" + tag_file)

def read_tag_list(tag_file):
    f = open(tag_file)
    tag_list = []
    for l in f:
        tag_list.append(l.strip())
    global del_tags
    del_tags = set(tag_list)

if __name__ == '__main__':
    read_tag_list("tags")
    for i in range(6):
        tag_dir = disco_path + "ddfs/vol%d/tag" % i
        traverse(tag_dir)
