module Exercises where

import Data.Monoid  
import Control.Monad  
import Control.Applicative
import Test.QuickCheck
import Test.QuickCheck.Checkers
import Test.QuickCheck.Classes

-- 1. Identity
newtype Identity a = Identity a deriving (Eq, Ord, Show)

instance Functor Identity where
    fmap f (Identity a) = Identity (f a)

instance Applicative Identity where
    pure = Identity
    Identity f <*> Identity a = Identity (f a)

instance Foldable Identity where
    foldMap f (Identity a) = f a
    foldr f z (Identity a) = f a z


instance Traversable Identity where
    traverse f (Identity a) = Identity <$> f a


-- 2. Constant

newtype Constant a b = Constant { getConstant :: a } deriving (Eq, Ord, Show)

instance Functor (Constant a) where
    fmap _ Constant { getConstant = x} = Constant {getConstant = x}

-- instance Monoid a => Applicative (Constant a) where
--     pure  x =  Constant {getConstant = mempty}
--     Constant { getConstant = f } <*> Constant {getConstant = x} = Constant {getConstant = x}
    

instance Foldable (Constant a) where
    foldMap _ _  = mempty

instance Traversable (Constant a) where
    traverse _ Constant {getConstant = x} =  Constant <$> pure x

-- 3. Maybe
data Optional a = Nada | Yep a deriving (Eq, Ord, Show)

instance Functor Optional where
    fmap _ Nada = Nada
    fmap f (Yep a) = Yep (f a)
    
instance Foldable Optional where
    foldMap _ Nada = mempty
    foldMap f (Yep a) = f a


instance Traversable Optional where
    traverse f (Yep a) = Yep <$> f a
    traverse _ Nada =  pure Nada

-- 4. List

data List a =
    Nil
    | Cons a (List a) deriving (Eq, Ord, Show)

instance Functor List where
    fmap _ Nil = Nil
    fmap f (Cons a t) = Cons (f a) (fmap f t)

instance Foldable List where
    foldMap _ Nil  = mempty
    foldMap f (Cons a t) = f a <> foldMap f t

instance Traversable List where
    traverse _ Nil =  pure Nil
    traverse f (Cons a t) = Cons <$> f a <*> traverse f t
    

-- 5. Three
data Three a b c = Three a b c deriving (Eq, Ord, Show)

instance Functor (Three a b) where
    fmap f (Three a b c) = Three a b (f c)

instance Foldable (Three a b) where
    foldMap f (Three a b c) = f c

instance Traversable (Three a b ) where
    -- traverse f (Three a b c) = Three <$> pure a <*> pure b <*> f c
    traverse f (Three a b c) = liftA3 Three (pure a) (pure b) (f c)
    

-- QuickCheck

instance Arbitrary a => Arbitrary (Identity a) where
    arbitrary = Identity <$> arbitrary
      
instance Arbitrary a => Arbitrary (Constant a b) where
    arbitrary = Constant <$> arbitrary

instance Arbitrary a => Arbitrary (Optional a) where
    arbitrary = frequency [(1, return Nada), (3, Yep <$> arbitrary)]
 
instance Arbitrary a => Arbitrary (List a) where
    arbitrary = oneof [return Nil, Cons <$> arbitrary <*> arbitrary]

instance (Arbitrary a, Arbitrary b, Arbitrary c) => Arbitrary (Three a b c ) where
    arbitrary = liftA3 Three arbitrary arbitrary arbitrary

instance Eq a => EqProp (Identity a) where
    (=-=) = eq
      
instance Eq a => EqProp (Constant a b) where
    (=-=) = eq

instance Eq a => EqProp (Optional a) where
    (=-=) = eq

instance Eq a => EqProp (List a) where
    (=-=) = eq

instance (Eq a, Eq b, Eq c) => EqProp (Three a b c) where
    (=-=) = eq

identityTrigger = undefined :: Identity (Int, Int, [Int])
constantTrigger = undefined :: Constant (Int, Int, [Int]) (Int, Int, [Int])
optionalTrigger = undefined :: Optional (Int, Int, [Int])
listTrigger     = undefined :: List (Int, Int, [Int])
threeTrigger    = undefined :: Three (Int, Int, [Int]) (Int, Int, [Int]) (Int, Int, [Int])

main :: IO ()
main = do
  quickBatch (traversable identityTrigger)
  quickBatch (traversable constantTrigger)
  quickBatch (traversable optionalTrigger)
  quickBatch (traversable listTrigger)
  quickBatch (traversable threeTrigger)
