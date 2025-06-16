import re

n = int(input())

def valid(pattern):
    try:
        re.compile(pattern)
        return True
    except re.error:
        return False

for i in range(n):
    p = r'{}'.format(input())
    print(valid(p))