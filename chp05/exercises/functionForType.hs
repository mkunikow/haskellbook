module FunctionForType where

i :: a -> a
i a = a

c :: a -> b -> a
c a b = a

c'' :: b -> a -> b
c'' b a = b

r :: [a] -> [a]
r a = a

co :: (b -> c) -> (a -> b) -> (a -> c)
co f g = f . g

a :: (a -> c) -> a -> a -- (a -> c) -> (a -> a)
a f c = c

a' :: (a -> b) -> a -> b
a' f = f