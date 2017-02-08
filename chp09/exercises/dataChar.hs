module DataChar where
import Data.Char

toUpperCase :: String -> String
toUpperCase  = map toUpper

capitalize :: String -> String
capitalize [] = []
capitalize (x : xs) = toUpper x : xs


toUpperCaseRec :: String -> String
toUpperCaseRec [] = []
toUpperCaseRec (x : xs) = toUpper x : toUpperCaseRec xs

capitalizeHead :: String -> Char
capitalizeHead = toUpper . head
