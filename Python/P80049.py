from functools import reduce

def count_unique(L):
    return len(set(L))

def remove_duplicates(L):
    norep= set(L)
    return [x for x in norep]
    
def flatten(L):
    join = lambda x,y: x+y
    return reduce(join,L,[])

def flatten_rec(L):
    return sum( ([x] if not isinstance(x,list) else flatten_rec(x) for x in L), [] )

'''
print(flatten_rec([3, [1], [], [4, [], [5, 3]], [2, 1]]))
'''
