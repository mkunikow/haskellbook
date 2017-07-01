module Main where

import Data.Char (toUpper, toLower)
import Data.List

import Test.QuickCheck
import Test.QuickCheck.Modifiers (NonZero)
import Test.QuickCheck.Function (apply, Fun(..))

-- 1.  for a function
half x = x / 2
halfIdentity = (*2) . half

propHalf :: Float -> Bool
propHalf x = halfIdentity x == x

-- 2.
listOrdered :: (Ord a) => [a] -> Bool
listOrdered xs = snd $ foldr go (Nothing, True) xs
  where go _ status@(_, False) = status
        go y (Nothing, t) = (Just y, t)
        go y (Just x, t) = (Just y, x >= y)

propListOrdered :: [Int] -> Bool
propListOrdered xs
    | listOrdered xs = xs == sort xs
    | otherwise      = xs /= sort xs

-- 3.
plusAssociative :: Int -> Int -> Int -> Bool
plusAssociative x y z =
  x + (y + z) == (x + y) + z

plusCommutative :: Int -> Int -> Bool
plusCommutative x y =
  x + y == y + x

-- 4.
multiAssociative :: Int -> Int -> Int -> Bool
multiAssociative x y z =
  x * (y * z) == (x * y) * z

  
multiCommutative :: Int -> Int -> Bool
multiCommutative x y =
  x * y == y * x

-- 5.
propQuotRem :: NonZero Int -> NonZero Int -> Bool
propQuotRem (NonZero x) (NonZero y) =
  (quot x y)*y + (rem x y) == x

propDivMod :: NonZero Int -> NonZero Int -> Bool
propDivMod (NonZero x) (NonZero y) =
  (div x y)*y + (mod x y) == x

-- 6.
powerAssociative :: Int -> Int -> Int -> Bool
powerAssociative x y z
  = x ^ (y ^ z) == (x ^ y) ^ z

powerCommutative :: Int -> Int -> Bool
powerCommutative x y 
  = x ^ y == y ^ x

-- 7.
propReverse :: [Int] -> Bool
propReverse xs = (reverse . reverse)  xs == xs

-- 8.
propApply :: Fun Int Int -> Int -> Bool
propApply  (Fun _ f) a = (f $ a) == (f a)

propCompose ::Fun Char Double -> Fun Int Char -> Int -> Bool
propCompose  (Fun _ f) (Fun _ g) x = (f . g) x == f (g x)

-- 9.

propConcatF1 :: String -> String -> Bool
propConcatF1 xs ys = foldr (:) xs ys == (++) xs ys

propConcatF2 :: [String] -> Bool
propConcatF2 xs = foldr (++) [] xs == concat xs

-- 10.
propLenTakeN :: Int -> [Int] -> Bool
propLenTakeN n xs = length (take n xs) == n 

-- 11.
propReadShow :: Int -> Bool
propReadShow x = (read (show x)) == x

--Failure.

square x = x * x

squareIdentity :: Float -> Float
squareIdentity = square . sqrt

propSquare x = squareIdentity x == x

--Idempotence

twice f = f . f
fourTimes = twice . twice

capitalizeWord :: String -> String
capitalizeWord [] = []
capitalizeWord x = toUpper (head x) : map toLower (tail x)



propCapitalize :: String -> Bool
propCapitalize x =
  (capitalizeWord x == twice capitalizeWord x) && (capitalizeWord x == fourTimes capitalizeWord x)

propSort :: [Int] -> Bool
propSort x =
  (sort x == twice sort x) && (sort x == fourTimes sort x)

 

main :: IO ()
main = do
  quickCheck propHalf
  quickCheck propListOrdered
  quickCheck plusAssociative
  quickCheck plusCommutative
  quickCheck multiCommutative
  quickCheck propQuotRem
  quickCheck propDivMod
  -- quickCheck powerAssociative
  -- quickCheck powerCommutative
  quickCheck propReverse
  quickCheck propApply
  quickCheck propCompose
  -- quickCheck propConcatF1
  quickCheck propConcatF2
  -- quickCheck propLenTakeN
  quickCheck propReadShow
  -- quickCheck propSquare
  quickCheck propCapitalize
  quickCheck propSort