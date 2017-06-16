module Math.MultiplySpec (main, spec) where

import Test.Hspec
import Test.QuickCheck

import Math.Multiply

-- `main` is here so that this module can be run from GHCi on its own.  It is
-- not needed for automatic spec discovery.
main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "multiply" $ do
    it "multiplies two numbers" $ do
      multiply 2 10 `shouldBe` 20
    -- it "is commutative" $ property $
    --   \x y -> multiply (x:: Int) (y :: Int)  === multiply y x
