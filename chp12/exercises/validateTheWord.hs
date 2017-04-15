module ValidateTheWord where

newtype Word' =
    Word' String
    deriving (Eq, Show)

vowels = "aeiou"
consonants = "bcdfghjklmnpqrstvwxyz"

isVowel :: Char -> Bool
isVowel = flip elem vowels

isConsonants :: Char -> Bool
isConsonants = flip elem consonants

countVowels :: String -> Integer
countVowels  = sum . concatMap (\c -> if isVowel c then [1] else [0])

countConsonants :: String -> Integer
countConsonants  = sum . concatMap (\c -> if isConsonants c then [1] else [0])

mkWord :: String -> Maybe Word'
mkWord word = 
    if vowelsCount > consonantsCount 
        then Nothing 
        else Just (Word' word)
    where 
        vowelsCount = countVowels word
        consonantsCount = countConsonants word

testMkWord :: IO ()
testMkWord = if mkWord "aabbb" == Just (Word' "aabbb")
    then putStrLn "mkWord fine"
    else putStrLn "mkWord failed!"
