def fibs():
    a= 0
    yield a
    b= 1
    while True:
        yield b
        a,b = b, a+b

def roots(n):
    a= n
    yield a
    b= 1/2*(a + n/a)
    while True:
        yield b
        a,b=b, 1/2*(b + n/b)

def primes():
    n = 2
    yield n
    while True:
        n+= 1
        if isPrime(n):
            yield n

def hammings():
    n= 1
    yield n
    while True:
        n += 1
        if isHamming(n):
            yield n

def isHamming(n):
    for d in range(2,n+1):
        if n%d == 0 and isPrime(d):
            if d != 2 and d != 3 and d != 5:
                return False
    if n%2 == 0:
        return True
    elif n%3 == 0:
        return True
    elif n%5 == 0:
        return True
    return False

def isPrime(x):
    if x < 2:
        return False
    for d in range(2, x//2 +1):
        if x % d == 0:
            return False
    return True
