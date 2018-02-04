module EitherMonad where

import           Test.QuickCheck
import           Test.QuickCheck.Checkers
import           Test.QuickCheck.Classes
        
data Sum a b
  = First a
  | Second b
  deriving (Eq, Show)

instance Functor (Sum a) where
  fmap f (Second b) = Second $ f b
  fmap _ (First a) = First a

instance Applicative (Sum a) where
  pure = Second
  Second f <*> Second b = Second (f b)
  First a <*> _ = First a
  _ <*> First a = First a

instance Monad (Sum a) where
  return = pure
  First a >>= _ = First a
  Second b >>= f = f b


instance (Eq a, Eq b) => EqProp (Sum a b) where (=-=) = eq

instance (Arbitrary a, Arbitrary b) => Arbitrary (Sum a b) where
    arbitrary = oneof [First <$> arbitrary, Second <$> arbitrary]
  
trigger = undefined :: Sum (Int, Int, Int) (Int, Int, Int)
  
main :: IO ()
main = do
  quickBatch (applicative trigger)
  quickBatch (monad trigger)