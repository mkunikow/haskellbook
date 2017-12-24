module MaybeExample where

-- f ~ Maybe
type M = Maybe

<*> :: f (a -> b) -> f a -> f b
<*> :: M (a -> b) -> M a -> M b

pure :: a -> f a
pure :: a -> M a
  