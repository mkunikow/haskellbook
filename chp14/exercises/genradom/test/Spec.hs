module Main where

import Test.QuickCheck

data Fool =
    Fulse
    | Frue
    deriving (Eq, Show)

genFool :: Gen Fool
genFool = oneof [return Fulse, return Frue]


genFool2 :: Gen Fool
genFool2 = frequency [(2, return Fulse), (1, return Frue)]

instance Arbitrary Fool where
    arbitrary = genFool

main :: IO ()
main = do
    putStrLn ""
    putStrLn "---------"
    putStrLn "genFool:"
    putStrLn "---------"
    sample genFool
    putStrLn "---------"
    putStrLn "genFool2:"
    putStrLn "---------"
    sample genFool2


