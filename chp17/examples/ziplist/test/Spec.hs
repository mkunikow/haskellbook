module Main where

import Control.Applicative
import Data.Monoid
import Test.QuickCheck
import Test.QuickCheck.Checkers
import Test.QuickCheck.Classes

instance Monoid a => Monoid (ZipList a) where
  mempty = ZipList []
  mappend = liftA2 mappend

-- instance Arbitrary a => Arbitrary (ZipList a) where
--   arbitrary = ZipList <$> arbitrary

instance Eq a => EqProp (ZipList a) where
  (=-=) = eq

zl = ZipList [1 :: Sum Int]

main :: IO ()
main = quickBatch (monoid zl)


  

  