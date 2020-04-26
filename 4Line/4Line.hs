import System.Random
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
    deriving (Eq)

data Direction= Up | Down 
    deriving (Eq)
    
data Player = Player {  pid :: Int, 
                        strat :: Strats}

data State = NewState { turn :: Int,
                        row :: Int,
                        col :: Int,
                        board :: Map Int [Int], 
                        player1 :: Player,
                        player2 :: Player}

--------------
-- FUNCIONS --
--------------

randInt :: Int -> Int -> IO Int
-- randInt low high is an IO action that returns a
-- pseudo-random integer between low and high (both included).

randInt low high = do
    random <- randomIO :: IO Int
    let result = low + random `mod` (high - low + 1)
    return result


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


{- getAvailabeCols -> Obté el nombre de columnes no plenes del tauler
    
    PARAMETRES:
        r   -> Nombre total de files
        c   -> Columna a consultar
        cs  -> Nombre total de columnes
        m   -> Representacio del tauler
-}  
getAvailabeCols :: Int -> Int -> Int -> Map Int [Int] -> [Int]
getAvailabeCols r c cs m
    | (c-cs) == 0  && r > size = [c]
    | (c-cs) == 0 = []
    | r > size  = [c] ++ getAvailabeCols r (c+1) cs m
    | otherwise = getAvailabeCols r (c+1) cs m
    where
        size = length (fromMaybe [] (find c m)) 


{- getFromList -> Obte l'element n essim de la llista
    
    PARAMETRES:
        eid     -> Identificador de la posicio de l'element
        list    -> Llista on buscar l'element n essim
-}    
getFromList :: Int -> [Int] -> Int
getFromList eid list
    | eid == 1 = (head list)
    | otherwise = getFromList (eid-1) (tail list)

    
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


{- winV -> Busca si hi ha una sequència de 4 fitxes iguals consecutives per saber si hi ha algun guanyador
    
    PARAMETRES:
        c   -> Columna a comprovar
        cs  -> Nombre total de columnes
        m   -> Tauler actual on buscar un guanyador
-}
winV :: Int -> Int -> Int -> Int -> Int -> Map Int [Int] -> (Int,Int)
winV c cs rs len sel m 
    | (c-cs) == 0 = (win,nextPos)
    | win == 0 = winV (c+1) cs rs len sel m
    | otherwise = (win,nextPos)
    where
        win = checkWinner sel (fromMaybe [] (find c m)) []
        nextPos :: Int
        nextPos 
            | (length (fromMaybe [] (find c m))) == rs = 0
            | otherwise = c
        checkWinner :: Int -> [Int] -> [Int] ->Int
        checkWinner sel elms consec
            | sel /= 0 && (length elms) > 0 && (head elms) /= sel = 0
            | (length elms) == 0 && (length consec) == 0 = 0
            | (length consec) == len = (head consec)
            | (length elms) == 0 && (length consec) > 0 = 0
            | (length consec) > 0 && (head consec) == (head elms) = checkWinner sel (tail elms) ((head elms):consec)
            | otherwise = checkWinner sel (tail elms)  [(head elms)]

{- getPieceInt -> Obte el valor guardat en la llista donada (ordenada amb nombres de major a menor)
    
    PARAMETRES:
        r  -> Posicio en la llista on volem trobar l'element
        xs -> Llista on busquem l'element
-}            
getPieceInt :: Int -> [Int] -> Int
getPieceInt r xs
    | (r - length(xs)) < 0  = getPieceInt r (tail xs)
    | (r - length(xs)) > 0  = 0
    | (r - length(xs)) == 0 = (head xs)            
            
{- winH -> Busca en la direccio horitzontal si hi ha una sequència de len fitxes consecutives iguals
    
    PARAMETRES:
        r       -> Fila on buscar la sequència
        cs      -> Nombre total de columnes
        len     -> Longitud de la sequència a bucar
        m       -> Tauler on busquem la sequència
-}
winH :: Int -> Int -> Int -> Int -> Map Int [Int] -> (Int,Int)
winH r cs len sel m
    | r == 1 = win
    | fst win == 0 = (winH (r-1) cs len sel m)
    | otherwise = win
    where
        win= checkWinner r 1 cs [] len sel m
        checkWinner :: Int -> Int -> Int -> [Int] -> Int -> Int -> Map Int [Int] -> (Int,Int)
        checkWinner r c cs consec len sel m 
            | (c-cs) == 0 = case (sizConsec < lessLen) of
                                 True  -> (0,0)
                                 False -> case sel of
                                               0 -> case match of
                                                         True  -> (obj,nextPos)
                                                         False -> (0,0)
                                               _ -> case matchSel of
                                                         True  -> (obj,nextPos)
                                                         False -> (0,0) 
            
            | otherwise = case (sizConsec < lessLen) of
                               
                               True  -> case sel of
                                             0 -> case sizConsec of
                                                       0 -> case isZero of
                                                                 True  -> checkWinner r (c+1) cs [] len sel m
                                                                 False -> checkWinner r (c+1) cs [obj] len sel m
                                                       n -> case match of
                                                                 True  -> checkWinner r (c+1) cs (obj:consec) len sel m
                                                                 False -> case isZero of
                                                                               True  -> checkWinner r (c+1) cs [] len sel m
                                                                               False -> checkWinner r (c+1) cs [obj] len sel m
                                             _ -> case sizConsec of
                                                       0 -> case isZero of
                                                                 True  -> checkWinner r (c+1) cs [] len sel m
                                                                 False -> case obEqSel of
                                                                               True  -> checkWinner r (c+1) cs [obj] len sel m
                                                                               False -> checkWinner r (c+1) cs [] len sel m
                                                       
                                                       n -> case matchSel of
                                                                 True  -> checkWinner r (c+1) cs (obj:consec) len sel m
                                                                 False -> checkWinner r (c+1) cs [] len sel m
                               
                               False -> case sel of
                                             0 -> case match of
                                                       True  -> (obj,nextPos)
                                                       False -> case isZero of
                                                                     True  -> checkWinner r (c+1) cs [] len sel m
                                                                     False -> checkWinner r (c+1) cs [obj] len sel m
                                             _ -> case matchSel of
                                                       True  -> (obj,nextPos)
                                                       False -> checkWinner r (c+1) cs [] len sel m
                                             
                               
            where
               sizConsec = length consec
               match = (obj == (head consec))
               lessLen = (len-1)
               isZero = (obj == 0)
               obEqSel = (obj == sel)
               matchSel = match && (obj == sel)
               obj = getPieceInt r (fromMaybe [] (find c m))
               nextPos :: Int
               nextPos
                   | (c+1) <= cs && r == 1 && (getPieceInt r (fromMaybe [] (find (c+1) m))) == 0 = (c+1)
                   | (c+1) <= cs && r > 1  && (getPieceInt (r-1) (fromMaybe [] (find (c+1) m))) /= 0 && (getPieceInt r (fromMaybe [] (find (c+1) m))) == 0 = (c+1)
                   | (c-len) >= 1 && r == 1 && (getPieceInt r (fromMaybe [] (find (c-len) m))) == 0 = (c-len)
                   | (c-len) >= 1 && r > 1 && (getPieceInt (r-1) (fromMaybe [] (find (c-len) m))) /= 0 && (getPieceInt r (fromMaybe [] (find (c-len) m))) == 0 = (c-len)
                   | otherwise = 0
               
               
{- winDF -> Busca en la direccio de les digaonals inverses una sequència de len elements consecutius iguals per saber si algu hi ha un guanyador amb len fitxes
            (L'ordre de les guardes importa degut a que en les cantonades del tauler es pot seguir executant i no acabar mai)

    PARAMETRES:
        r       -> Fila actual del tauler
        c       -> Columna actual del tauler
        rs      -> Nombre total de files
        cs      -> Nombre total de columnes
        dir     -> Direcco en la que ens movem dins del tauler per comprovar si hi ha guanyador
        consec  -> Llista on guardem els elements consecutius iguals trobats
        len     -> Longitud de la cadena guanyadora

        m       -> Tauler on buscar el guanyador
-}
winDF :: Int -> Int -> Int -> Int -> Direction -> [Int] -> Int -> Int -> Map Int [Int] -> (Int,Int)
winDF r c rs cs dir consec len sel m
    | r == 1 && c == cs = (0,0)
    | dir == Up && (c+1) > cs = case (sizConsec < lessLen) of
                                      True  -> winDF (r-1) c rs cs Down [] len sel m
                                      False -> case sel of
                                                    0 -> case match of
                                                              True  -> (obj,nextPos)
                                                              False -> winDF (r-1) c rs cs Down [] len sel m
                                                    _ -> case matchSel of
                                                              True  -> (obj,nextPos)
                                                              False -> winDF (r-1) c rs cs Down [] len sel m
                                                    
    | dir == Up && (r+1) > rs = case (sizConsec < lessLen) of
                                      True  -> winDF r (c+1) rs cs Down [] len sel m
                                      False -> case sel of
                                                    0 -> case match of
                                                              True  -> (obj,nextPos)
                                                              False -> winDF r (c+1) rs cs Down [] len sel m
                                                    _ -> case matchSel of
                                                              True  -> (obj,nextPos)
                                                              False -> winDF r (c+1) rs cs Down [] len sel m
                                               
    | dir == Down && (r-1) < 1 = case (sizConsec < lessLen) of
                                      True  -> winDF r (c+1) rs cs Up [] len sel m
                                      False -> case sel of
                                                    0 -> case match of
                                                              True  -> (obj,nextPos)
                                                              False -> winDF r (c+1) rs cs Up [] len sel m
                                                    _ -> case matchSel of
                                                              True  -> (obj,nextPos)
                                                              False -> winDF r (c+1) rs cs Up [] len sel m

    | dir == Down && (c-1) < 1 = case (sizConsec < lessLen) of
                                      True  -> winDF (r-1) c rs cs Up [] len sel m
                                      False -> case sel of
                                                    0 -> case match of
                                                              True  -> (obj,nextPos)
                                                              False -> winDF (r-1) c rs cs Up [] len sel m
                                                    _ -> case matchSel of
                                                              True  -> (obj,nextPos)
                                                              False -> winDF (r-1) c rs cs Up [] len sel m
    | dir == Up = case (sizConsec < lessLen) of 
                          True  -> case sel of
                                        0 -> case sizConsec of 
                                                  0 -> case isZero of
                                                            True  -> winDF (r+1) (c+1) rs cs Up [] len sel m
                                                            False -> winDF (r+1) (c+1) rs cs Up [obj] len sel m
                                 
                                                  n -> case match of
                                                            True  -> winDF (r+1) (c+1) rs cs Up (obj:consec) len sel m
                                                            False -> case isZero of
                                                                          True  -> winDF (r+1) (c+1) rs cs Up [] len sel m
                                                                          False -> winDF (r+1) (c+1) rs cs Up [obj] len sel m
                                        _ -> case sizConsec of
                                                  0 -> case isZero of
                                                            True  -> winDF (r+1) (c+1) rs cs Up [] len sel m
                                                            False -> case obEqSel of
                                                                          True  -> winDF (r+1) (c+1) rs cs Up [obj] len sel m
                                                                          False -> winDF (r+1) (c+1) rs cs Up [] len sel m
                                                  n -> case matchSel of
                                                            True  -> winDF (r+1) (c+1) rs cs Up (obj:consec) len sel m
                                                            False -> winDF (r+1) (c+1) rs cs Up [] len sel m
                                        
                          False -> case sel of
                                        0 -> case match of
                                                  True  -> (obj,nextPos)
                                                  False -> case isZero of
                                                                True  -> winDF (r+1) (c+1) rs cs Up [] len sel m
                                                                False -> winDF (r+1) (c+1) rs cs Up [obj] len sel m
                                        _ -> case matchSel of
                                                  True  -> (obj,nextPos)
                                                  False -> winDF (r+1) (c+1) rs cs Up [] len sel m
                                               
     | dir == Down = case (sizConsec < lessLen) of 
                          True  -> case sel of
                                        0 -> case sizConsec of 
                                                  0 -> case isZero of
                                                            True  -> winDF (r-1) (c-1) rs cs Down [] len sel m
                                                            False -> winDF (r-1) (c-1) rs cs Down [obj] len sel m
                                 
                                                  n -> case match of
                                                            True  -> winDF (r-1) (c-1) rs cs Down (obj:consec) len sel m
                                                            False -> case isZero of
                                                                          True  -> winDF (r-1) (c-1) rs cs Down [] len sel m
                                                                          False -> winDF (r-1) (c-1) rs cs Down [obj] len sel m
                                        _ -> case sizConsec of
                                                  0 -> case isZero of
                                                            True  -> winDF (r-1) (c-1) rs cs Down [] len sel m
                                                            False -> case obEqSel of
                                                                          True  -> winDF (r-1) (c-1) rs cs Down [obj] len sel m
                                                                          False -> winDF (r-1) (c-1) rs cs Down [] len sel m
                                                  n -> case matchSel of
                                                            True  -> winDF (r-1) (c-1) rs cs Down (obj:consec) len sel m
                                                            False -> winDF (r-1) (c-1) rs cs Down [] len sel m
                          
                          False -> case sel of
                                        0 -> case match of
                                                  True  -> (obj,nextPos)
                                                  False -> case isZero of
                                                                True  -> winDF (r-1) (c-1) rs cs Down [] len sel m
                                                                False -> winDF (r-1) (c-1) rs cs Down [obj] len sel m
                                        _ -> case matchSel of
                                                  True  -> (obj,nextPos)
                                                  False -> winDF (r-1) (c-1) rs cs Down [] len sel m
     where
         sizConsec = length consec
         match = (obj == (head consec))
         obEqSel = (obj == sel)
         matchSel = match && (obj == sel)
         lessLen = (len-1)
         isZero = (obj == 0)
         obj = getPieceInt r (fromMaybe [] (find c m))
         nextPos :: Int
         nextPos
             | (c+1) <= cs && (r+1) <= rs && (getPieceInt r (fromMaybe [] (find (c+1) m))) /= 0 && (getPieceInt (r+1) (fromMaybe [] (find (c+1) m))) == 0 = (c+1)
             | (c-len) >= 1 && (r-len) == 1 && (getPieceInt (r-len) (fromMaybe [] (find (c-len) m))) == 0 = (c-len)
             | (c-len) >= 1 && (r-len) > 1 && (getPieceInt (r-len) (fromMaybe [] (find (c-len) m))) == 0 && (getPieceInt (r-len-1) (fromMaybe [] (find (c-len) m))) /= 0 = (c-len)
             | otherwise = 0
             
         
{- winDB -> Busca en la direccio de les digaonals una sequència de len elements consecutius iguals per saber si algu hi ha un guanyador amb len fitxes
            (L'ordre de les guardes importa degut a que en les cantonades del tauler es pot seguir executant i no acabar mai)

    PARAMETRES:
        r       -> Fila actual del tauler
        c       -> Columna actual del tauler
        rs      -> Nombre total de files
        cs      -> Nombre total de columnes
        dir     -> Direcco en la que ens movem dins del tauler per comprovar si hi ha guanyador
        consec  -> Llista on guardem els elements consecutius iguals trobats
        len     -> Longitud de la cadena guanyadora
        m       -> Tauler on buscar el guanyador
-}          
winDB :: Int -> Int -> Int -> Int -> Direction -> [Int] -> Int -> Int -> Map Int [Int] -> (Int,Int)
winDB r c rs cs dir consec len sel m
    | r == 1 && c == 1 = (0,0)
    | dir == Down && (r-1) < 1 = case (sizConsec < lessLen) of
                                      True  -> winDB r (c-1) rs cs Up [] len sel m
                                      False -> case sel of
                                                    0 -> case match of
                                                              True  -> (obj,nextPos)
                                                              False -> winDB r (c-1) rs cs Up [] len sel m
                                                    _ -> case matchSel of
                                                              True  -> (obj,nextPos)
                                                              False -> winDB r (c-1) rs cs Up [] len sel m
                                                    
    | dir == Down && (c+1) > cs = case (sizConsec < lessLen) of
                                       True  -> winDB (r-1) c rs cs Up [] len sel m
                                       False -> case sel of
                                                     0 -> case match of
                                                               True  -> (obj,nextPos)
                                                               False -> winDB (r-1) c rs cs Up [] len sel m
                                                     _ -> case matchSel of
                                                               True  -> (obj,nextPos)
                                                               False -> winDB (r-1) c rs cs Up [] len sel m
    
    | dir == Up && (c-1) < 1 = case (sizConsec < lessLen) of
                                     True  -> winDB (r-1) c rs cs Down [] len sel m
                                     False -> case sel of
                                                   0 -> case match of
                                                             True  -> (obj,nextPos)
                                                             False -> winDB (r-1) c rs cs Down [] len sel m
                                                   _ -> case matchSel of
                                                             True  -> (obj,nextPos)
                                                             False -> winDB (r-1) c rs cs Down [] len sel m
    
    | dir == Up && (r+1) > rs =  case (sizConsec < lessLen) of
                                      True  -> winDB r (c-1) rs cs Down [] len sel m
                                      False -> case sel of
                                                    0 -> case match of
                                                              True  -> (obj,nextPos)
                                                              False -> winDB r (c-1) rs cs Down [] len sel m
                                                    _ -> case matchSel of
                                                              True  -> (obj,nextPos)
                                                              False -> winDB r (c-1) rs cs Down [] len sel m
                                                    
    
    | dir == Up = case (sizConsec < lessLen) of 
                       True  -> case sel of
                                     0 -> case sizConsec of 
                                               0 -> case isZero of
                                                         True  -> winDB (r+1) (c-1) rs cs Up [] len sel m
                                                         False -> winDB (r+1) (c-1) rs cs Up [obj] len sel m
                                 
                                               n -> case match of
                                                         True  -> winDB (r+1) (c-1) rs cs Up (obj:consec) len sel m
                                                         False -> case isZero of
                                                                       True  -> winDB (r+1) (c-1) rs cs Up [] len sel m
                                                                       False -> winDB (r+1) (c-1) rs cs Up [obj] len sel m
                                     _ -> case sizConsec of
                                               0 -> case isZero of
                                                         True  -> winDB (r+1) (c-1) rs cs Up [] len sel m
                                                         False -> case obEqSel of
                                                                       True  -> winDB (r+1) (c-1) rs cs Up [obj] len sel m
                                                                       False -> winDB (r+1) (c-1) rs cs Up [] len sel m
                                               n -> case matchSel of
                                                         True  -> winDB (r+1) (c-1) rs cs Up (obj:consec) len sel m
                                                         False -> winDB (r+1) (c-1) rs cs Up [] len sel m
                                               
                       False -> case sel of
                                     0 -> case match of
                                               True  -> (obj,nextPos)
                                               False -> case isZero of
                                                             True  -> winDB (r+1) (c-1) rs cs Up [] len sel m
                                                             False -> winDB (r+1) (c-1) rs cs Up [obj] len sel m
                                     _ -> case matchSel of
                                               True  -> (obj,nextPos)
                                               False -> winDB (r+1) (c-1) rs cs Up [] len sel m
                                               
     | dir == Down = case (sizConsec < lessLen) of 
                          True  -> case sel of
                                        0 -> case sizConsec of 
                                                  0 -> case isZero of
                                                            True  -> winDB (r-1) (c+1) rs cs Down [] len sel m
                                                            False -> winDB (r-1) (c+1) rs cs Down [obj] len sel m
                                 
                                                  n -> case match of
                                                            True  -> winDB (r-1) (c+1) rs cs Down (obj:consec) len sel m
                                                            False -> case isZero of
                                                                          True  -> winDB (r-1) (c+1) rs cs Down [] len sel m
                                                                          False -> winDB (r-1) (c+1) rs cs Down [obj] len sel m
                                        _ -> case sizConsec of
                                                  0 -> case isZero of
                                                            True  -> winDB (r-1) (c+1) rs cs Down [] len sel m
                                                            False -> case obEqSel of
                                                                          True  -> winDB (r-1) (c+1) rs cs Down [obj] len sel m
                                                                          False -> winDB (r-1) (c+1) rs cs Down [] len sel m
                                                  n -> case matchSel of
                                                            True  -> winDB (r-1) (c+1) rs cs Down (obj:consec) len sel m
                                                            False -> winDB (r-1) (c+1) rs cs Down [] len sel m
                          
                          
                          False -> case sel of
                                        0 -> case match of
                                                  True  -> (obj,nextPos)
                                                  False -> case isZero of
                                                                True  -> winDB (r-1) (c+1) rs cs Down [] len sel m
                                                                False -> winDB (r-1) (c+1) rs cs Down [obj] len sel m
                                        _ -> case matchSel of
                                                  True  -> (obj,nextPos)
                                                  False -> winDB (r-1) (c+1) rs cs Down [] len sel m
     where
         sizConsec = length consec
         match = (obj == (head consec))
         lessLen = (len-1)
         obEqSel = (obj == sel)
         matchSel = match && (obj == sel)
         isZero = (obj == 0)
         obj = getPieceInt r (fromMaybe [] (find c m))
         nextPos :: Int
         nextPos
             | (c-1) >= 1 && (r+1) <= rs && (getPieceInt r (fromMaybe [] (find (c-1) m))) /= 0 && (getPieceInt (r+1) (fromMaybe [] (find (c-1) m))) == 0 = (c-1)
             | (c+len) <= cs && (r-len) == 1 && (getPieceInt (r-len) (fromMaybe [] (find (c+len) m))) == 0 = (c+len)
             | (c+len) <= cs && (r-len) > 1 && (getPieceInt (r-len) (fromMaybe [] (find (c+len) m))) == 0 && (getPieceInt (r-len-1) (fromMaybe [] (find (c+len) m))) /= 0 = (c+len)
             | otherwise = 0
      
{- checkWin -> Aquesta funcio retorna el Pid del jugador que ha aconseguit una sequència de len fitxes consecutives iguals i la seguent posicio si es posible per aconseguir len+1
    
    PARAMETRES:
        r   -> Nombre de files del tauler
        c   -> Nombre de columnes del tauler
        len -> Longitud de la sequència a bucar
        m   -> Tauler on busquem la sequència de longitud len
-}
checkWin :: Int -> Int -> Int -> Int ->  Map Int [Int] -> (Int,Int)
checkWin r c len sel m = case (fst vertical) of
                          0 -> case (fst horizontal) of
                                    0 -> case (fst diagonalF) of
                                              0 -> diagonalB
                                              _ -> diagonalF
                                    _ -> horizontal
                          _ -> vertical
    where
        vertical = (winV 1 c r len sel m)
        horizontal = (winH r c len sel m)
        diagonalF = (winDF r 1 r c Up [] len sel m)
        diagonalB =(winDB r c r c Up [] len sel m)



{- initGame -> Inicialitza el joc amb el tauler corresponent a part de crear els jugardors pertinents
    
    PARAMETRES:
        r   -> Nombre total de files
        c   -> Nombre total de columnes
-}
initGame:: Int -> Int -> Int -> State
initGame r c 1 = NewState 1 r c (initBoard c) (Player 1 Human) (Player 2 Human)
initGame r c 2 = NewState 1 r c (initBoard c) (Player 1 Rng)   (Player 2 Human) 
initGame r c 3 = NewState 1 r c (initBoard c) (Player 1 Greedy)(Player 2 Human)
initGame r c 4 = NewState 1 r c (initBoard c) (Player 1 Smart) (Player 2 Human)


{- playHuman -> Permet al jugador Huma seleccionar la seva jugada
    
    PARAMETRES:
        w       -> Representa l'estat actual de la partida, el tamany del tauler, el tauler i els jugadors que hi participen
-}
playHuman :: State -> IO ()
playHuman w = do
    
    putStrLn " "
    
    putStrLn "Introdueix columna"
    c1 <- getLine
    let cn = string2Int c1
    let g= insert cn (pid(player1 w)) (board w)
    
    let final= fst(checkWin (row w) (col w) 4  0 g)

    putStrLn " "
    
    printBoard (row w) (col w) g
    
    putStrLn " "
    
    
    if  final > 0
       then print ("Player " ++ (int2String (pid(player1 w))) ++ " wins !")
       else runGame (NewState ((turn w)+1) (row w) (col w) g (player2 w) (player1 w))
                

                
augPos :: Int -> Int -> Int -> Int -> Map Int [Int] -> Int
augPos r c 1 sel m = 0 
augPos r c len sel m
    | cpos > 0 = cpos
    | otherwise = augPos r c (len-1) sel m
    where
        cpos = snd (checkWin r c len sel m)
                
greedyMoove :: Int -> Int -> Int -> Int -> Int -> Int -> Int -> Map Int [Int] -> Int
greedyMoove r c sel turn rng mayEnd otherEnd m
    | turn == 1 = rng
    | mayEnd > 0 = mayEnd
    | otherEnd > 0 = otherEnd 
    | calPos > 0 = calPos
    | otherwise = rng
    where
        calPos = augPos r c 3 sel m

    
{- playAI -> Depenent del tipus de estratègia executa una comanada de moviment
    
    PARAMETRES:
        st      -> Indica el tipus d'estratègia que segueix el jugador indicat
        w       -> Representa l'estat actual de la partida, el tamany del tauler, el tauler i els jugadors que hi participen
-}
playAI :: Strats -> State -> IO ()
playAI Rng w = do
    
    putStrLn " "
    
    let ac= getAvailabeCols (row w) 1 (col w) (board w)
        
    r1 <- randInt 1 (length ac)
    
    let cn = getFromList r1 ac
    
    let g= insert cn (pid(player1 w)) (board w)
    
    let final= fst(checkWin (row w) (col w) 4 0 g)
    
    putStrLn " "
    
    printBoard (row w) (col w) g
    
    putStrLn " "
    
    if  final > 0
       then print ("Player " ++ (int2String (pid(player1 w))) ++ " wins !")
       else runGame (NewState ((turn w)+1) (row w) (col w) g (player2 w) (player1 w))
-- cridar funcio winOther (crida funcio chekc win i retorna pid i pos on pot guanyar, aka si diagonal agafa pos de dreta) si no comprovam quina pos puc "guanyar" amb linies de dist var 1->4
playAI Greedy w = do
    
    putStrLn " "
    
    let ac= getAvailabeCols (row w) 1 (col w) (board w)
    
    r1 <- randInt 1 (length ac)
    
    let rng = getFromList r1 ac
    
    let canEnd = checkWin (row w) (col w) 3 (pid(player1 w)) (board w)
    let otherEnd = checkWin (row w) (col w) 3 (pid(player2 w)) (board w)
    
    let pos = greedyMoove (row w) (col w) (pid(player1 w)) (turn w) rng (snd canEnd) (snd otherEnd) (board w)
    
    let g= insert pos (pid(player1 w)) (board w)
    
    let final= fst(checkWin (row w) (col w) 4 0 g)
    
    printBoard (row w) (col w) g
    
    
    putStrLn " "
    
    if  final > 0
       then print ("Player " ++ (int2String (pid(player1 w))) ++ " wins !")
       else runGame (NewState ((turn w)+1) (row w) (col w) g (player2 w) (player1 w))
    
playAI st w = print "F"


{- runGame -> S'encarrega de executar la jugada corresponent al jugador que li pertoca el torn
    
    PARAMETRES:
        w -> Representa l'estat actual de la partida, el tamany del tauler, el tauler i els jugadors que hi participen
-}
runGame :: State -> IO ()
runGame w = do
    
    if (turn w) == 1
       then printBoard (row w) (col w) (board w)
       else putStrLn " "
       
    let ac= getAvailabeCols (row w) 1 (col w) (board w)
    
    if (length ac) == 0
       then print "Draw ! Board is full !"
       else 
        if (strat(player1 w)) == Human
           then playHuman (NewState (turn w) (row w) (col w) (board w) (player1 w) (player2 w))
           else playAI (strat(player1 w)) (NewState (turn w) (row w) (col w) (board w) (player1 w) (player2 w))
