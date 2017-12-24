module IdentityExample where
-- f ~ Identity
-- Applicative f =>
type Id = Identity

<*> :: f (a -> b) -> f a -> f b
<*> :: Id (a -> b) -> Id a -> Id b

pure :: a -> f a
pure :: a -> Id a

xs = [1, 2, 3]
xs' = [9, 9, 9]

-- Prelude> let xs = [1, 2, 3]
-- Prelude> let xs' = [9, 9, 9]
-- Prelude> const <$> xs <*> xs'
-- [1,1,1,2,2,2,3,3,3]
-- Prelude> let mkId = Identity
-- Prelude> const <$> mkId xs <*> mkId xs'
-- Identity [1,2,3]

