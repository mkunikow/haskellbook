module SplitString where

splitString :: Char -> String -> [String]
splitString splitChar words =  reverse $ go words []
    where go rest acc
            | rest == "" = acc
            | otherwise = go r $ w : acc
            where t = dropWhile (== splitChar) rest
                  w = takeWhile (/= splitChar) t
                  r = dropWhile (/= splitChar) t

myWords :: String -> [String]
myWords = splitString ' '

myLines :: String -> [String]
myLines = splitString '\n'
