import os, glob
from sys import argv

# print(os.getcwd())

file_list = glob.glob(os.path.join(os.getcwd(), argv[1], "*Narrative*.txt"))
file_list.sort()

filename = os.path.basename(argv[1])
print(filename)

for f in file_list:
    print(f)
    command = "./logic.sh " + f + " " + filename
    os.system(command)