import os, re
from sys import argv

with open(argv[1]) as f:
    narrative = f.readlines()

name = argv[1].replace('.txt', '')
os.mkdir(name)
os.chdir(name)

i = 0
current = 0
narrativeName = name + "Narrative" + str(current + 1) + ".txt"
narrativeFile = open(narrativeName, 'w')
questionName = name + "Question" + str(current + 1) + ".txt"
questionFile = open(questionName, 'w')
seen = 0
while i < len(narrative):
    line = narrative[i]
    i += 1
    if '?' in line:
        current += 1
        if seen < current:
            print(re.sub('^\d+ ', '', line), file = questionFile, end="")
            seen += 1
            if seen == 5:
                break
            narrativeFile.close()
            questionFile.close()
            narrativeName = name + "Narrative" + str(current + 1) + ".txt"
            narrativeFile = open(narrativeName, 'w')
            questionName = name + "Question" + str(current + 1) + ".txt"
            questionFile = open(questionName, 'w')
            i = 0
            current = 0
    else:
        print(re.sub('^\d+ ', '', line), file = narrativeFile, end="")
