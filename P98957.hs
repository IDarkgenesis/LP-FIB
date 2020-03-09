ones :: [Integer] 
ones = iterate (+0) 1

nats :: [Integer] 
nats = iterate (+1) 0

ints :: [Integer]
ints = 0 : concat (map (\x -> [x , -x]) (iterate (+1) 1) )

triangulars :: [Integer] 
triangulars = map (\x ->  (div (x * (x+1)) 2) ) nats

factorials :: [Integer] 
factorials = scanl (*) 1 (tail nats)

fibs :: [Integer] 
fibs = 0 : 1 : zipWith (+) fibs (tail fibs)

primes :: [Integer]
primes = primes' (iterate (+1) 2)
    where primes' (x : xs) = x : primes' [p | p <- xs, (mod p x /= 0) ]

hammings :: [Integer] 
hammings = 1 : (merge (map (*2) hammings) (merge (map(*3) hammings) (map(*5) hammings) ) )
    where 
        merge (x:xs) (y:ys)
          | x == y  = x : merge xs ys
          | x < y   = x : merge xs (y:ys)
          | x > y   = y : merge (x:xs) ys
          
--  lookNsay :: [Integer] 
--  tartaglia :: [[Integer]]
