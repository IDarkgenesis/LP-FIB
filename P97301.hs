fizzBuzz :: [Either Int String]
fizzBuzz = fizzBuzz' (iterate (+1) 0)
    where 
        fizzBuzz' (x:xs) = aux : fizzBuzz [next | next <- xs]
    where 
        
    
