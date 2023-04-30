import re, sys

questions = []
adjust = 1

with open(sys.argv[1]) as f:
    narrative = f.readlines()

for line in narrative:
    match = None
    match = re.search(r"(\d+)? .* the (\w+) .* the (\w+)\?", line)
    if match:
        adjust += 1
        object = match.group(2)
        loc2 = match.group(3)
        questions.append((object, loc2))

adjust = 1
print('here')
for q in questions:
    filename = "query" + str(adjust) + ".lp"
    f = open(filename, "w")
    f.write('%%!show_trace changeLoc(%s, L1, %s, T).\n' % (q[0], q[1]))
    adjust += 1
    f.close()
