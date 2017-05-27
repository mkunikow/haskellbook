module Cipher where

import Data.Char

ceasar :: Int -> String -> String
ceasar n  = map $ ceasarChar n


ceasarCharNcs :: Int -> Char -> Char
ceasarCharNcs shift c
    | isLower c = ceasarChar shift c
    | otherwise = ceasarCharUpperCase shift c

ceasarChar :: Int -> Char -> Char
ceasarChar  = ceasarCharRange 'a' 'z'

ceasarCharUpperCase :: Int -> Char -> Char
ceasarCharUpperCase  = ceasarCharRange 'A' 'Z'


ceasarCharRange :: Char -> Char -> Int -> Char -> Char
ceasarCharRange minChar maxChar n c
    | shifted > max = chr $ shifted - range
    | otherwise = chr shifted
    where max = ord maxChar
          min = ord minChar
          range = max - min + 1
          shift   = mod n range
          shifted = ord c + shift

vigenere :: String -> String -> String
vigenere keyword = vigenere' (cycle keyword)

vigenere' _ [] = ""
vigenere' keycycle  (' ':xs)   = ' ' : vigenere' keycycle xs
vigenere' (k : ks)  (x : xs)   = ceasarCharNcs shift x : vigenere' ks xs 
    where shift = ord (toLower k) - ord 'a'



testVinegre :: IO ()
testVinegre = 
    if vigenere "ALLY" "MEET AT DAWN"  ==  "MPPR AE OYWY"
    then putStrLn "vigenere fine!"
    else putStrLn "vigenere failed check"


testVinegreShort = 
    if vigenere "ALLY" "MEET"  ==  "MPPR"
    then putStrLn "vigenere fine!"
    else putStrLn "vigenere failed check"


main :: IO ()
main = do
  putStr "Enter  vigenere cypher:"  
  cyp <- getLine
  putStr "Enter text:"
  text <- getLine
  putStrLn $ "Encoded text:" ++  vigenere cyp text