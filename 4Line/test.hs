data Cat = Cat {fs :: String,
                ls :: String,
                st :: Strat
                }
data Strat = Human | Rng
    deriving (Eq)


getAvailabeCols :: Int -> Int -> Map Int [Int] -> [Int]
getAvailabeCols c cs m
    | (c-cs) == 0  && size > 0 = [c]
    | (c-cs) == 0 = []
    | size > 0 = [c] ++ getAvailabeCols (c+1) cs m
    | otherwise = getAvailabeCols (c+1) cs m
    where
        size = length (fromMaybe [] (find c m)) 

    
getFromList :: Int -> [Int] -> Int
getFromList eid list
    | eid == 1 = (head list)
    | otherwise = getFromList (eid-1) (tail list)
 
