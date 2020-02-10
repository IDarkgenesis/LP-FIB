--FUNCIO VALOR ABSOLUT

absValue::Int -> Int

absValue n
  | n > 0 = n
  | otherwise = (*) n (-1)

--FUNCIO POTENCIA

power::Int -> Int -> Int

power n p
  | p == 0 = 1
  | otherwise = n * power n (p-1)

--FUNCIO SABER SI ES PRIMER

isPrime::Int -> Bool
isPrime 0 = False
isPrime 1 = False
isPrime n = isPrime' 2
    where
        isPrime'::Int -> Bool 
        isPrime' d
            | d*d > n = True
            | (mod n d) == 0 = False
            | otherwise = isPrime' (d+1)

--FUNCIO QUE RETORNA NUMERO FIBONACCI

slowFib::Int -> Int

slowFib 0 = 0
slowFib 1 = 1
slowFib n = slowFib(n-1) + slowFib(n-2)

