data Cat = Cat {fs :: String,
                ls :: String
                } deriving (Show)

checkLen :: [Int] -> Bool
checkLen chk = case len of
                    3  -> True
                where
                    len= length chk
