module  CountingBad where

    data CountingBad a =
        Heisenberg Int a
        deriving (Eq, Show)
    
    -- super NOT okay
    instance Functor CountingBad where
        fmap   f       (Heisenberg n a) =
    --      (a -> b)        f        a  =
            Heisenberg (n+1) (f a)
    --          f               b
    