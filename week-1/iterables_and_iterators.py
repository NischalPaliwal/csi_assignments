import itertools

n = int(input())
letters = list(input().split(" "))
k = int(input())

combinations = list(itertools.combinations(letters, k))

repitition_a = 0

for c in combinations:
    if 'a' in c:
        repitition_a += 1
        
probability = repitition_a / len(combinations)
print(probability)