--FUNCIO PER SABER SA LONGITUD DE UNA LLISTA
myLength :: [Int] -> Int

myLength xs
    | null xs = 0
    | otherwise = 1 + myLength (tail xs)
    
--FUNCIO PER RETORNAR ES MAXIM DE UNA LLISTA

myMaximum :: [Int] -> Int

myMaximum xs = myMaximum' (tail xs) (head xs)
    where
        myMaximum'::[Int] -> Int -> Int
        myMaximum' xa m
            | null xa = m
            | (head xa) > m = myMaximum' (tail xa) (head xa)
            | (head xa) <= m = myMaximum' (tail xa) m
            
            
--FUNCIO MITJANA

average :: [Int] -> Float

average xs = fromIntegral (div (mySum xs) (myLength xs))
    where 
        mySum::[Int] -> Int
        mySum  xs 
            | null xs = 0
            | otherwise = (head xs) + mySum (tail xs)
            
--FUNCIO CREATE PALINDROME

buildPalindrome :: [Int] -> [Int]
buildPalindrome xs= concat [reverse xs, xs] 


--FUNCIO REMOVE
{-
remove :: [Int] -> [Int] -> [Int]
remove xo xe = remove' xo xe []
    where
        remove' :: [Int] -> [Int] -> [Int] -> [Int]
        remove' xs xa r
            | null xs = remove' r (tail xa) []
            | null xa = r
            | (head xs) == (head xa) = remove' (tail xs) xa r
            | otherwise = remove' (tail xs) xa (r ++ [head xs])
            -}
            
remove :: [Int] -> [Int] -> [Int]
remove [] _ = []
remove (x:xs) xa
    | elem x xa= remove xs xa
    | otherwise = x : remove xs xa
    
--FUNCIO FLATTEN
flatten :: [[Int]] -> [Int]
flatten [] = []
flatten (x:xs)= x ++ flatten xs

--FUNCIO ODD EVENS
oddsNevens :: [Int] -> ([Int],[Int])
oddsNevens [] = ([],[])
oddsNevens (x:xs)
    | even x = (od , x : ev)
    | otherwise = (x : od, ev)
        where (od,ev) = oddsNevens(xs)
          
-- PRIME DIVISORS

primeDivisors :: Int -> [Int]
primeDivisors x = primeDivisors' 2 []
    where 
        primeDivisors'::Int -> [Int] -> [Int]
        primeDivisors' d res
            | d > x = res
            | (d == 2) && ((mod x d) == 0) = primeDivisors' 3 (res ++ [d])
            | (d == 2) = primeDivisors' 3 res
            | ((mod x d) == 0) && isPrime d = primeDivisors' (d+2) (res ++ [d])
            | otherwise = primeDivisors' (d+2) res
                where --AFEGIR FUNCIO PER SABER SI ES PRIMER
                    isPrime::Int -> Bool
                    isPrime 0 = False
                    isPrime 1 = False
                    isPrime n = isPrime' 2
                        where
                            isPrime'::Int -> Bool 
                            isPrime' d
                                | d*d > n = True
                                | (mod n d) == 0 = False
                                | otherwise = isPrime' (d+1)
