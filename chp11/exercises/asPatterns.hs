module AsPatterns where

import Data.Char

isSubsequenceOf :: (Eq a) => [a] -> [a] -> Bool
isSubsequenceOf [] _ = True
isSubsequenceOf _ [] = False
isSubsequenceOf all@(x:xs) (y:ys)
    | x == y    = isSubsequenceOf xs  ys
    | otherwise = isSubsequenceOf all ys 


capitalizeWords :: String -> [(String, String)]
capitalizeWords xs = map f $ words xs
  where f word@(s:st) = (word, toUpper s : st)


capitalised :: String -> String
capitalised [] = []
capitalised x = toUpper (head x) : map toLower (tail x)

lowercase :: String -> String
lowercase [] = []
lowercase xs = map toLower xs

testIsSubsequenceOf :: IO ()
testIsSubsequenceOf = 
    if isSubsequenceOf "AF" "ABCDF"
    then putStrLn "isSubsequenceOf fine" 
    else putStrLn "isSubsequenceOf failed"

testCapitalizeWords :: IO ()
testCapitalizeWords = 
    if capitalizeWords "hello world" == [("hello", "Hello"), ("world", "World")]
    then putStrLn "capitalizeWords fine" 
    else putStrLn "capitalizeWords failed"
