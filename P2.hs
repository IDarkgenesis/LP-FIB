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
