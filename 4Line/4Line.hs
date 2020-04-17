import Data.Map (Map)
import qualified Data.Map.Strict as Map

data Strats= Human | Rng | Greedy | Smart

data Player = Player {pid :: Int, strat :: Strats}

--Funcio extreta de la llibreria Data.Maybe
fromMaybe :: a -> Maybe a -> a
fromMaybe d x = case x of {Nothing -> d;Just v  -> v}

string2Int:: String -> Int
string2Int c = read c ::Int

int2String :: Int -> String
int2String n = show n

insert :: Int -> Int -> Map Int [Int] -> Map Int [Int]
insert k nv m= Map.insertWith (++) k [nv] m

find:: Int -> Map Int [Int] -> (Maybe [Int])
find k m= Map.lookup k m


initGame :: Int -> Int -> Map Int [Int]
initGame r c = Map.fromList (map createCol [1..c])
    where
        createCol :: Int -> (Int, [Int])
        createCol n = (n , [])
        
createColNum :: Int -> Int -> String
createColNum c cs
    | c < cs  = " " ++ int2String c ++ createColNum (c+1) cs
    | otherwise = " " ++ int2String c

createHeader :: Int -> String     
createHeader 1 =  "+-+"
createHeader n = "+-" ++ createHeader (n-1)

selectPiece :: Int -> String
selectPiece 1 = "|X"
selectPiece 2 = "|O"

getPiece:: Int -> [Int] -> String
getPiece r xs
    | (r - length(xs)) < 0 = getPiece r (tail xs)
    | (r - length(xs)) > 0 = "| "
    | (r - length(xs)) == 0 = selectPiece (head xs)

getElem :: Int -> Int -> Int -> Map Int [Int] -> String
getElem r c cs m = getPiece r (fromMaybe [] (find c m))
    
createRow :: Int -> Int -> Int -> Map Int [Int] -> String
createRow r c cs m
    | (c-cs) == 0 = (getElem r c cs m) ++ "|"
    | otherwise= (getElem r c cs m) ++ createRow r (c+1) cs m 


printBoard:: Int -> Int -> Map Int [Int] -> IO()
printBoard 0 cs m = do
    let h= createHeader cs
    putStrLn $ h
    let n= createColNum 1 cs
    putStrLn $ n
    

printBoard r cs m= do
    let h= createHeader cs
    putStrLn $ h
    let row= createRow r 1 cs m
    putStrLn $ row
    printBoard (r-1) cs m
    

main = do
    putStrLn $ "Benvingut!"
    putStrLn $ "Selecciona el tipus de partida"
    putStrLn $ " 1) 1 vs 1\n 2) 1 vs Random\n 3) 1 vs Greedy\n 4) 1 vs Smart"
    
    t <- getLine
    let tp= string2Int t
    
    putStrLn $ "Especifica el nombre de files"
    
    r <- getLine
    let rs = string2Int r
    
    putStrLn $ "Especifica el nombre de columnes"
    
    c <- getLine
    let cs = string2Int c
    
    
    let g= initGame rs cs t
    
    --PURE TESTING
    
    let g2= insert 1 1 g
    let g3= insert 1 2 g2
    let g4= insert 4 1 g3
    
    putStrLn " "
    printBoard rs cs g4
    
    putStrLn $ "Done"
