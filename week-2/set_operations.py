n = int(input())
s = set(map(int, input().split()))

c = int(input())

for _ in range(c):
    command_input = input().split()
    command = command_input[0]
    
    if len(command_input) == 2:
        value = int(command_input[1])
    
    if command == 'pop':
        s.pop()
    elif command == 'remove':
        s.remove(value)
    elif command == 'discard':
        s.discard(value)
        
l = list(s)
print(sum(l))