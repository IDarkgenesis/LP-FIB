select :: Char -> String
select c
    | c == 'A' || c == 'a' = "Hello!"
    | otherwise = "Bye!"

main = do
    c <- getChar
    putStrLn $ select c
