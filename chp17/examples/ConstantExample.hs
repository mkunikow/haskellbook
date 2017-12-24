module ConstantExample where

-- f ~ Constant e
type C = Constant

<*> :: f (a -> b) -> f a -> f b
<*> :: C e (a -> b) -> C e a -> C e b

pure :: a -> f a
pure :: a -> C e a

-- Prelude> let f = Constant (Sum 1)
-- Prelude> let g = Constant (Sum 2)
-- Prelude> f <*> g
-- Constant {getConstant = Sum {getSum = 3}
-- Prelude> Constant undefined <*> g
-- Constant (Sum {getSum =
-- *** Exception: Prelude.undefined
-- Prelude> pure 1
-- 1
-- Prelude> pure 1 :: Constant String Int
-- Constant {getConstant = ""}

   

