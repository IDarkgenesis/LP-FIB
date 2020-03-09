data Tree a = Node a (Tree a) (Tree a) | Empty deriving (Show)

size :: Tree a -> Int
size Empty = 0
size (Node _ tl tr) = 1 + size tl + size tr

height :: Tree a -> Int
height Empty = 0
height (Node _ tl tr) = 1 + max (height tl) (height tr)

equal :: Eq a => Tree a -> Tree a -> Bool
equal Empty Empty = True
equal (Node _ _ _) Empty = False
equal Empty (Node _ _ _) = False
equal (Node a tla tra) (Node b tlb trb) = (a == b) && (equal tla tlb) && (equal tra trb) 

preOrder :: Tree a -> [a]
preOrder Empty = []
preOrder (Node n tl tr) = [n] ++ preOrder tl ++ preOrder tr

inOrder :: Tree a -> [a]
inOrder Empty = []
inOrder (Node n tl tr) = inOrder tl ++ [n] ++ inOrder tr

postOrder :: Tree a -> [a]
postOrder Empty = []
postOrder (Node n tl tr) = postOrder tl ++ postOrder tr ++ [n]

breadthFirst :: Tree a -> [a]
breadthFirst t = breadthFirst' [t]
    where 
        breadthFirst':: [Tree a] ->  [a]
        breadthFirst' [] = []
        breadthFirst' ((Node n tl tr):xs) = n : breadthFirst' (xs ++ [tl,tr])
        breadthFirst' (Empty : xs) = breadthFirst' xs
