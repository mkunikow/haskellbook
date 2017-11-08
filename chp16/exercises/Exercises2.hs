module Exercises2 where

--------------------------------------------------------------------
-- Rearrange the arguments to the type constructor of the datatype
-- so the Functor works.
--------------------------------------------------------------------

-- 1
data Sum a b =
    First a
    | Second b

instance Functor (Sum e) where
    fmap _ (First a) = First a
    fmap f (Second b) = Second (f b)

-- 2
data Company a b c =
    DeepBlue a c
    | Something b

instance Functor (Company e e') where
    fmap _ (Something b) = Something b
    fmap f (DeepBlue a c) = DeepBlue a (f c)

-- 3
data More a b =
    L a b a
    | R b a b
    deriving (Eq, Show)

instance Functor (More x) where
    fmap f (L a b a') = L a (f b) a'
    fmap f (R b a b') = R (f b) a (f b')
        
        
                
