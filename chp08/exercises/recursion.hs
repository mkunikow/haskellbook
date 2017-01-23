module Recursion where

sumTo :: (Eq a, Num a) => a -> a
sumTo n = go n 1 0
    where go n num acc
            | n == 0 = acc
            | otherwise = go (n -1) (num + 1) (acc + num)

multiply ::  (Integral a) => a -> a -> a
multiply a b = go a b 0
    where go x y acc
            | y == 0 = acc
            | otherwise = go x (y - 1) (acc + x)
