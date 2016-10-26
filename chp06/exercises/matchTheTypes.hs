
module MachTheType where

   import Data.List (sort)    
--    f :: Float
--    f :: Num a => a
--    f :: RealFrac a => a
   f :: Fractional a => a 
   f = 1.0


--    freud :: a -> a
--    freud :: Ord a => a -> a
   freud :: Int -> Int
   freud x = x

   myX = 1 :: Int
   sigmund :: Int -> Int
--    sigmund :: a -> a
--    sigmund :: Num a => a -> a
   sigmund x = myX

--    jung :: Ord a => [a] -> a
   jung :: [Int] -> Int
   jung xs = head (sort xs)

--    young :: [Char] -> Char
   young :: Ord a => [a] -> a
   young xs = head (sort xs)

   mySort :: [Char] -> [Char]
   mySort = sort

   signifier :: [Char] -> Char
--    signifier :: Ord a => [a] -> a
   signifier xs = head (mySort xs)






