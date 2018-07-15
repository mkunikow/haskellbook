module BoopDoop where

import Control.Applicative

boop = (*2)
doop = (+10)

-- Functor fmap

bip :: Integer -> Integer
bip = boop . doop

bloop :: Integer -> Integer
bloop = fmap boop doop

-- Applicative

bbop :: Integer -> Integer
bbop = (+) <$> boop <*> doop

duwop :: Integer -> Integer
duwop = liftA2 (+) boop doop


-- First the fmap
-- (*2) :: Num a => a -> a
-- (+) :: Num a => a -> a -> a
-- (+) <$> (*2) :: Num a => a -> a -> a

-- (+) . (*2) :: Num a => a -> a -> a
-- Prelude> ((+) . (*2)) 5 3
--13

-- f . g = \ x -> f (g x)
-- ((+) . (*2)) == \ x -> (+) (2 * x)

-- ((+) . (*2)) 5 3
-- (\ x -> (+) (2 * x)) 5 3
-- (\ 5 -> (+) (2 * 5)) 3
-- ((+) 10) 3

-- Then it adds 10 and 3
-- 13

-- ((+) <$> (*2) <*> (+10)) 3

-- Wait, what? What happened to the
-- first argument?
-- ((+) <$> (*2) <*> (+10)) :: Num b => b -> b


-- Prelude> :t (<*>)
-- (<*>) :: Applicative f => f (a -> b) -> f a -> f b

-- in this case, we know f is ((->) a)
-- so we concretize it thusly

-- Prelude> :t (<*>) :: (a -> a -> b) -> (a -> a) -> (a -> b)
-- (<*>) :: (a -> a -> b) -> (a -> a) -> (a -> b)


-- ((+) <$> (*2) <*> (+10)) 3
-- (3*2) + (3+10)
-- 6 + 13
-- 19



-- Second Example

(<||>) :: (a -> Bool)
    -> (a -> Bool)
    -> a
    -> Bool
(<||>) = liftA2 (||)

-- Example Monad

boopDoop :: Integer -> Integer
boopDoop = do
    a <- boop
    b <- doop
    return (a + b)
















