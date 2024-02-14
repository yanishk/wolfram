{-
-- EPITECH PROJECT, 2024
-- bs_wolfram
-- File description:
-- rule30
-}

printWidth :: Int -> IO (Maybe Int)
printWidth width
    | width > 0 = putStr(" ") >> printWidth (width - 1)
    | otherwise = return (Just 0)

printRule30Lines :: String -> Int -> Int -> Int -> IO (Maybe Int)
printRule30Lines previousLine 0 width start = return (Just 0)
printRule30Lines previousLine n width 0 = printWidth (width) >> putStrLn (previousLine) >>
    printRule30Lines (getNextRule30Line ("  " ++ previousLine ++ "  ")) (n - 1) (width - 1) 0
printRule30Lines previousLine n width start =
    printRule30Lines (getNextRule30Line ("  " ++ previousLine ++ "  ")) n width (start - 1)

getNextRule30Line :: String -> String
getNextRule30Line [] = []
getNextRule30Line (x:xs) = rule30 (x : take 2 xs) ++ getNextRule30Line xs

rule30 :: String -> String
rule30 "***" = " "
rule30 "** " = " "
rule30 "* *" = " "
rule30 "*  " = "*"
rule30 " **" = "*"
rule30 " * " = "*"
rule30 "  *" = "*"
rule30 "   " = " "
rule30 _ = []

printRule90Lines :: String -> Int -> Int -> Int -> IO (Maybe Int)
printRule90Lines previousLine 0 width start = return (Just 0)
printRule90Lines previousLine n width 0 = printWidth (width) >> putStrLn (previousLine) >>
    printRule90Lines (getNextRule90Line ("  " ++ previousLine ++ "  ")) (n - 1) (width - 1) 0
printRule90Lines previousLine n width start =
    printRule90Lines (getNextRule90Line ("  " ++ previousLine ++ "  ")) n width (start - 1)

getNextRule90Line :: String -> String
getNextRule90Line [] = []
getNextRule90Line (x:xs) = rule90 (x : take 2 xs) ++ getNextRule90Line xs

rule90 :: String -> String
rule90 "***" = " "
rule90 "** " = "*"
rule90 "* *" = " "
rule90 "*  " = "*"
rule90 " **" = "*"
rule90 " * " = " "
rule90 "  *" = "*"
rule90 "   " = " "
rule90 _ = []

printRule110Lines :: String -> Int -> Int -> Int -> IO (Maybe Int)
printRule110Lines previousLine 0 width start = return (Just 0)
printRule110Lines previousLine n width 0 = printWidth (width) >> putStrLn (previousLine) >>
    printRule110Lines (getNextRule110Line ("  " ++ previousLine ++ "  ")) (n - 1) (width - 1) 0
printRule110Lines previousLine n width start =
    printRule110Lines (getNextRule110Line ("  " ++ previousLine ++ "  ")) n width (start - 1)

getNextRule110Line :: String -> String
getNextRule110Line [] = []
getNextRule110Line (x:xs) = rule110 (x : take 2 xs) ++ getNextRule110Line xs

rule110 :: String -> String
rule110 "***" = " "
rule110 "** " = "*"
rule110 "* *" = "*"
rule110 "*  " = " "
rule110 " **" = "*"
rule110 " * " = "*"
rule110 "  *" = "*"
rule110 "   " = " "
rule110 _ = []
