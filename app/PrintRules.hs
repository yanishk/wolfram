{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-wolfram-yanis.harkouk
-- File description:
-- PrintRules
-}

module PrintRules
    (   printWidth,
        printRule,
        getNextRuleLine,
        genericRule,
    ) where

printWidth :: Int -> IO (Maybe Int)
printWidth width
    | width > 0 = putStr(" ") >> printWidth (width - 1)
    | otherwise = return (Just 0)

printLine :: Int -> Int -> String -> IO ()
printLine wdw mv str = printWidth (div (wdw + mv) 2) >> putStr (str) >>
    printWidth (div (wdw + mv) 2) >> putStrLn("")

printRule :: String -> String -> Maybe Int -> Maybe Int -> Maybe Int -> Maybe Int -> IO (Maybe Int)
printRule _ _ (Just 0) (Just _) (Just _) (Just _) = return (Just 0)
printRule str binaryRule (Just linesNb) (Just wdw) (Just mv) (Just 0) =
    printLine (wdw) (mv) (str) >>
    printRule (getNextRuleLine ("  " ++ str ++ "  ") binaryRule)
    binaryRule (Just (linesNb - 1)) (Just (wdw - 1)) (Just (mv - 1)) (Just 0)
printRule str binaryRule Nothing (Just wdw) (Just mv) (Just 0) =
    printLine (wdw) (mv) (str) >> printRule (getNextRuleLine
    ("  " ++ str ++ "  ") binaryRule) binaryRule Nothing (Just (wdw - 1))
    (Just (mv - 1)) (Just 0)
printRule str binaryRule (Just linesNb) (Just wdw) (Just mv) (Just st) =
    printRule (getNextRuleLine ("  " ++ str ++ "  ") binaryRule)
    binaryRule (Just linesNb) (Just wdw) (Just mv) (Just (st - 1))

getNextRuleLine :: String -> String -> String
getNextRuleLine [] _ = []
getNextRuleLine (x:xs) binaryRule = genericRule (x : take 2 xs) (binaryRule)
    ++ getNextRuleLine xs binaryRule

genericRule :: String -> String -> String
genericRule "***" binaryRule = [binaryRule !! 0]
genericRule "** " binaryRule = [binaryRule !! 1]
genericRule "* *" binaryRule = [binaryRule !! 2]
genericRule "*  " binaryRule = [binaryRule !! 3]
genericRule " **" binaryRule = [binaryRule !! 4]
genericRule " * " binaryRule = [binaryRule !! 5]
genericRule "  *" binaryRule = [binaryRule !! 6]
genericRule "   " binaryRule = [binaryRule !! 7]
genericRule _ _ = []
