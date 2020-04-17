def myLength(l):
    return len(l)

def myMaximum(l):
    mx=l[0];
    for i in range(1, len(l)):
        if mx < l[i]:
            mx= l[i]
    return mx

def average(l):
    count=0;
    for i in range(0, len(l)):
        count += l[i]
    return count/len(l)

def buildPalindrome(l):
    aux=[]
    for i in range(-1, -len(l)-1,-1):
        aux.append(l[i])
    for i in range(0, len(l)):
        aux.append(l[i])
    return aux

def flatten(l):
    return flattenP(l,[])

def flattenP(e,r):
    if(isinstance(e,list)):
        aux=[]
        for i in range(0, len(e)):
            aux= flattenP(e[i],aux)
        return r + aux
    else:
        return r + [e] 

def remove(elem,rem):
    res=[]
    for e in elem:
        if e not in rem:
            res.append(e)
    return res
    
def oddsNevens(elem):
    odd=[]
    even=[]
    for i in range(0, len(elem)):
        if (elem[i] % 2) == 0:
            even.append(elem[i])
        else:
            odd.append(elem[i])
    return (odd,even)

def primeDivisors(n):
    div= [d for d in range(2, 1 + n//2) if n%d == 0] + [n]
    return [p for p in div if isPrime(p)]

def isPrime(n):
    if n <= 1:
        return False
    for d in range(2,n,1):
        if(n%d == 0):
            return False
    return True
