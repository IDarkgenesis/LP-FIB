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
