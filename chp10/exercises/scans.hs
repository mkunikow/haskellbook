module Scans where

-- scanl :: (a -> b -> a) -> a -> [b] -> [a]
-- scanl f q ls =
--     q : (case ls of
--         [] -> []
--         x:xs -> scanl f (f q x) xs)



fibs = 1 : scanl (+) 1 fibs

fibsFirst20 = take 20 fibs

fibsLessThen100 = filter (< 100) fibs

-- TODO rewrite usign scanl
-- factorial :: Integer -> Integer
-- factorial 0 = 1
-- factorial n = n * factorial (n - 1)
--  [1, 1*2, 1*2*3, 1*2*3*4, 1*2*3*4*5]

factorial  = 1 :  scanl (\acc b -> acc * (fromIntegral (div acc b) + 1)) 2 factorial




