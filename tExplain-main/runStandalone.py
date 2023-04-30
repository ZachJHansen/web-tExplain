import os, glob, configparser, re, shutil
from sys import argv

#1 – Single Supporting Facts
#2 – Two Supporting Facts
#3 – Three Supporting Facts
#5 – Three Argument Relations 
#6 – Yes/No Questions 
#7 – Counting 
#8 – Lists/Sets 
valid = [2,3,6,7]

def getLogicPrograms(filename):
    regex = filename + ".txt"
    file_list = glob.glob(os.path.join(os.getcwd(), directory, regex))
    file_list.sort()
    # print(file_list)

    for f in file_list:
        # print(f)
        command = "./logic.sh " + f + " " + filename
        os.system(command)

def xclingo():
    directory = "%s/%s" % (logicDir, filename)

    regex = filename + "*.tp.lp"

    file_list = glob.glob(os.path.join(os.getcwd(), directory, regex))

    # print("file_list", file_list)

    file_list.sort()

    specificXclingoDir = xclingoDir + "/" + filename
    if os.path.exists(specificXclingoDir):
        shutil.rmtree(specificXclingoDir)
    os.mkdir(specificXclingoDir)

    for f in file_list:
        outputfile = os.path.basename(f).replace('.tp.lp', '.txt')
        outputfile = specificXclingoDir + "/" + outputfile

        command = "xclingo -n 0 0 %s %s > %s" % (f, "trace-rule.lp", outputfile)
        os.system(command)

filename = os.path.basename(argv[1]).replace('.txt', '')
directory = os.path.dirname(argv[1])

with open(argv[1]) as f:
    narrative = f.readlines()

config = configparser.ConfigParser()
config.read("config.ini")
logicDir = config['APP']['logicprogram_directory']
xclingoDir = config['APP']['xclingo_directory']



# GENERATE LOGIC PROGRAMS
getLogicPrograms(filename)

# RUN XCLINGO
xclingo()
