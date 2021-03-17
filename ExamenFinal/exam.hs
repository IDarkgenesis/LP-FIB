unicorn= do
    x <- [1,2,3]
    y <- [4,5]
    return x
    

rainbow x = do
    y <- x
    return (frozen y)
    
frozen :: Int -> Int
frozen x = x
