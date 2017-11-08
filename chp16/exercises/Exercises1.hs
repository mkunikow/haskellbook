module Exercise1 where

import GHC.Arr
    
----------------------------------------------------------------------------
--   Determine if a valid Functor can be written for the datatype provided.
----------------------------------------------------------------------------
        
-- 1    
data Bool = False | True
-- Bool :: *
-- No

-- 2
data BoolAndSomethingElse a =
    False' a | True' a

instance Functor BoolAndSomethingElse where
    fmap f (False' a) = False' (f a)
    fmap f (True' a)  = True' (f a)

-- 3
data BoolAndMaybeSomethingElse a =
    Falsish | Truish a

instance Functor BoolAndMaybeSomethingElse where
    fmap f (Truish a) = Truish (f a)
    fmap _ Falsish = Falsish

-- 4
newtype Mu f = InF { outF :: f (Mu f) }
-- Mu :: (* -> *) -> *
-- Yes ?


-- 5
data D =
    D (Array Word Word) Int Int
-- D :: *
-- No
    


    
    
            

    