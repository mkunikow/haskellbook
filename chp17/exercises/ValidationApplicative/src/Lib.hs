module Lib where

import Data.Monoid

data Validation e a =
        Failure e
    | Success a
    deriving (Eq, Show)

data Errors =
        DividedByZero
    | StackOverflow
    | MooglesChewedWires
    deriving (Eq, Show)
        

-- same as Either
instance Functor (Validation e) where
    fmap _ (Failure a) = Failure a
    fmap f (Success a) = Success (f a)

-- This is different
instance Monoid e => Applicative (Validation e) where
    pure = Success
    Success f  <*> Success x  = Success (f x)
    Success _  <*> Failure e  = Failure e
    Failure e  <*> Success _  = Failure e
    Failure e1 <*> Failure e2 = Failure (e1 <> e2)

-- TODO check why this is an error
--success = Success (+1) <*> Success 1 :: (Num b, Monoid e) => Validation e b

failure = Success (+1) <*> Failure [StackOverflow]
failure' = Failure [StackOverflow] <*> Success (+1)
failures = Failure [MooglesChewedWires] <*> Failure [StackOverflow]
    

someFunc :: IO ()
someFunc = putStrLn "someFunc"
