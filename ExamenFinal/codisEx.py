#from functools import reduce


#def my_map(f,s):
    #return reduce(lambda l,act: l + [f(act)], s , [])

#def my_filter(f,s):
    #return reduce(lambda l,act: l + [act], (x for x in s if f(x)), [])

#def myfilter ( predicate , sequence ):
    #return reduce(lambda a, x : a + [x] if predicate (x) else a , sequence , [])

#def something(n):
    #return n+1

#def isOdd(n):
    #return (n%2) != 0

#print(my_map(something,[1,2,3,4,5]))
#print(my_filter(isOdd,[1,2,3,4,5]))
#print(myfilter(isOdd,[1,2,3,4,5]))
