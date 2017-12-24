module FixerUpper where

-- 1. 
epx1 =  const <$> Just "Hello" <*> pure "World"

-- 2.
exp2 = (,,,) <$> Just 90 <*> Just 10 <*> Just "Tierness" <*> pure [1, 2, 3]

