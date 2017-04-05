module Phone where

import Data.Map (Map)
import qualified Data.Map as Map
import Data.Maybe (Maybe)
import Data.Char (toLower, isLower)
import Data.List (maximumBy, sort, group)
import Data.Function (on)


data DaPhone = DaPhone (Map Char [(Digit, Presses)])

convo :: [String]
convo =
    ["Wanna play 20 questions",
        "Ya",
        "U 1st haha",
        "Lol ok. Have u ever tasted alcohol lol",
        "Lol ya",
        "Wow ur cool haha. Ur turn",
        "Ok. Do u think I am pretty Lol",
        "Lol ya",
        "Haha thanks just making sure rofl ur turn"]

-- validButtons = "1234567890*#"
type Digit = Char

-- Valid presses: 1 and up
type Presses = Int

phoneMap = Map.fromList 
    [
        ('a', [('2', 1)]),
        ('b', [('2', 2)]),
        ('c', [('2', 3)]),
        ('d', [('3', 1)]),
        ('e', [('3', 2)]),
        ('f', [('3', 3)]),
        ('g', [('4', 1)]),
        ('h', [('4', 2)]),
        ('i', [('4', 3)]),
        ('j', [('5', 1)]),
        ('k', [('5', 2)]),
        ('l', [('5', 3)]),
        ('m', [('6', 1)]),
        ('n', [('6', 2)]),
        ('o', [('6', 3)]),
        ('p', [('7', 1)]),
        ('q', [('7', 2)]),
        ('r', [('7', 3)]),
        ('s', [('7', 4)]),
        ('t', [('8', 1)]),
        ('u', [('8', 2)]),
        ('v', [('8', 3)]),
        ('w', [('9', 1)]),
        ('x', [('9', 2)]),
        ('y', [('9', 3)]),
        ('z', [('9', 4)])
    ]

daPhone :: DaPhone
daPhone = DaPhone phoneMap

reverseTaps :: DaPhone -> Char -> [(Digit, Presses)]
reverseTaps dp c
    | isLower c = reverseTaps' dp c
    | otherwise = ('*', 1) : reverseTaps' dp (toLower c)

reverseTaps' :: DaPhone -> Char -> [(Digit, Presses)]
reverseTaps' (DaPhone database) c  = fromMaybeWithError $ Map.lookup c database

fromMaybeWithError:: Maybe a -> a
fromMaybeWithError (Just a) = a


-- assuming the default phone definition
-- 'a' -> [('2', 1)]
-- 'A' -> [('*', 1), ('2', 1)]

cellPhonesDead :: DaPhone
    -> String
    -> [(Digit, Presses)]
cellPhonesDead dp = concatMap (reverseTaps dp)

fingerTaps :: [(Digit, Presses)] -> Presses
fingerTaps = foldr (\(x,y) acc -> y + acc) 0

mostPopularLetter :: String -> Char
mostPopularLetter = mostPopularInList

mostPopularLetter2 :: String -> Char
mostPopularLetter2 = head . longest . group . sort

longest :: [[a]] -> [a]
longest = maximumBy (compare `on` length)

charCost' :: Char -> Presses
charCost' c = fingerTaps $ reverseTaps daPhone c

coolestLtr :: [String] -> Char
coolestLtr = mostPopularLetter . concat

coolestWord :: [String] -> String
coolestWord  = mostPopularInList

mostPopularInList xs  = fst $ maximumBy (compare `on` snd) freqChar
    where freqChar = listToFreqMap xs

listToFreqMap xs = Map.toList $ Map.fromListWith (+) [(x, 1) | x <- xs]

testReverseTaps :: IO ()
testReverseTaps = 
    if reverseTaps daPhone 'a' == [('2', 1)] 
        && reverseTaps daPhone 'A' == [('*', 1), ('2', 1)]
    then putStrLn "reverseTaps fine!"    
    else putStrLn "reverseTaps failed!"

testCellPhonesDead :: IO ()
testCellPhonesDead =
    if cellPhonesDead daPhone "Ab" ==[('*', 1), ('2', 1), ('2', 2)]
    then putStrLn "cellPhonesDead fine!"
    else putStrLn "cellPhonesDead failed!"

testFingerTaps :: IO ()
testFingerTaps = 
    if fingerTaps [('1', 1), ('2', 2), ('3',3)] == 6
    then putStrLn "fingerTaps fine!"
    else putStrLn "fingerTaps failes!"

testMostPopularLetter :: IO ()
testMostPopularLetter = 
    if mostPopularLetter "abbaaac" == 'a'
    then putStrLn "mostPopularLetter fine!"
    else putStrLn "mostPopularLetter failed!"


testCoolestWord :: IO ()
testCoolestWord = 
    if coolestWord ["cool", "test2", "cool"] == "cool"
    then putStrLn "coolestWord fine!"
    else putStrLn "coolestWord failed!"
   