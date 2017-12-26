{-# LANGUAGE DeriveAnyClass #-}

import Lib

import  Control.Applicative
import  Data.Monoid
import  Test.QuickCheck
import  Test.QuickCheck.Checkers
import  Test.QuickCheck.Classes

instance Arbitrary a => Arbitrary (Pair a) where
  arbitrary = Pair <$> arbitrary <*> arbitrary
  -- arbitrary = liftA2 Pair arbitrary arbitrary

instance Eq a => EqProp (Pair a) where 
  (=-=) = eq

pairTrigger = undefined :: Pair (String, String, String)


instance (Arbitrary a, Arbitrary b) => Arbitrary (Two a b) where
  arbitrary = liftA2 Two arbitrary arbitrary

instance (Eq a, Eq b) => EqProp (Two a b) where 
  (=-=) = eq

twoTrigger = undefined :: Two (String, String, String) (String, String, String)

instance (Arbitrary a, Arbitrary b, Arbitrary c) => Arbitrary (Three a b c) where
  arbitrary = liftA3 Three arbitrary arbitrary arbitrary

instance (Eq a, Eq b, Eq c) => EqProp (Three a b c) where 
  (=-=) = eq

threeTrigger = undefined :: Three (String, String, String) (String, String, String)(String, String, String)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Three' a b) where
  arbitrary = liftA3 Three' arbitrary arbitrary arbitrary

instance (Eq a, Eq b) => EqProp (Three' a b) where 
  (=-=) = eq

three'Trigger = undefined :: Three' (String, String, String) (String, String, String)


instance (Arbitrary a, Arbitrary b, Arbitrary c, Arbitrary d) => Arbitrary (Four a b c d) where
  arbitrary = Four <$> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary

instance (Eq a, Eq b, Eq c, Eq d) => EqProp (Four a b c d)  where 
  (=-=) = eq

fourTrigger = undefined :: Four (String, String, String) (String, String, String) 
                                  (String, String, String) (String, String , String)


instance (Arbitrary a, Arbitrary b) => Arbitrary (Four' a b) where
  arbitrary = Four' <$> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary

instance (Eq a, Eq b) => EqProp (Four' a b) where 
  (=-=) = eq

four'Trigger = undefined :: Four' (String, String, String) (String, String, String)

main :: IO ()
main = do
  quickBatch (applicative pairTrigger)
  quickBatch (applicative twoTrigger)
  quickBatch (applicative threeTrigger)
  quickBatch (applicative three'Trigger)
  quickBatch (applicative fourTrigger)
  quickBatch (applicative four'Trigger)