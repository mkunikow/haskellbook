module IterateAndunfoldr where

myIterate :: (a -> a) -> a -> [a]
myIterate f a = a : myIterate f (f a)

-- TODO check this
myUnfoldr :: (b -> Maybe (a, b)) -> b -> [a]
myUnfoldr f b  = go (f b) f
    where  go :: Maybe (a, b) -> (b -> Maybe (a, b))  -> [a]
           go Nothing _ = []
           go (Just (a , b) ) f = a : go (f b) f

betterIterate :: (a -> a) -> a -> [a]
betterIterate f = myUnfoldr (\b -> Just (b, f b))


