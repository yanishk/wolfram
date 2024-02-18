{-
-- EPITECH PROJECT, 2024
-- wolfram
-- File description:
-- Main
-}

module Main (main) where

import System.Environment(getArgs)
import Text.Read(readMaybe)
import System.Exit
import Data.Maybe

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

data Conf = Conf
  { rule :: Maybe Int
  , start :: Maybe Int
  , dispLines :: Maybe Int
  , window :: Maybe Int
  , move :: Maybe Int } deriving (Show, Eq)

defaultConf :: Conf
defaultConf = Conf
    {rule = Nothing,
    start = (Just 0),
    dispLines = Nothing,
    window = (Just 80),
    move = (Just 0)}

getOpts :: Conf -> [String] -> Maybe Conf
getOpts dConf ("--rule":nb:r) = getOpts dConf {rule = readMaybe nb} r
getOpts dConf ("--start":nb:r) = getOpts dConf {start = readMaybe nb} r
getOpts dConf ("--lines":nb:r) = getOpts dConf {dispLines = readMaybe nb} r
getOpts dConf ("--window":nb:r) = getOpts dConf {window = readMaybe nb} r
getOpts dConf ("--move":nb:r) = getOpts dConf {move = readMaybe nb} r
getOpts dConf _
    | (rule dConf) == Nothing || (rule dConf) < (Just 0) = Nothing
    | (start dConf) == Nothing || (start dConf) < (Just 0) = Nothing
    | (window dConf) == Nothing || (window dConf) < (Just 0) = Nothing
    | (move dConf) == Nothing = Nothing
    | (dispLines dConf) /= Nothing && (dispLines dConf) < (Just 0) = Nothing
getOpts dConf [] = Just dConf

checkConf :: Maybe Conf -> IO (Maybe Int)
checkConf Nothing = exitWith (ExitFailure 84)
checkConf (Just _) = return (Just 0)

callRule :: Conf -> IO (Maybe Int)
callRule wolframConf
  | rule wolframConf == Just 30 = (printR30 "*" (dispLines wolframConf)
  (window wolframConf) (move wolframConf) (start wolframConf))
  | rule wolframConf == Just 90 = (printR90 "*" (dispLines wolframConf)
  (window wolframConf) (move wolframConf) (start wolframConf))
  | rule wolframConf == Just 110 = (printR110 "*" (dispLines wolframConf)
  (window wolframConf) (move wolframConf) (start wolframConf))
  | otherwise = return (Just 0)

main :: IO (Maybe Int)
main = do
    wolframOptions <- getArgs
    let maybeWolframConf = getOpts (defaultConf) (wolframOptions)
    _ <- checkConf (maybeWolframConf)
    let wolframConf = fromJust (maybeWolframConf)
    callRule (wolframConf)
