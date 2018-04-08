module Exercises where

import Data.Foldable
import Data.Monoid

-- import Data.Semigroup
-- 1. 
data Constant' a b =
  Constant' b
  deriving (Eq, Show)

instance Foldable (Constant' a) where
  foldMap f (Constant' b) = f b

-- 2.
data Two a b =
  Two a
      b
  deriving (Eq, Show)

instance Foldable (Two a) where
  foldMap f (Two _ b) = f b

-- 3    
data Three' a b =
  Three' a
         b
         b
  deriving (Eq, Show)

instance Foldable (Three' a) where
  foldMap f (Three' _ b c) = f b <> f c

-- 4
data Four' a b =
  Four' a
        b
        b
        b
  deriving (Eq, Show)

instance Foldable (Four' a) where
  foldMap f (Four' _ b c d) = f b <> f c <> f d

-- Thinking cap time. Write a filter function for Foldable types using foldMap.
filterF ::
     (Applicative f, Foldable t, Monoid (f a)) => (a -> Bool) -> t a -> f a
filterF = undefined
