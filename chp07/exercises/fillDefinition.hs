module FillDefinition where

g :: (a -> b) -> (a, c) -> (b, c)
g f1 (x, y) = (f1 x , y)

-- > g show (1 , "2")
-- ("1","2")
