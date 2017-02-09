module StandardFunctions where

myOr :: [Bool] -> Bool
myOr [] = False
myOr (x:xs) = x || myOr xs

myAny :: (a -> Bool) -> [a] -> Bool
myAny _ [] = False
myAny f (x : xs) = f x || myAny f xs

myElem :: Eq a => a -> [a] -> Bool
myElem e  = myAny (== e)

myReverse :: [a] -> [a]
myReverse [] = []
myReverse (x:xs) = myReverse xs ++ [x]

squish :: [[a]] -> [a]
squish [] = []
squish (x : xs) = x ++ squish xs

squishMap :: (a -> [b]) -> [a] -> [b]
squishMap _ []  = []
squishMap f (x:xs) = f x ++ squishMap f xs

--TODO check this
squishAgain :: [[a]] -> [a]
squishAgain  = squishMap id

myMaximumBy :: (a -> a -> Ordering) -> [a] -> a
myMaximumBy _ [] = undefined
myMaximumBy _ [x] = x
myMaximumBy f (x : xs) = g x xs
    where 
        g x1 [] = x1
        g x1 (x2: x2s) = g acc x2s
            where acc = if f x1 x2 == LT then x2 else x1


myMinimumBy :: (a -> a -> Ordering) -> [a] -> a
myMinimumBy _ [] = undefined
myMinimumBy _ [x] = x
myMinimumBy f (x : xs) = g x xs
    where 
        g x1 [] = x1
        g x1 (x2: x2s) = g acc x2s
            where acc = if f x1 x2 == LT then x1 else x2

myMaximum :: (Ord a) => [a] -> a
myMaximum = myMaximumBy compare

myMinimum :: (Ord a) => [a] -> a
myMinimum = myMinimumBy compare


        





