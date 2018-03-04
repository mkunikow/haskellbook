module BadMonad where

import Test.QuickCheck
import Test.QuickCheck.Checkers
import Test.QuickCheck.Classes

data CountMe a =
  CountMe Integer
          a
  deriving (Eq, Show)

instance Functor CountMe where
  fmap f (CountMe i a) = CountMe (i + 1) (f a)

instance Applicative CountMe where
  pure = CountMe 10
  CountMe n f <*> CountMe n' a = CountMe (n + n') (f a)

instance Monad CountMe where
  return = pure
  CountMe n a >>= f =
    let CountMe _ b = f a
    in CountMe (n + 1) b

-- instance Monad CountMe where
--   return = pure
--   CountMe n a >>= f = CountMe (n + 1) a

instance Arbitrary a => Arbitrary (CountMe a) where
  arbitrary = CountMe <$> arbitrary <*> arbitrary -- CountMe <$> Gen(Integer) <*> Gen(a) -> Gen(CountMe a)

instance Eq a => EqProp (CountMe a) where
  (=-=) = eq

main = do
  let trigger :: CountMe (Int, String, Int)
      trigger = undefined
  quickBatch $ functor trigger
  quickBatch $ applicative trigger
  quickBatch $ monad trigger
