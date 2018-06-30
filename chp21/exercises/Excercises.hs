
module Exercises where

import           Control.Applicative
import           Data.Monoid
import           Test.QuickCheck
import           Test.QuickCheck.Checkers
import           Test.QuickCheck.Classes

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

instance Traversable (Three a b) where
    -- traverse f (Three a b c) = Three <$> pure a <*> pure b <*> f c
    traverse f (Three a b c) = liftA3 Three (pure a) (pure b) (f c)

-- Big
data Big a b = Big a b b deriving (Eq, Ord, Show)

instance Functor (Big a) where
    fmap f (Big a b1 b2) = Big a (f b1) (f b2)

instance Foldable (Big a) where
    foldMap f (Big a b1 b2) = f b1 <> f b2

instance Traversable (Big a) where
    traverse f (Big a b1 b2) = liftA3 Big (pure a) (f b1) (f b2)


--  Bigger

data Bigger a b = Bigger a b b b deriving (Eq, Ord, Show)

instance Functor (Bigger a) where
    fmap f (Bigger a b1 b2 b3) = Bigger a (f b1) (f b2) (f b3)

instance Foldable (Bigger a) where
    foldMap f (Bigger a b1 b2 b3) = f b1 <> f b2 <> f b3

instance Traversable (Bigger a) where
    traverse f (Bigger a b1 b2 b3) =  Bigger <$> pure a <*> f b1 <*> f b2 <*> f b3
    

-- S
data S n a = S (n a) a deriving (Eq, Show)

instance Functor n  => Functor (S n) where
    fmap = undefined

instance Foldable n => Foldable (S n) where
    foldMap = undefined
    
instance Traversable n => Traversable (S n) where
    traverse = undefined


    

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

instance (Arbitrary a, Arbitrary b) => Arbitrary (Big a b) where
    arbitrary = liftA3 Big arbitrary arbitrary arbitrary

instance (Arbitrary a, Arbitrary b) => Arbitrary (Bigger a b) where
    arbitrary = Bigger <$> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary


instance (Arbitrary (n a), Arbitrary a) => Arbitrary (S n a) where
    arbitrary = liftA2 S arbitrary arbitrary

    
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

instance (Eq a, Eq b) => EqProp (Big a b) where
    (=-=) = eq

instance (Eq a, Eq b) => EqProp (Bigger a b) where
    (=-=) = eq

instance (Eq a, Eq (n a)) => EqProp (S n a) where 
    (=-=) = eq
    

identityTrigger = undefined :: Identity (Int, Int, [Int])
constantTrigger = undefined :: Constant (Int, Int, [Int]) (Int, Int, [Int])
optionalTrigger = undefined :: Optional (Int, Int, [Int])
listTrigger     = undefined :: List (Int, Int, [Int])
threeTrigger    = undefined :: Three (Int, Int, [Int]) (Int, Int, [Int]) (Int, Int, [Int])
bigTrigger      = undefined :: Big (Int, Int, [Int]) (Int, Int, [Int]) 
biggerTrigger   = undefined :: Bigger (Int, Int, [Int]) (Int, Int, [Int])
triggerS        = undefined :: S [] (Int, Int, [Int])

main :: IO ()
main = do
  quickBatch (traversable identityTrigger)
  quickBatch (traversable constantTrigger)
  quickBatch (traversable optionalTrigger)
  quickBatch (traversable listTrigger)
  quickBatch (traversable threeTrigger)
  quickBatch (traversable bigTrigger)
  quickBatch (traversable biggerTrigger)
