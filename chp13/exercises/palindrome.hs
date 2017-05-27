module Palindrome where

import Data.Char (toLower, isLetter)

palindrome :: String -> Bool
palindrome line1 = l == reverse l
        where l = filter isLetter $ map toLower line1


testPalindrome :: IO ()
testPalindrome = 
    if palindrome "MadamI’m Adam"
    then putStrLn "palindrome fine!"
    else putStrLn "palindrome failed!"