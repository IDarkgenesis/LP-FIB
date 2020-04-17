def count_unique(L):
    return sum(map(count < 2,L))

#Test
print(count_unique([1, 3, 2, 2, 3, 4]))
