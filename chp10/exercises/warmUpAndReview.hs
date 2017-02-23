module WarmUpAndReview where

stops = "pbtdkg"
vowels = "aeiou"

nouns = ["family", "committee", "corporation","faculty", "army", "school"]
verbs = ["accept",  "add",  "admire",  "admit",  "advise", "afford",  "agree", "alert", "allow"]

sentence = "In birds we distinguish between the following regions of the axial skeleton."


stopVowelStopCombinations :: String -> String -> [(Char, Char, Char)]
stopVowelStopCombinations stops vowels = [(x, y, z) | x <- stops, y <- vowels, z <- stops, x /= z]


stopVowelStopCombinations2 :: String -> String -> [(Char, Char, Char)]
stopVowelStopCombinations2 stops vowels = [(x, y, z) | x <- stops, y <- vowels, z <- stops, x /= z, x == 'p', y == 'a']

nounVerbNoun :: [String] -> [String] -> [(String, String, String)]
nounVerbNoun nouns verbs =  [(x, y, z) | x <- nouns, y <- verbs, z <- nouns, x /= z]

seekritFunc :: String -> Int
seekritFunc x = div (sum (map length (words x))) (length (words x))


seekritFunc2  ::  Fractional a => String -> a
seekritFunc2 x = fromIntegral (sum (map length (words x))) / fromIntegral (length (words x))

main :: IO ()
-- main = print $ stopVowelStopCombinations2 stops vowels
-- main = print $ nounVerbNoun nouns verbs
-- main = print $ seekritFunc sentence
main = print $ seekritFunc2 sentence