-- FUNCIO AJUNTAR LLISTES

flatten :: [[Int]] -> [Int]
flatten x = foldl (++) [] x

-- FUNCIO LONGITUD STRING

myLength :: String -> Int
myLength s= foldl (+) 0 (map (const 1) s)

-- FUNCIO REVERSE

myReverse :: [Int] -> [Int] 
--myReverse xs = foldr (\x acc-> acc ++ [x]) [] xs
myReverse xs = foldl (\acc x -> x : acc) [] xs

-- FUNCIO CONTAR UN ELEM EN LLISTA DE LLISTES

countIn :: [[Int]] -> Int -> [Int]
countIn xs x = map (\l -> length $ filter (== x) l) xs 

-- FUNCIO SABER PRIMERA PARAULA FRASE

firstWord :: String -> String
firstWord s= takeWhile (/= ' ') $ dropWhile (== ' ') s
