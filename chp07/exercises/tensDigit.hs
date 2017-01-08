module TenDigit where


--  (x `div` 10) `mod` 10
tensDigit :: Integral a => a -> a
tensDigit x = d
    where xLast = x `div` 10
          d = xLast `mod` 10
          

tensDigitDivMod :: Integral a => a -> a
tensDigitDivMod x = d
    where xLast = fst $ x `divMod` 10
          d = snd $ xLast `divMod` 10

hunsD :: Integral a => a -> a
hunsD x = d
    where xLast = fst $ x `divMod` 100
          d = snd $ xLast `divMod` 10
