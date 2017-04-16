module Natural where

import Data.Maybe (isNothing)

-- As natural as any competitive bodybuilder
data Nat =
    Zero
    | Succ Nat
    deriving (Eq, Show)

-- >>> natToInteger Zero
-- 0
-- >>> natToInteger (Succ Zero)
-- 1
-- >>> natToInteger (Succ (Succ Zero))
-- 2
natToInteger :: Nat -> Integer
natToInteger Zero = 0
natToInteger (Succ nat) = 1 + natToInteger nat



testNatToInteger:: IO ()
testNatToInteger = 
    if natToInteger (Succ (Succ Zero)) == 2
    then putStrLn "natToInteger fine"
    else putStrLn "natToInteer failed!"


-- >>> integerToNat 0
-- Just Zero
-- >>> integerToNat 1
-- Just (Succ Zero)
-- >>> integerToNat 2
-- Just (Succ (Succ Zero))
-- >>> integerToNat (-1)
-- Nothing
integerToNat :: Integer -> Maybe Nat
integerToNat i = 
    if i >= 0 
        then Just (integerToNat' i ) 
        else Nothing

integerToNat' :: Integer -> Nat
integerToNat' 0 = Zero
integerToNat' i = Succ $ integerToNat' (i - 1)

testIntegerToNat:: IO ()
testIntegerToNat = 
    if integerToNat 2 == Just (Succ (Succ Zero)) && isNothing (integerToNat (-1))
    then putStrLn "integerToNat fine"
    else putStrLn "integerToNat Failes"
    