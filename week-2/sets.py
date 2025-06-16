def average(array):
    heights = set(array)
    total = sum(heights)
    n = len(heights)
    if n == 0:
        return 0
    avg = total / n
    return round(avg, 3)

if __name__ == '__main__':
    n = int(input())
    arr = list(map(int, input().split()))
    result = average(arr)
    print(result)