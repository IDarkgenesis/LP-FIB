-- FUNCIO ELEM 2 LLISTES EQ

eql :: [Int] -> [Int] -> Bool 
eql x y = (length x == length y) &&  (and (zipWith (==) x y))

-- FUNCIO MULTIPLICAR ELEM DE UNA LLISTA

prod :: [Int] -> Int
prod x = foldl (*) 1 x

-- FUNCIO MULTIPLICAR ELEM PARELLS

prodOfEvens :: [Int] -> Int
prodOfEvens x = prod $ filter even x

-- FUNCIO POTENCIES DE 2
powersOf2 :: [Int]
powersOf2 = iterate (*2) 1

-- FUNCIO PRODUCTE ESCALAR
scalarProduct :: [Float] -> [Float] -> Float
scalarProduct x y = foldl (+) 0 (zipWith (*) x y)
