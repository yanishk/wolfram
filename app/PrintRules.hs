{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-wolfram-yanis.harkouk
-- File description:
-- PrintRules
-}

module PrintRules
    (   printWidth,
        printR30,
        getNextR30Line,
        rule30,
        printR90,
        getNextR90Line,
        rule90,
        printR110,
        getNextR110Line,
        rule110
    ) where

printWidth :: Int -> IO (Maybe Int)
printWidth width
    | width > 0 = putStr(" ") >> printWidth (width - 1)
    | otherwise = return (Just 0)

printR30 :: String -> Maybe Int -> Maybe Int -> Maybe Int -> Maybe Int -> IO (Maybe Int)
printR30 _ (Just 0) (Just _) (Just _) (Just _) = return (Just 0)
printR30 str (Just linesNb) (Just wdw) (Just mv) (Just 0) =
    printWidth (wdw + mv) >> putStrLn (str) >>
    printR30 (getNextR30Line ("  " ++ str ++ "  "))
    (Just (linesNb - 1)) (Just (wdw - 1)) (Just mv) (Just 0)
printR30 str Nothing (Just wdw) (Just mv) (Just 0) = printWidth (wdw + mv)
    >> putStrLn (str) >> printR30 (getNextR30Line ("  " ++ str ++ "  "))
    Nothing (Just (wdw - 1)) (Just mv) (Just 0)
printR30 str (Just linesNb) (Just wdw) (Just mv) (Just st) =
    printR30 (getNextR30Line ("  " ++ str ++ "  ")) (Just linesNb)
    (Just wdw) (Just mv) (Just (st - 1))

getNextR30Line :: String -> String
getNextR30Line [] = []
getNextR30Line (x:xs) = rule30 (x : take 2 xs) ++ getNextR30Line xs

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

printR90 :: String -> Maybe Int -> Maybe Int -> Maybe Int -> Maybe Int -> IO (Maybe Int)
printR90 _ (Just 0) (Just _) (Just _) (Just _) = return (Just 0)
printR90 str (Just linesNb) (Just wdw) (Just mv) (Just 0) =
    printWidth (wdw + mv) >> putStrLn (str) >>
    printR90 (getNextR90Line ("  " ++ str ++ "  "))
    (Just (linesNb - 1)) (Just (wdw - 1)) (Just mv) (Just 0)
printR90 str Nothing (Just wdw) (Just mv) (Just 0) = printWidth (wdw + mv)
    >> putStrLn (str) >> printR90 (getNextR90Line ("  " ++ str ++ "  "))
    Nothing (Just (wdw - 1)) (Just mv) (Just 0)
printR90 str (Just linesNb) (Just wdw) (Just mv) (Just st) =
    printR90 (getNextR90Line ("  " ++ str ++ "  ")) (Just linesNb)
    (Just wdw) (Just mv) (Just (st - 1))

getNextR90Line :: String -> String
getNextR90Line [] = []
getNextR90Line (x:xs) = rule90 (x : take 2 xs) ++ getNextR90Line xs

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

printR110 :: String -> Maybe Int -> Maybe Int -> Maybe Int -> Maybe Int -> IO (Maybe Int)
printR110 _ (Just 0) (Just _) (Just _) (Just _) = return (Just 0)
printR110 str (Just linesNb) (Just wdw) (Just mv) (Just 0) =
    printWidth (wdw + mv) >> putStrLn (str) >>
    printR110 (getNextR110Line ("  " ++ str ++ "  "))
    (Just (linesNb - 1)) (Just (wdw - 1)) (Just mv) (Just 0)
printR110 str Nothing (Just wdw) (Just mv) (Just 0) = printWidth (wdw + mv)
    >> putStrLn (str) >> printR110 (getNextR110Line ("  " ++ str ++ "  "))
    Nothing (Just (wdw - 1)) (Just mv) (Just 0)
printR110 str (Just linesNb) (Just wdw) (Just mv) (Just st) =
    printR110 (getNextR110Line ("  " ++ str ++ "  ")) (Just linesNb)
    (Just wdw) (Just mv) (Just (st - 1))

getNextR110Line :: String -> String
getNextR110Line [] = []
getNextR110Line (x:xs) = rule110 (x : take 2 xs) ++ getNextR110Line xs

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
