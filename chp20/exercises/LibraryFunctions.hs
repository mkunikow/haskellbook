module LibraryFunctions where

import Data.Foldable
import Data.Monoid
import Data.Semigroup

-- 1
sumF :: (Foldable t, Num a) => t a -> a
sumF = getSum . foldMap Sum --getSum . (foldMap Sum)

-- 2
productF :: (Foldable t, Num a) => t a -> a
productF x = getProduct $ foldMap Product x

-- 3
elemF :: (Foldable t, Eq a) => a -> t a -> Bool
elemF e = foldr (\x acc -> x == e || acc) False

elemF' :: (Foldable t, Eq a) => a -> t a -> Bool
elemF' x = getAny . foldMap (Any . eq)
  where
    eq = (==) x

-- 4
minimumF :: (Foldable t, Ord a) => t a -> Maybe a
minimumF = foldr f Nothing
  where
    f e Nothing = Just e
    f e (Just acc) = Just (min e acc)

-- 5
maximumF :: (Foldable t, Ord a) => t a -> Maybe a
maximumF = foldr f Nothing
  where
    f e Nothing = Just e
    f e (Just acc) = Just (max e acc)

-- 6
nullF :: (Foldable t) => t a -> Bool
nullF = foldr (\_ _ -> False) True

nullF' :: (Foldable t) => t a -> Bool
nullF' = getAll . foldMap (\_ -> All False)

-- 7
lengthF :: (Foldable t) => t a -> Int
lengthF = foldr (\_ acc -> acc + 1) 0

lengthF' :: (Foldable t) => t a -> Int
lengthF' = getSum . foldMap (\_ -> Sum 1)


-- 8  Some say this is all Foldable amounts to.
toListF :: (Foldable t) => t a -> [a]
toListF = foldr (:) []

toListF' :: Foldable t => t a -> [a]
toListF' = foldMap (:[]) --foldMap (\x -> [x])

-- 9 Hint: use foldMap.
-- | Combine the elements
-- of a structure using a monoid.
foldF :: (Foldable t, Monoid m) => t m -> m
foldF = foldMap id

-- 10
foldMapF :: (Foldable t, Monoid m) => (a -> m) -> t a -> m
foldMapF f = foldr (\x acc -> f x `mappend` acc) mempty
