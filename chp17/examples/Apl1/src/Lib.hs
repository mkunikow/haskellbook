module Lib  where

import Control.Applicative
import Data.Monoid
import Test.QuickCheck
import Test.QuickCheck.Checkers
import Test.QuickCheck.Classes


-- arbitrary :: Arbitrary a => Gen a

newtype Mono a = Mono a

instance Arbitrary a => Arbitrary (Mono a) where
    arbitrary = Mono <$> arbitrary :: Arbitrary a => Gen (Mono a)

-- Mono <$> arbitrary :: Arbitrary a => Gen (Mono a)

data List a =
    Nil
    | Cons a (List a)
    deriving (Eq, Show)


instance Functor List where
    fmap _ Nil = Nil
    fmap f (Cons a t) = Cons (f a) (fmap f t)

-- t2 = Cons <$> arbitrary
-- Cons <$> arbitrary :: Arbitrary a => Gen (List a -> List a)

instance Eq a => EqProp (ZipList a) where
    (=-=) = eq
    
    
    



someFunc :: IO ()
someFunc = putStrLn "someFunc"
