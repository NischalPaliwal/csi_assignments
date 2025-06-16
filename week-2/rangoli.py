import string

def print_rangoli(size):
    my_list = sorted(string.ascii_lowercase[:size], reverse=True)
    
    length = size + (size - 1) * 3    
    
    my_str = []
    
    for i in range(size):
        mark = my_list[i]
        my_str.insert(len(my_str) // 2, mark)
        print('-'.join(my_str).center(length, '-'))
        my_str.insert(-i, mark)
        
    my_str.remove(my_list[-1])    
    
    for i in range(size-1):
        my_str.pop(len(my_str) // 2)
        my_str.pop(len(my_str) // 2)
        print('-'.join(my_str).center(length, '-'))

if __name__ == '__main__':
    n = int(input())
    print_rangoli(n)