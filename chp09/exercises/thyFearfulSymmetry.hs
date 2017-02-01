module ThyFearfulSymmetry where

myWords :: String -> [String]
myWords words =  reverse $ go words []
    where go rest acc
            | rest == "" = acc
            | otherwise = go r $ w : acc
            where t = dropWhile (== splitChar) rest
                  w = takeWhile (/= splitChar) t
                  r = dropWhile (/= splitChar) t
                  splitChar = ' '

main :: IO ()
main =
    print $ "myWords 'all i wanna do is have some fun' " ++ show (myWords "all i wanna do is have some fun")