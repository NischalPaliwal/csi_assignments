def print_formatted(number):
    width = len(bin(number)[2:])
    for i in range(1, number + 1):
        bin_value = bin(i)[2:]
        hex_value = hex(i).upper()[2:]
        oct_value = oct(i)[2:]
        print(f"{i:>{width}} {oct_value:>{width}} {hex_value:>{width}} {bin_value:>{width}}")

if __name__ == '__main__':
    n = int(input())
    print_formatted(n)