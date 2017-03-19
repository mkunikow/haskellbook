module Language where

import Data.Char (toUpper, isAlpha)
import Data.List (groupBy)
import Data.Function (on)


capitalizeWord :: String -> String
capitalizeWord [] = []
capitalizeWord (x:xs)
    | isAlpha x = toUpper x : xs
    | otherwise = x : capitalizeWord xs


capitalizeParagraph p =  concatMap capitalizeWord $ groupBy ((==) `on` (=='.')) p 
-- where (==) `on` (=='.') ~ \x y -> (x=='.') == (y =='.')


testCapitalizeWord :: IO  ()
testCapitalizeWord =
    if capitalizeWord "Titter" == "Titter" && capitalizeWord "titter" == "Titter"
    then putStrLn "capitalizeWord fine!"
    else putStrLn "capitalizeWord failed!" 

testCapitalizParagraph :: IO ()
testCapitalizParagraph =
    if capitalizeParagraph "blah. woot ha." == "Blah. Woot ha."
    then putStrLn "capitalizeParagraph fine!"
    else putStrLn "capitalizeParagraph failed!"

