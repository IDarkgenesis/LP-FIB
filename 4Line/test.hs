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
 

 
--QUANT ESTA A NES BORDE COLUMNA NECESITA GUARDAR VALOR NOU CAS PER EXEMPLE R-1 QUE NECESSITA OBJ QUANT CANVI DE DIRECCIO                 
winD :: Int -> Int -> Int -> Int -> Direction -> [Int] -> Int -> Map Int [Int] -> Int
winD r c rs cs dir consec f m
    | r == 1 && c == colEnd = 0
    | dir == upDown && (c+1) > cs = case lenConsec of
                                     3 -> case match of
                                               True  -> obj
                                               False -> winD (r-1) c rs cs downUp [] f m
                                     n -> winD (r-1) c rs cs downUp [] f m
    
    | dir == Up && (r+1) > rs =  case lenConsec of
                                     3 -> case match of
                                               True  -> obj
                                               False -> winD r (sumOrSub c 1) rs cs Down [] f m
                                     n -> winD r (sumOrSub c 1) rs cs Down [] f m
    
    | dir == Down && (r-1) < 1 = case lenConsec of
                                      3 -> case match of
                                                True  -> obj
                                                False -> winD r (sumOrSub c 1) rs cs Up [] f m
                                      n -> winD r (sumOrSub c 1) rs cs Up [] f m

    | dir == downUp && (c-1) < 1 = case lenConsec of
                                      3 -> case match of
                                                True  -> obj
                                                False -> winD (r-1) c rs cs upDown [] f m
                                      n -> winD r (r-1) rs cs upDown [] f m
    
    | dir == Up = case lenConsec of
                       3 -> case match of
                                 True  -> obj
                                 False -> case isZero of
                                               True  -> winD (sumOrSub r 1) (sumOrSub c 1) rs cs Up [] f m
                                               False -> winD (sumOrSub r 1) (sumOrSub c 1) rs cs Up [obj] f m
                       0 -> case isZero of
                                 True  -> winD (sumOrSub r 1) (sumOrSub c 1) rs cs Up [] f m
                                 False -> winD (sumOrSub r 1) (sumOrSub c 1) rs cs Up [obj] f m
                       n -> case match of
                                 True  -> winD (sumOrSub r 1) (sumOrSub c 1) rs cs Up (obj:consec) f m
                                 False -> case isZero of
                                               True  -> winD (sumOrSub r 1) (sumOrSub c 1) rs cs Up [] f m
                                               False -> winD (sumOrSub r 1) (sumOrSub c 1) rs cs Up [obj] f m
                                               
     | dir == Down = case lenConsec of
                       3 -> case match of
                                 True  -> obj
                                 False -> case isZero of
                                               True  -> winD (subOrSum r 1) (subOrSum c 1) rs cs Down [] f m
                                               False -> winD (subOrSum r 1) (subOrSum c 1) rs cs Down [obj] f m
                       0 -> case isZero of
                                 True  -> winD (subOrSum r 1) (subOrSum c 1) rs cs Down [] f m
                                 False -> winD (subOrSum r 1) (subOrSum c 1) rs cs Down [obj] f m
                       n -> case match of
                                 True  -> winD (subOrSum r 1) (subOrSum c 1) rs cs Down (obj:consec) f m
                                 False -> case isZero of
                                               True  -> winD (subOrSum r 1) (subOrSum c 1) rs cs Down [] f m
                                               False -> winD (subOrSum r 1) (subOrSum c 1) rs cs Down [obj] f m
     where
         lenConsec = length consec
         match = (obj == (head consec))
         isZero = (obj == 0)
         obj = getPieceInt r (fromMaybe [] (find c m))
         
         colEnd :: Int
         colEnd 
             | f == 0 = cs
             | otherwise = 1 
         
         sumOrSub :: Int -> Int -> Int 
         sumOrSub var num
             | f == 0 = (var + num)
             | otherwise = (var - num)
         
         subOrSum :: Int -> Int -> Int 
         subOrSum var num
             | f == 0 = (var - num)
             | otherwise = (var + num)
         
         upDown :: Direction
         upDown
             | f == 0 = Up
             | otherwise = Down
         
         downUp :: Direction
         downUp
             | f == 0 = Down
             | otherwise = Up

             
             
             
             
             
             
             
             
             
             
             
             
             
             
             
             
             
             
             
             
             
             
             
             
             
winDF :: Int -> Int -> Int -> Int -> Direction -> [Int] -> Map Int [Int] -> Int
winDF r c rs cs dir consec m
    | r == 1 && c == cs = 0
    | dir == Up && (c+1) > cs = case lenConsec of
                                     3 -> case match of
                                               True  -> obj
                                               False -> winDF (r-1) c rs cs Down [] m
                                     n -> winDF (r-1) c rs cs Down [] m
    
    | dir == Up && (r+1) > rs =  case lenConsec of
                                     3 -> case match of
                                               True  -> obj
                                               False -> winDF r (c+1) rs cs Down [] m
                                     n -> winDF r (c+1) rs cs Down [] m
    
    | dir == Down && (r-1) < 1 = case lenConsec of
                                      3 -> case match of
                                                True  -> obj
                                                False -> winDF r (c+1) rs cs Up [] m
                                      n -> winDF r (c+1) rs cs Up [] m

    | dir == Down && (c-1) < 1 = case lenConsec of
                                      3 -> case match of
                                                True  -> obj
                                                False -> winDF (r-1) c rs cs Up [] m
                                      n -> winDF r (r-1) rs cs Up [] m
    
    | dir == Up = case lenConsec of
                       3 -> case match of
                                 True  -> obj
                                 False -> case isZero of
                                               True  -> winDF (r+1) (c+1) rs cs Up [] m
                                               False -> winDF (r+1) (c+1) rs cs Up [obj] m
                       0 -> case isZero of
                                 True  -> winDF (r+1) (c+1) rs cs Up [] m
                                 False -> winDF (r+1) (c+1) rs cs Up [obj] m
                       n -> case match of
                                 True  -> winDF (r+1) (c+1) rs cs Up (obj:consec) m
                                 False -> case isZero of
                                               True  -> winDF (r+1) (c+1) rs cs Up [] m
                                               False -> winDF (r+1) (c+1) rs cs Up [obj] m
                                               
     | dir == Down = case lenConsec of
                       3 -> case match of
                                 True  -> obj
                                 False -> case isZero of
                                               True  -> winDF (r-1) (c-1) rs cs Down [] m
                                               False -> winDF (r-1) (c-1) rs cs Down [obj] m
                       0 -> case isZero of
                                 True  -> winDF (r-1) (c-1) rs cs Down [] m
                                 False -> winDF (r-1) (c-1) rs cs Down [obj] m
                       n -> case match of
                                 True  -> winDF (r-1) (c-1) rs cs Down (obj:consec) m
                                 False -> case isZero of
                                               True  -> winDF (r-1) (c-1) rs cs Down [] m
                                               False -> winDF (r-1) (c-1) rs cs Down [obj] m
     where
         lenConsec = length consec
         match = (obj == (head consec))
         isZero = (obj == 0)
         obj = getPieceInt r (fromMaybe [] (find c m))
   
