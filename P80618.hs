data Queue a = Queue [a] [a] 
    deriving (Show)
    
create :: Queue a
create = Queue [] []
 
push :: a -> Queue a -> Queue a
push x (Queue out order) = (Queue out (x:order))

top :: Queue a -> a
top (Queue out order) = head $ reverse $ order  -- crear per dos estats de ses llistes

pop :: Queue a -> Queue a
pop (Queue out order) = 
