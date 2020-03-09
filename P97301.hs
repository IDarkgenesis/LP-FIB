getAct :: Int -> Either Int String

getAct x
    | mod(x,3) == 0 && mod(x,5) == 0 = Right ("FizzBuzz")
    | mod(x,3) == 0 = Right("Fizz")
    | mod(x,5) == 0 = Right("Buzz")
    | otherwise = Left(x)
    
fizzBuzz :: [Either Int String]

fizzBuzz = fizzBuzz' (iterate (+1) 0)
    where 
        fizzBuzz' (x:xs) = getAct x : fizzBuzz' [next | next <- xs]
