import re, sys

questions = []
adjust = 1

with open(sys.argv[1]) as f:
    narrative = f.readlines()

for line in narrative:
    match = None
    match = re.search(r"(\d+) .* is (.*) carrying\?", line)
    if match:
        lineNum = int(match.group(1)) - adjust
        person = match.group(2).lower()
        questions.append((person, lineNum))
        adjust += 1

adjust = 1
for q in questions:
    filename = "query" + str(adjust) + ".lp"
    f = open(filename, "w")
    f.write('%%!show_trace entityCarrying(N, %s, %d).\n' % (q[0], q[1]))
    adjust += 1
    f.close()
