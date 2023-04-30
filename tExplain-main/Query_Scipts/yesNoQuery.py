import re, sys

questions = []
adjust = 1

with open(sys.argv[1]) as f:
    narrative = f.readlines()

for line in narrative:
    match = None
    match = re.search(r"(\d+) Is (.*) in the (.*)\?", line)
    if match:
        lineNum = int(match.group(1)) - adjust
        person = match.group(2).lower()
        location = match.group(3).lower()
        questions.append((person, location, lineNum))
        adjust += 1

adjust = 1
for q in questions:
    filename = "query" + str(adjust) + ".lp"
    f = open(filename, "w")
    f.write('%%!show_trace xclingo_not_in_location(%s, %s, %d).\n' % (q[0], q[1], q[2]))
    f.write('%%!show_trace xclingo_in_location(%s, %s, %d).\n' % (q[0], q[1], q[2]))
    f.write('is_aB(%s, %s).\n' % (q[1], q[1]))
    adjust += 1
    f.close()
