module Cipher where

import Data.Char

ceasar :: Int -> String -> String
ceasar n  = map $ ceasarChar n

ceasarChar :: Int -> Char -> Char
ceasarChar n c
    | shifted > max = chr $ shifted - range
    | otherwise = chr shifted
    where max = ord 'z'
          min = ord 'a'
          range = max - min + 1
          shift   = mod n range
          shifted = ord c + shift

unCeasar :: Int -> String -> String
unCeasar n  = map $ unCeasarChar n

unCeasarChar :: Int -> Char ->Char
unCeasarChar n c
    | shifted < min = chr $ shifted + range
    | otherwise = chr shifted
    where max = ord 'z'
          min = ord 'a'
          range = max - min + 1
          shift   = mod n range
          shifted = ord c - shift