data Cat = Cat {fs :: String,
                ls :: String,
                st :: Strat
                }
data Strat = Human | Rng
    deriving (Eq)
    
getFromList :: Int -> [Int] -> Int
getFromList eid list
    | eid == 1 = (head list)
    | otherwise = getFromList (eid-1) (tail list)
 

triplet :: Int -> (Int,(Int,Int))
triplet n = (n,(n+1,n+2))
