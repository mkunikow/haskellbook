module F where

f :: (a, b) -> (c, d) -> ((b, d), (a, c))
f t1 t2 = ((snd t1 , snd t2) , (fst t1 , fst t2))
