module Maybe where

import Data.Foldable (toList)

-- Small library for Maybe
-- Write the following functions. This may take some time.

-- 1. Simple boolean checks for Maybe values.

-- >>> isJust (Just 1)
-- True
-- >>> isJust Nothing
-- False

isJust :: Maybe a -> Bool
isJust Nothing = False
isJust (Just _) = True

-- >>> isNothing (Just 1)
-- False
-- >>> isNothing Nothing
-- True

isNothing :: Maybe a -> Bool
isNothing Nothing = True
isNothing (Just _) = False

isNothing2 x  = not (isJust x)


-- 2. The following is the Maybe catamorphism. You can turn a Maybe
-- value into anything else with this.
-- >>> mayybee 0 (+1) Nothing
-- 0
-- >>> mayybee 0 (+1) (Just 1)
-- 2
mayybee :: b -> (a -> b) -> Maybe a -> b
mayybee b _ Nothing = b
mayybee b f (Just a) = f a

-- 3. In case you just want to provide a fallback value.
-- >>> fromMaybe 0 Nothing
-- 0
-- >>> fromMaybe 0 (Just 1)
-- 1
fromMaybe :: a -> Maybe a -> a
fromMaybe a Nothing  = a
fromMaybe a (Just b) = b

-- Try writing it in terms of the maybe catamorphism

-- 4. Converting between List and Maybe.

-- >>> listToMaybe [1, 2, 3]
-- Just 1
-- >>> listToMaybe []
-- Nothing
listToMaybe :: [a] -> Maybe a
listToMaybe [] = Nothing
listToMaybe (x:xs) = Just x

-- >>> maybeToList (Just 1)
-- [1]
-- >>> maybeToList Nothing
-- []
maybeToList :: Maybe a -> [a]
maybeToList Nothing = []
maybeToList (Just a) = [a]

-- 5. For when we just want to drop the Nothing values from our list.

-- >>> catMaybes [Just 1, Nothing, Just 2]
-- [1, 2]
-- >>> catMaybes [Nothing, Nothing, Nothing]
-- []
catMaybes :: [Maybe a] -> [a]
catMaybes = concatMap  flatMaybe'

flatMaybe' Nothing = []
flatMaybe' (Just a) = [a]

flatMap f = concatMap (toList . f)

catMaybes2 :: [Maybe a] -> [a]
catMaybes2 = flatMap id

catMaybes3 [] = []
catMaybes3 (Nothing:xs) = catMaybes3 xs
catMaybes3 (Just a:xs) = a : catMaybes3 xs

-- using fold
catMaybe4 :: [Maybe a] -> [a]
catMaybe4 [] = []
catMaybe4 xs = foldr f [] xs
  where f Nothing xs'  = xs'
        f (Just a) xs' = a : xs'


-- 6. You’ll see this called “sequence” later.

-- >>> flipMaybe [Just 1, Just 2, Just 3]
-- Just [1, 2, 3]
-- >>> flipMaybe [Just 1, Nothing, Just 3]
-- Nothing
flipMaybe :: [Maybe a] -> Maybe [a]
flipMaybe xs = 
    if l1 == l2 
        then Just catMaybesRes 
        else Nothing
    where 
        catMaybesRes = catMaybes xs
        l1 = length xs
        l2 = length catMaybesRes

-- using fold
flipMaybe2 :: [Maybe a] -> Maybe [a]
flipMaybe2 [] = Just []
flipMaybe2 xs = foldr f (Just []) xs
    where 
        f _ Nothing         = Nothing
        f Nothing _          = Nothing
        f (Just a) (Just b) = Just (a : b)







