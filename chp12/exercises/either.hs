module Either where

lefts' :: [Either a b] -> [a]
lefts' = foldr f []
    where
        f (Left a) acc = a : acc
        f (Right _) acc = acc


rights' :: [Either a b] -> [b]
rights' = foldr f []
    where
        f (Left _) acc =  acc
        f (Right b) acc = b: acc


partitionEithers' :: [Either a b] -> ([a], [b])
partitionEithers' = foldr f ([], [])
    where
        f (Left a)  (l, r) = (a : l , r)
        f (Right b) (l, r) = (l , b : r)

either' :: (a -> c) -> (b -> c) -> Either a b -> c
either'  fl _ (Left a) = fl a
either'  _ fr (Right b) = fr b

eitherMaybe'' :: (b -> c) -> Either a b -> Maybe c
eitherMaybe'' _ (Left _) = Nothing
eitherMaybe'' f (Right a) = Just (f a)




