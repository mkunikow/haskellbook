{-# LANGUAGE DeriveAnyClass #-}

import Data.Semigroup
import Test.QuickCheck
import Test.QuickCheck.Checkers
import Test.QuickCheck.Classes

data MyValidation e a =
    MyFailure e
  | MySuccess a
  deriving (Eq, Show)

data Errors =
    DividedByZero
  | StackOverflow
  | MooglesChewedWires
  deriving (Eq, Show)
  

-- same as Either
instance Functor (MyValidation e) where
  fmap _ (MyFailure a) = MyFailure a
  fmap f (MySuccess a) = MySuccess (f a)

-- This is different
instance Semigroup e => Applicative (MyValidation e) where
  pure = MySuccess

  MySuccess f  <*> MySuccess x  = MySuccess (f x)
  MySuccess _  <*> MyFailure e  = MyFailure e
  MyFailure e  <*> MySuccess _  = MyFailure e
  MyFailure e1 <*> MyFailure e2 = MyFailure (e1 <> e2)

instance (Eq a, Eq b) => EqProp (MyValidation a b) where (=-=) = eq

instance (Arbitrary e, Arbitrary a) => Arbitrary (MyValidation e a) where
  arbitrary = oneof [MyFailure <$> arbitrary, MySuccess <$> arbitrary]

trigger = undefined :: MyValidation (String, String, String) (String, String, String)

  
main :: IO ()
-- main = print "Test"
main = quickBatch $ applicative trigger
