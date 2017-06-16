module Math.Multiply (multiply) where

multiply :: (Eq a, Num a) => a -> a -> a
multiply a b = go a b 0
    where go x y acc
            | y == 0 = acc
            | otherwise = go x (y - 1) (acc + x)