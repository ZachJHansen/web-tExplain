import os, glob, sys
from sys import argv

directory = os.path.dirname(argv[1])
filename = os.path.basename(argv[1])

# print("directory", directory)
# print("filename", filename)

regex = filename + "*.tp.lp"

file_list = glob.glob(os.path.join(os.getcwd(), directory, regex))
query_list = glob.glob(os.path.join(os.getcwd(), "query*.lp"))

# print("file_list", file_list)
# print("query_list", query_list)

file_list.sort()
query_list.sort()
for f, q in zip(file_list, query_list):
    command = "xclingo -n 0 0 %s %s %s" % (f, q, "trace-rule.lp")
    # print(command)
    os.system(command)