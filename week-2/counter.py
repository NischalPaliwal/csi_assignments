from collections import Counter

no_of_shoes = int(input())
shoe_sizes = input().split()
size_counter = Counter(shoe_sizes)
no_of_customers = int(input())

purchases = []

for i in range(no_of_customers):
    size, price = input().split()
    if size_counter[size] > 0:
        purchases.append(int(price))
        size_counter[size] -= 1
        
print(sum(purchases))