module StringProcessing where


notThe :: String -> Maybe String
notThe "the"    = Nothing
notThe s        = Just s

notTheExtract' :: Maybe String -> String
notTheExtract' Nothing  = "a"
notTheExtract' (Just s)   = s

replaceThe :: String -> String
replaceThe str = unwords  $ map (notTheExtract'. notThe ) $ words str

testReplaceThe :: IO ()
testReplaceThe =
    if replaceThe "the cow loves us" == "a cow loves us"
    then putStrLn "replaceThe fine!"
    else putStrLn "replaceThe failed!"


isVowel :: Char -> Bool
isVowel x = x `elem` "aeiouAEIOU"

isFirstLetterVowel :: String -> Bool
isFirstLetterVowel [] = False
isFirstLetterVowel (x: xs) = isVowel x

countTheBeforeVowel :: String -> Integer
countTheBeforeVowel s = countTheBeforeVowel' 0 $ words s

countTheBeforeVowel' :: Integer -> [String] -> Integer
countTheBeforeVowel' acc [] = acc
countTheBeforeVowel' acc ("the":x:xs)
    | isFirstLetterVowel x  = countTheBeforeVowel' (acc + 1) xs
    | otherwise             = countTheBeforeVowel' acc xs
countTheBeforeVowel' acc (_:xs) = countTheBeforeVowel' acc xs 

testCountTheBeforeVowel :: IO ()
testCountTheBeforeVowel = 
    if countTheBeforeVowel "the evil cow" == 1
    then putStrLn "countTheBeforeVowel fine!"
    else putStrLn "countTheBeforeVowel failed!"


countVowels :: String -> Integer
countVowels = sum . countVowelsToList'

countVowelsToList' :: String -> [Integer]
countVowelsToList'  = concatMap (\c -> if isVowel c then [1] else [0])

testCountVowels :: IO ()
testCountVowels = 
    if countVowels "Mikolajczak" == 4
    then putStrLn "countVowels fine!"
    else putStrLn "countVowels failed!"

