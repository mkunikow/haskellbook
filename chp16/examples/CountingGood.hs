module  CountingGood where

    data CountingGood a =
        Heisenberg Int a
        deriving (Eq, Show)
    
    -- Totes cool.
    instance Functor CountingGood where
        fmap f (Heisenberg n a) =
            Heisenberg n (f a)
    