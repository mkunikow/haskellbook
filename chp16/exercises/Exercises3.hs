{-# LANGUAGE FlexibleInstances #-}

module Exercises3 where

---------------------------------------------------------
-- Write Functor instances for the following datatypes.
----------------------------------------------------------

-- 1. 

data Quant a b =
    Finance
    | Desk a
    | Bloor b

instance Functor (Quant e) where
    fmap f (Bloor b) = Bloor (f b)
    fmap _ (Desk a)  = Desk a
    fmap _ Finance   = Finance

-- 2.

data K a b =
    K a

instance Functor (K e) where
    fmap _ (K a) = K a

-- 3.

newtype Flip f a b =
    Flip (f b a)
    deriving (Eq, Show)

-- should remind you of an
-- instance you've written before
instance Functor (Flip K a) where
    fmap f (Flip (K a)) = Flip $ K (f a)

-- 4.

data EvilGoateeConst a b =
    GoatyConst b

instance Functor (EvilGoateeConst e) where
    fmap f (GoatyConst b) = GoatyConst (f b)

-- 5.
data LiftItOut f a =
    LiftItOut (f a) deriving (Eq, Show)
-- LiftItOut [1]

instance Functor f => Functor (LiftItOut f) where
    fmap g (LiftItOut x)  = LiftItOut (fmap g x)

-- 6.

data Parappa f g a =
    DaWrappa (f a) (g a)


instance (Functor f, Functor g) => Functor (Parappa f g ) where
    fmap e (DaWrappa x y) = DaWrappa (fmap e x) (fmap e y)

-- 7.

data IgnoreOne f g a b =
    IgnoringSomething (f a) (g b)

instance (Functor f, Functor g) => Functor (IgnoreOne f g a) where
    fmap h (IgnoringSomething  x y) = IgnoringSomething x (fmap h y)

-- 8.
data Notorious g o a t =
    Notorious (g o) (g a) (g t)
    
instance Functor g => Functor (Notorious g o a) where
    fmap h (Notorious x y z) = Notorious x y (fmap h z)


-- 9.
data List a =
    Nil
    | Cons a (List a)

instance Functor List where
    fmap _ Nil = Nil
    fmap f (Cons a t) = Cons (f a) (fmap f t)

-- 10.

data GoatLord a =
    NoGoat
    | OneGoat a
    | MoreGoats (GoatLord a) (GoatLord a) (GoatLord a)
    -- A VERITABLE HYDRA OF GOATS

instance Functor GoatLord where
    fmap _ NoGoat = NoGoat
    fmap f (OneGoat x) = OneGoat (f x)
    fmap f (MoreGoats x y z) 
        = MoreGoats (fmap f x) (fmap f y) (fmap f z)

-- 11.

data TalkToMe a =
    Halt
    | Print String a
    | Read (String -> a)

instance Functor TalkToMe where
    fmap _ Halt = Halt
    fmap f (Print x y) = Print x (f y) 
    fmap f (Read g) = Read (f.g)
