module BuldingFunctions where

funa :: String -> String
funa x = x ++ "!"

funb :: [a] -> a
funb x = x !! 4

func :: [a] -> [a]
func = drop 9

thirdLetter :: String -> Char
thirdLetter x = x !! 2

letterIndex :: Int -> Char
letterIndex x = "0123456789" !! x



