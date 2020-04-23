import Data.Map (Map)
import qualified Data.Map.Strict as Map

main :: IO ()
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
    
    putStrLn " "
    putStrLn " "
    
    runGame (initGame rs cs tp)
    
    
    --PURE TESTING

--------------------------
-- ESTRUCTURES DE DADES --
--------------------------

data Strats= Human | Rng | Greedy | Smart

data Player = Player {  pid :: Int, 
                        strat :: Strats}

data State = NewState {    row :: Int,
                        col :: Int,
                        board :: Map Int [Int], 
                        player1 :: Player,
                        player2 :: Player}

--------------
-- FUNCIONS --
--------------

{-  fromMaybe -> Permet extreure el contingut de un Maybe en cas de Just si no retorna un parametre per defecte definit a la funció
                 (Extret de la llibreria Data.Maybe)
    PARAMETRES:
        d -> Valor per defecte que es retorna en cas de Nothing
        x -> Element Maybe a del que en volem extreure el resultat
-}
fromMaybe :: a -> Maybe a -> a
fromMaybe d x = case x of {Nothing -> d;Just v  -> v}


{- string2Int -> Transforma una String a un Int
    
    PARAMETRES:
        s -> String a transformar
-}
string2Int:: String -> Int
string2Int s = read s ::Int


{- int2String -> Transforma un Int en una String
    
    PARAMETRES:
        n   -> Nombre a transformar
-}
int2String :: Int -> String
int2String n = show n

{- insert -> Insereix en un element la columna desitjada
    
    PARAMETRES:
        k   -> Clau que identifica a la columna
        nv  -> Valor a inserir a la columna
        m   -> Tauler on volem inserir el nou element
-}
insert :: Int -> Int -> Map Int [Int] -> Map Int [Int]
insert k nv m= Map.insertWith (++) k [nv] m

{- find -> Retorna la columna desitjada del tauler
    
    PARAMETRES:
        k   -> Clau que identifica la columna
        m   -> Tauler on volem buscar la columna
-}
find:: Int -> Map Int [Int] -> (Maybe [Int])
find k m= Map.lookup k m

{- initBoard -> Inicialitza el tauler del joc
    
    PARAMETRES:
        c   -> Nombre total de columnes del tauler 
-}
initBoard :: Int -> Map Int [Int]
initBoard c = Map.fromList (map createCol [1..c])
    where
        createCol :: Int -> (Int, [Int])
        createCol n = (n , [])
        
{- createColNum -> Crea una string que indica una vegada impres el tauler el identificador de cada columna
    
    PARAMETRES:
        c   -> Identificador de la columna actual
        cs  -> Nombre total de columnes
-}
createColNum :: Int -> Int -> String
createColNum c cs
    | c < cs  = " " ++ int2String c ++ createColNum (c+1) cs
    | otherwise = " " ++ int2String c

    
{- createHeader -> Crea les divisions que s'utilitzen quant s'imprimeix el tauler
    PARAMETRES:
        n   -> Representa el nombre de columnes que falten per crear 
-}
createHeader :: Int -> String     
createHeader 1 =  "+-+"
createHeader n = "+-" ++ createHeader (n-1)

{- selectPiece -> Donat un valor que representa un PID de un jugador determina la fitxa
    
    PARAMETRES:
        id  -> nombre compres entre 1 i 2 que representa al jugador que ha colocat una fitxa
-}
selectPiece :: Int -> String
selectPiece 1 = "|X"
selectPiece 2 = "|O"


{- getPiece -> Determina si l'element que volem es troba a la taula i si es troba al principi de la llista
    
    PARAMETRES:
        r   -> Posició de la fila que volem buscar
        xs  -> Llista on busquem el element desitjat
-}
getPiece:: Int -> [Int] -> String
getPiece r xs
    | (r - length(xs)) < 0 = getPiece r (tail xs)
    | (r - length(xs)) > 0 = "| "
    | (r - length(xs)) == 0 = selectPiece (head xs)    
    
{- getElem -> Obté l'element del tauler en la posició 'r', 'c', les files estan idexades de major a menor
    
    PARAMETRES:
        r   -> Fila on es troba l'element que volem
        c   -> Columna on es troba l'element que volem
        cs  -> Nombre total de columnes
        m   -> Tauler del joc
-} 
getElem :: Int -> Int -> Int -> Map Int [Int] -> String
getElem r c cs m = getPiece r (fromMaybe [] (find c m))
    
{- createRow -> Crea una string que representa la fila donada

    PARAMETRES: 
        r   -> Fila que volem (ordre decreixent)
        c   -> Columna que volem imprimir
        cs  -> Nombre total de columnes
        m   -> Tauler que volem imprimir
-}
createRow :: Int -> Int -> Int -> Map Int [Int] -> String
createRow r c cs m
    | (c-cs) == 0 = (getElem r c cs m) ++ "|"
    | otherwise= (getElem r c cs m) ++ createRow r (c+1) cs m 


{- printBoard -> Imprimeix el tauler de joc
    
    PARAMETRES: 
        r   -> Nombre de fila per imprimir 
        cs  -> Nombre de columnes 
        m   -> Tauler que volem imprimir
-}
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

checkWinner :: [Int] -> [Int] ->Int
checkWinner elms consec
        | (length elms) == 0 && (length consec) == 0 = 0
        | (length consec) == 4 = (head consec)
        | (length elms) == 0 && (length consec) > 0 = 0
        | (length consec) > 0 && (head consec) == (head elms) = checkWinner (tail elms) ((head elms):consec)
        | otherwise = checkWinner (tail elms)  [(head elms)]
    
    
winV :: Int -> Int -> Map Int [Int] -> Int
winV c cs m 
    | (c-cs) == 0 = win
    | win == 0 = winV (c+1) cs m
    | otherwise = win
    where
        win = checkWinner (fromMaybe [] (find c m)) []
        
{- initGame -> Inicialitza el joc amb el tauler corresponent a part de crear els         jugardors pertinents
    
    PARAMETRES:
        r   -> Nombre total de files
        c   -> Nombre total de columnes
-}
initGame:: Int -> Int -> Int -> State
initGame r c 1 = NewState r c (initBoard c) (Player 1 Human) (Player 2 Human)
initGame r c 2 = NewState r c (initBoard c) (Player 1 Human) (Player 2 Rng)
initGame r c 3 = NewState r c (initBoard c) (Player 1 Human) (Player 2 Greedy)
initGame r c 4 = NewState r c (initBoard c) (Player 1 Human) (Player 2 Smart)


{- runGame -> S'encarrega de controlar el funcionament del joc 
    
    PARAMETRES:
        w -> Representa l'estat actual de la partida, el tamany del tauler, el tauler i els jugadors que hi participen
-}
runGame :: State -> IO ()
runGame w = do
    
    printBoard (row w) (col w) (board w)
    
    putStrLn " "
    
    putStrLn "Introdueix columna"
    c1 <- getLine
    let cn1 = string2Int c1
    
    let g= insert cn1 (pid(player1 w)) (board w)
    
    putStrLn " "
    
    printBoard (row w) (col w) g
    
    putStrLn " "
    
    let final=  winV 0 (col w) g
    
    if  final > 0
       then print "Game over !"
       else runGame (NewState (row w) (col w) g (player2 w) (player1 w))
