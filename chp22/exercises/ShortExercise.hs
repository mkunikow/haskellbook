module ShortExercise where

import Data.Char
import Control.Applicative

cap :: [Char] -> [Char]
cap xs = map toUpper xs

rev :: [Char] -> [Char]
rev xs = reverse xs

composed :: [Char] -> [Char]
composed = cap . rev

fmapped :: [Char] -> [Char]
fmapped = fmap cap rev

tupled :: [Char] -> ([Char], [Char])
tupled = do
    c <- cap
    r <- rev
    return (r, c)

tupled2 :: [Char] -> ([Char], [Char])
tupled2 = liftA2 (,) cap rev 
