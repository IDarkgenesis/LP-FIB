def absValue(x):
    if x < 0:
        res= x*-1
        return res
    else:
        return x

def power(x,p):
    res= x
    if p == 0:
        return 1
    for d in range(1,p):
        res = res * x
    return res

def isPrime(x):
    if x < 2:
        return False
    for d in range(2, x//2 +1):
        if x % d == 0:
            return False
    return True

def slowFib(x):
    if x == 0:
        return 0
    elif x == 1:
        return 1
    else :
        res= slowFib(x-1)+slowFib(x-2)
        return res

def quickFib(x):
    d= [-1 for _ in range(x+1)]
    res= quickFib2(x,d)
    return res

def quickFib2(x,d):
    if x == 0:
        d.insert(x,0)
        return d[0]
    elif x == 1:
        d.insert(x,1)
        return d[1]
    else :
        if(d[x-1] != -1):
            res1=d[x-1]
        else:
            res1= quickFib2(x-1,d)
        if(d[x-2] != -1):
            res2=d[x-2]
        else:
            res2= quickFib2(x-2,d)
        
        d.insert(x,res1+res2)
        return d[x]
