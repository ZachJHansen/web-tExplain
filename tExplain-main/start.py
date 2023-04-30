#!/bin/python3

SEARCH_PATTERN="[main] INFO CoreNLP - StanfordCoreNLPServer listening at"


import subprocess
import os

current_dir = os.getcwd()
dir = [ f for f in os.listdir('resources') if f.startswith('stanford-corenlp-')][-1]
dir = os.path.join(current_dir,'resources',dir)
os.chdir(dir)
print(os.getcwd())

with subprocess.Popen(['java', '-mx4g', '-cp', '*', 'edu.stanford.nlp.pipeline.StanfordCoreNLPServer', '-port', '9001', '-timeout', '45000'],
                     stdout=subprocess.PIPE, 
                     stderr=subprocess.PIPE) as process:
    while(True):
        line = process.stderr.readline().decode('UTF-8')
        if line.startswith(SEARCH_PATTERN):
            break
print("DONE")

# stdout, stderr = process.communicate()
# print('[here]')
# print(stdout)
# print(stderr)