module RewritingFunctionsUsingFolds where

myAnd :: [Bool] -> Bool
myAnd = foldr (&&) True


myOr :: [Bool] -> Bool
myOr = foldr (||) False


myOr2 :: [Bool] -> Bool
myOr2 = or



myAny :: (a -> Bool) -> [a] -> Bool
myAny f = foldr (\ a b ->  f a || b) False

myElem :: Eq a => a -> [a] -> Bool
myElem e = foldr (\a b -> e == a || b) False

myElem2 :: Eq a => a -> [a] -> Bool
myElem2 e = any (== e) 

myReverse :: [a] -> [a]
myReverse = foldr (\a b -> b ++ [a]) []

myMap :: (a -> b) -> [a] -> [b]
myMap f = foldr (\a b -> f a : b ) []

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter f  = foldr (\a b -> if f a then a : b else b) []

squish :: [[a]] -> [a]
squish = foldr (++) []

squish2 :: [[a]] -> [a]
squish2 = concat

squishMap :: (a -> [b]) -> [a] -> [b]
squishMap f = foldr (\a b -> f a ++ b) []

squishAgain :: [[a]] -> [a]
squishAgain = squishMap id

myMaximumBy :: (a -> a -> Ordering) -> [a] -> a
myMaximumBy _ [x] = x
myMaximumBy f (x:xs) = foldl (\a b -> if f a b == GT then a else b) x xs

myMinimumBy :: (a -> a -> Ordering) -> [a] -> a
myMinimumBy _ [x] = x
myMinimumBy f (x:xs) = foldl (\a b -> if f a b == LT then a else b) x xs



main :: IO ()
-- main = print $ myOr [False, False, False, False]
-- main = print $ squishMap (\x -> "WO " ++ [x] ++ " OT ") "blah" 
-- main = print $ squishAgain [[1,2], [3,4]]
-- main = print $ myMaximumBy (\_ _ -> GT) [1..10]
-- main = print $ myMaximumBy (\_ _ -> GT) [1..10]
main = print $ myMinimumBy (\_ _ -> LT) [1..10]

