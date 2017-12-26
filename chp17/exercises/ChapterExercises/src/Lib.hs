module Lib  where

import  Control.Applicative
import  Data.Monoid

--1.
data Pair a = Pair a a deriving (Show, Eq)

instance Functor Pair where
    fmap  f (Pair x y) = Pair (f x) (f y)

instance Applicative Pair where
    pure x = Pair x x
    Pair f f' <*> Pair x y = Pair (f x) (f' y)

--2.
data Two a b = Two a b deriving (Eq, Show)

instance Functor (Two a) where
    fmap f (Two a b) = Two a (f b)

instance Monoid a => Applicative (Two a) where
    pure   = Two mempty
    Two x f <*> Two y z = Two (x <> y) (f z)

--3.
data Three a b c = Three a b c deriving (Eq, Show)

instance Functor (Three a b) where
    fmap f (Three a b c) = Three a b (f c)

instance ( Monoid a, Monoid b) => Applicative (Three a b) where
    pure = Three mempty mempty
    Three a b f <*> Three a' b' c = Three (a <> a') (b <> b') (f c)

--4.
data Three' a b = Three' a b b deriving (Eq, Show)

instance Functor (Three' a) where
    fmap f (Three' a b b') = Three' a (f b) (f b')

instance ( Monoid a) => Applicative (Three' a ) where
    pure x = Three' mempty x x
    Three' a f f' <*> Three' a' b c = Three' (a <> a') (f b) (f' c)

--5.
data Four a b c d = Four a b c d deriving (Eq, Show)

instance Functor (Four a b c) where
    fmap f (Four a b c d) = Four a b c (f d)

instance (Monoid a, Monoid b, Monoid c) => Applicative (Four a b c) where
    pure = Four mempty mempty mempty
    Four a b c f <*> Four a' b' c' x = Four (a <> a') (b <> b') (c <> c') (f x)

--6.
data Four' a b = Four' a a a b deriving (Eq, Show)

instance Functor (Four' a) where
    fmap f (Four' a b c d) = Four' a b c (f d)

instance ( Monoid a) => Applicative (Four' a ) where
    pure  = Four' mempty mempty mempty 
    Four' a b c f <*> Four' a' b' c' x = Four' (a <> a') (b <> b') (c <> c') (f x)

--Combinations

stops :: String
stops = "pbtdkg"

vowels :: String
vowels = "aeiou"

combos :: [a] -> [b] -> [c] -> [(a, b, c)]
combos = liftA3 (,,)









        
someFunc :: IO ()
someFunc = putStrLn "someFunc"
