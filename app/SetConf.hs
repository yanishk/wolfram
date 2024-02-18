{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-wolfram-yanis.harkouk
-- File description:
-- SetConf
-}

module SetConf
    (   defaultConf,
        getOpts,
        checkConf,
        callRule
    ) where

import PrintRules
import Text.Read(readMaybe)
import System.Exit

data Conf = Conf
  { rule :: Maybe Int,
   start :: Maybe Int,
   dispLines :: Maybe Int,
   window :: Maybe Int,
   move :: Maybe Int } deriving (Show, Eq)

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
getOpts _ _ = Nothing

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
