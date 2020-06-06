from functools import reduce
from operator import mul

def evens_product(L):
    return reduce(mul,(x for x in L if x%2 == 0),1)

def reverse(L):
    join = lambda x,y: [y]+ x
    return reduce(join,(x for x in L),[])

def zip_with(func,L1,L2):
    if len(L1) > len(L2):
        return[func(L1[i],L2[i]) for i in range(len(L2))]
    else:
        return[func(L1[i],L2[i]) for i in range(len(L1))]

def count_if(func,L):
    return len(list(filter(func,L)))

'''
print(evens_product([]))
'''
