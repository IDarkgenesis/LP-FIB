from itertools import count 

def my_map(func,L):
    return [func(x) for x in L]

def my_filter(func,L):
    return [x for x in L if func(x)]

def factors(n):
    return [x for x in range(1,n+1) if n%x == 0]
    
def triplets(n):
    return [(x,y,z) for x in range(1,n+1) for y in range(1,n+1) for z in range(1,n+1) if x**2+y**2  == z**2]
    
'''
print(triplets(1))
'''
