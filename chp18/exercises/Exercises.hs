module Exercises where

import Data.Monoid  
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
