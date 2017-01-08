module FoldBool where

foldBool :: a -> a -> Bool -> a
foldBool = error "Error: Need to implement foldBool!"

-- Case expression
foldBool1 :: a -> a -> Bool -> a
foldBool1 x y z =
    case z of
        True -> x
        False -> y
         

-- Gaurds
foldBool2 :: a -> a -> Bool -> a
foldBool2 x y z
    | z         = x
    | otherwise = y

-- Pattern matching
foldBool3 :: a -> a -> Bool -> a
foldBool3 x y True = x
foldBool3 x y False = y



