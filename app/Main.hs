{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-wolfram-yanis.harkouk
-- File description:
-- Main
-}

module Main (main) where

import SetConf
import System.Environment(getArgs)
import Data.Maybe

main :: IO (Maybe Int)
main = do
    wolframOptions <- getArgs
    let maybeWolframConf = getOpts (defaultConf) (wolframOptions)
    _ <- checkConf (maybeWolframConf)
    let wolframConf = fromJust (maybeWolframConf)
    callRule (wolframConf)
