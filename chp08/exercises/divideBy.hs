module DivideBy where

dividedBy :: Integral a => a -> a -> (a, a)
dividedBy num denom = go numAbs denomAbs 0
    where
        sig = signum (num * denom)
        sigNum = signum num
        numAbs = abs num
        denomAbs = abs denom 
        go n d count
            | n < d = (sig * count, sigNum * n)
            | otherwise = go (n - d) d (count + 1)




dividedByWithZero :: Integral a => a -> a -> Maybe (a, a)
dividedByWithZero num 0 = Nothing
dividedByWithZero num denom = Just $ dividedBy num denom


