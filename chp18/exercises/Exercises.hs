module Exercises where

import Data.Monoid  
import Control.Monad  
import Data.Maybe
import Test.QuickCheck
import Test.QuickCheck.Checkers
import Test.QuickCheck.Classes

-- 1. 
data Nope a =
  NopeDotJpg
  deriving (Eq, Show)

instance Functor Nope where
  fmap _ NopeDotJpg = NopeDotJpg

instance Applicative Nope where
  pure _ = NopeDotJpg
  _ <*> _ = NopeDotJpg

instance Monad Nope where
  return = pure
  _ >>= _ = NopeDotJpg

instance Arbitrary (Nope a) where
  arbitrary = return NopeDotJpg

instance EqProp (Nope a) where
  (=-=) = eq

nopeTrigger = undefined :: Nope (Int, Int, Int)

--2
data PhhhbbtttEither b a
  = LeftP a
  | RightP b
  deriving (Eq, Show)

instance Functor (PhhhbbtttEither b) where
  fmap _ (RightP a) = RightP a
  fmap f (LeftP b) = LeftP (f b)

instance Applicative (PhhhbbtttEither b) where
  pure = LeftP
  LeftP f <*> LeftP b = LeftP (f b)
  RightP a <*> _ = RightP a
  _ <*> RightP a = RightP a

instance Monad (PhhhbbtttEither b) where
  return = pure
  RightP a >>= _ = RightP a
  LeftP b >>= f = f b

--
instance (Arbitrary a, Arbitrary b) => Arbitrary (PhhhbbtttEither a b) where
  arbitrary = oneof [LeftP <$> arbitrary, RightP <$> arbitrary]

instance (Eq a, Eq b) => EqProp (PhhhbbtttEither b a) where
  (=-=) = eq

phhhbbtttEitherTrigger =
  undefined :: PhhhbbtttEither (Int, Int, Int) (Int, Int, Int)

-- 3
newtype Identity a =
  Identity a
  deriving (Eq, Ord, Show)

instance Functor Identity where
  fmap f (Identity a) = Identity (f a)

instance Applicative Identity where
  pure = Identity
  Identity f <*> Identity a = Identity (f a)

instance Monad Identity where
  return = pure
  Identity a >>= f = f a

--
instance (Arbitrary a) => Arbitrary (Identity a) where
  arbitrary = Identity <$> arbitrary

instance (Eq a) => EqProp (Identity a) where
  (=-=) = eq

identityTrigger = undefined :: Identity (Int, Int, Int)

-- 4
data List a
  = Nil
  | Cons a
         (List a)
  deriving (Eq, Ord, Show)

instance Functor List where
  fmap _ Nil = Nil
  fmap f (Cons a t) = Cons (f a) (fmap f t)

append :: List a -> List a -> List a
append Nil ys = ys
append ys Nil = ys
append (Cons x xs) ys = Cons x $ xs `append` ys

instance Monoid (List a) where
  mempty  = Nil
  mappend = append

instance Applicative List where
  pure x = Cons x Nil
  Nil <*> _   = Nil
  _   <*> Nil = Nil
  Cons f ft <*> l = (f <$> l) <> (ft <*> l)

instance Monad List where
  return = pure
  Nil >>= _ = Nil
  Cons x xs >>= f = f x <> (xs >>= f) 
  
--
instance Eq a => EqProp (List a) where
  (=-=) = eq

instance Arbitrary a => Arbitrary (List a) where
    arbitrary = oneof [return Nil, Cons <$> arbitrary <*> arbitrary]

triggerList = undefined :: List (Int, Int, Int)

main :: IO ()
main = do
  quickBatch (applicative nopeTrigger)
  quickBatch (monad nopeTrigger)
  quickBatch (applicative phhhbbtttEitherTrigger)
  quickBatch (applicative phhhbbtttEitherTrigger)
  quickBatch (monad identityTrigger)
  quickBatch (applicative identityTrigger)
  quickBatch (applicative triggerList)
  quickBatch (monad triggerList)


-- 1
j :: Monad m => m (m a) -> m a
j  = join

j' :: Monad m => m (m a) -> m a
j'  = (=<<) id
-- `(=<<) id :: Monad m => m (m b) -> m b` where `(=<<) :: Monad m => (a -> m b) -> m a -> m b`, `id :: a -> a`
-- signature  `Monad m => (a -> m b)` if we paste here `id` this must be  `Monad m => (m b -> m b)`
-- If we replace `a = m b` in `m a` becomes `m (m b)`


-- 2
l1 :: Monad m => (a -> b) -> m a -> m b
l1 = fmap

-- 3
l2 :: Monad m => (a -> b -> c) -> m a -> m b -> m c
l2 = liftM2

-- 4
a :: Monad m => m a -> m (a -> b) -> m b
a = flip (<*>)

-- 5
meh :: Monad m => [a] -> (a -> m b) -> m [b]
meh xs f = foldr f' ( return [] ) xs 
            where f' x  = liftM2 (:) (f x)

-- usage:  meh [1..5] Just
-- result: Just [1,2,3,4,5]
  
-- 6
flipType :: (Monad m) => [m a] -> m [a]
flipType   = flip meh id      