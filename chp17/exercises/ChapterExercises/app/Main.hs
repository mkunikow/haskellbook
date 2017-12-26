module Main where

import Lib

main :: IO ()
main = print $ combos "Abc" stops vowels
