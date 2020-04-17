data Queue a = Queue [a] [a] 
    deriving (Show)
    
create :: Queue a
create = Queue [] []
 
push :: a -> Queue a -> Queue a
push x (Queue fst snd) = (Queue fst (x:snd))

top :: Queue a -> a
top (Queue [] snd) = head $ reverse $ snd
top (Queue fst snd) = head fst

pop :: Queue a -> Queue a
pop (Queue [] snd) = Queue (drop 1 (reverse snd)) []
pop (Queue fst snd) = Queue (drop 1 fst) snd

empty :: Queue a -> Bool
empty (Queue [] []) = True
empty (Queue fst snd) = False


instance Eq a => Eq (Queue a) 
    where
        (Queue [] []) == (Queue [] [])  = True
        (Queue f1 s1) == (Queue f2 s2)  = (f1 ++ reverse s1) == (f2 ++ reverse s2)


        
