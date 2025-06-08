import itertools

input_str = input()

grouped_str = itertools.groupby(input_str)

result = ""

for key, group in grouped_str:
    result += f"({len(list(group))}, {key}) "
    
print(result)