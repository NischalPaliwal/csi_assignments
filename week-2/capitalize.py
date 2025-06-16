import os

def solve(s):
    list = s.split(' ')
    for i in range(len(list)):
        list[i] = list[i].capitalize()
    return " ".join(list)

if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')
    s = input()
    result = solve(s)
    fptr.write(result + '\n')
    fptr.close()