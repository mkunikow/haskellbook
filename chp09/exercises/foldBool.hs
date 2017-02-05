module FoldBool where

import Data.Bool (bool)

b =  map (\x -> if x == 3 then (-x) else x) [1..10]
b2 = map (\x -> bool x (-x) (x == 3)) [1..10]


