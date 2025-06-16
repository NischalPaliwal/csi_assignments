def merge_the_tools(string, k):
    n = len(string)
    no_parts = n // k
    start = 0
    
    for i in range(no_parts):
        end = start + k
        s = string[start:end]
        seen = set()
        s = ''.join([char for char in s if not (char in seen or seen.add(char))])
        print(s)
        start = end

if __name__ == '__main__':
    string, k = input(), int(input())
    merge_the_tools(string, k)