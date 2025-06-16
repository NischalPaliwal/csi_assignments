n = int(input())

for i in range(n):
    try: 
        a, b = input().split()
        a = int(a)
        b = int(b)
        q = a // b
        print(q)
    
    except ZeroDivisionError as e:
        print("Error Code:", e)
    
    except ValueError as e:
        print("Error Code:", e)