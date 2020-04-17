myMap :: (a -> b) -> [a] -> [b]

myMap f xs = [ f x | x <- xs ]


myFilter :: (a -> Bool) -> [a] -> [a] 

myFilter f xs = [x | x <- xs, f x ]

myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]

myZipWith f xs xa = [ f x y | (x,y) <- zip xs xa ]

thingify :: [Int] -> [Int] -> [(Int, Int)]

thingify xs xa = [ (x,y) | x <-xs , y <-xa, mod x y == 0 ]

factors :: Int -> [Int] 

factors n = [ x | x <- [1..n], mod n x == 0]
