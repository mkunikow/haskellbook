module Main where

import Control.Monad
import Test.QuickCheck (Arbitrary, arbitrary, quickCheck, elements, frequency)
import Data.Semigroup


semigroupAssoc :: (Eq m, Semigroup m) => m -> m -> m -> Bool
semigroupAssoc a b c = (a <> (b <> c)) == ((a <> b) <> c)

-- 1

data Trivial = Trivial deriving (Eq, Show)

instance Semigroup Trivial where
    Trivial <> Trivial = Trivial

instance Arbitrary Trivial where
    arbitrary = return Trivial


type TrivialAssoc = Trivial -> Trivial -> Trivial -> Bool


-- 2
newtype Identity a = Identity a deriving (Eq, Show)

instance Semigroup a => Semigroup (Identity a) where
    (Identity a) <> (Identity b) = Identity (a <> b)


instance (Arbitrary a) => Arbitrary (Identity a) where
    arbitrary = do
        a <- arbitrary
        return (Identity a)

type IdentityAssoc = Identity String -> Identity String -> Identity String -> Bool

-- 3
data Two a b = Two a b deriving (Eq, Show)

instance (Semigroup a, Semigroup b) => Semigroup (Two a b) where
    (Two a b) <> (Two c d) = Two (a <> c) ( b <> d)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Two a b) where
    arbitrary = do
        a <- arbitrary
        b <- arbitrary
        return (Two a b)

type TwoAssoc = Two String String -> Two String String -> Two String String -> Bool

-- 4
data Three a b c = Three a b c deriving (Eq, Show)

instance (Semigroup a, Semigroup b, Semigroup c) => Semigroup (Three a b c) where
    (Three a b c) <> (Three d e f) = Three (a <> d) ( b <> e) ( c <> f)

instance (Arbitrary a, Arbitrary b, Arbitrary c) => Arbitrary (Three a b c) where
    arbitrary = do
        a <- arbitrary
        b <- arbitrary
        d <- arbitrary
        return (Three a b d)

type ThreeAssoc = Three String String String -> Three String String String -> Three String String String -> Bool

-- 5
data Four a b c d  = Four a b c d deriving (Eq, Show)

instance (Semigroup a, Semigroup b, Semigroup c, Semigroup d) => Semigroup (Four a b c d) where
    (Four a b c d) <> (Four e f g h) = Four (a <> e) ( b <> f) ( c <> g) ( d <> h)

instance (Arbitrary a, Arbitrary b, Arbitrary c, Arbitrary d) => Arbitrary (Four a b c d) where
    arbitrary = do
        a <- arbitrary
        b <- arbitrary
        d <- arbitrary
        e <- arbitrary
        return (Four a b d e)

type FourAssoc = 
    Four String String String String 
    -> Four String String String String 
    -> Four String String String String
    -> Bool

-- 6
newtype BoolConj = BoolConj Bool deriving (Eq, Show)

instance Semigroup BoolConj where
    (BoolConj a) <> (BoolConj b) = BoolConj (a && b)


instance Arbitrary BoolConj where
    arbitrary = do
        a <- arbitrary
        return (BoolConj a)

type BoolConjAssoc = BoolConj -> BoolConj -> BoolConj -> Bool

-- 7
newtype BoolDisj = BoolDisj Bool deriving (Eq, Show)

instance Semigroup BoolDisj where
    (BoolDisj a) <> (BoolDisj b) = BoolDisj (a || b)


instance Arbitrary BoolDisj where
    arbitrary = do
        a <- arbitrary
        return (BoolDisj a)

type BoolDisjAssoc = BoolDisj -> BoolDisj ->BoolDisj -> Bool

-- 8
data Or a b = Fst a | Snd b deriving (Eq, Show)

instance (Semigroup a, Semigroup  b ) => Semigroup (Or a b) where
    (Fst a) <> (Snd b) = Snd b
    (Fst a) <> (Fst b) = Fst b
    (Snd a) <> (Fst b) = Snd a
    (Snd a) <> (Snd b) = Snd a

instance (Arbitrary a, Arbitrary b) => Arbitrary (Or a b) where
    arbitrary = do
        a <- arbitrary
        b <- arbitrary
        frequency [ (1, return (Fst a)), (1, return (Snd b)) ]


type OrAssoc = Or String String -> Or String String -> Or String String -> Bool

-- 9
newtype Combine a b = Combine { unCombine :: a -> b }

instance (Semigroup b) => Semigroup (Combine a b ) where
    Combine {unCombine = f1} <> Combine {unCombine = f2} = Combine (f1 <> f2)


-- 10
newtype Comp a = Comp { unComp :: (a -> a) }

instance (Semigroup a) => Semigroup (Comp a) where
    Comp {unComp = f1} <> Comp {unComp = f2} = Comp (f1 <> f2)

-- 11

data Validation a b =
  Failure a | Success b
  deriving (Eq, Show)

instance Semigroup a =>
  Semigroup (Validation a b) where
    (Failure a) <> (Failure b)  = Failure (a <> b)
    (Failure a) <> _            = Failure (a)
    _           <> (Failure a)  = Failure (a)
    s           <> _            = s

instance (Arbitrary a, Arbitrary b) => Arbitrary (Validation a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    elements [(Success a), (Failure b)]

type ValidationAssoc = Validation String Ordering -> Validation String Ordering -> Validation String Ordering -> Bool

-- 12

newtype AccumulateRight a b = AccumulateRight (Validation a b) deriving (Eq, Show)

instance Semigroup b =>
    Semigroup (AccumulateRight a b) where
        AccumulateRight (Success a) <> AccumulateRight (Success b)  = AccumulateRight (Success (a <> b))
        AccumulateRight (Failure a) <> _                            = AccumulateRight (Failure a)
        _                           <> AccumulateRight (Failure a)  = AccumulateRight (Failure a)
 
instance (Arbitrary a, Arbitrary b) => Arbitrary (AccumulateRight a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    elements [(AccumulateRight (Success a)), (AccumulateRight (Failure b))]

type AccumulateRightAssoc = AccumulateRight String Ordering -> AccumulateRight String Ordering -> AccumulateRight String Ordering -> Bool

--13

newtype AccumulateBoth a b = AccumulateBoth (Validation a b) deriving (Eq, Show)

instance (Semigroup a, Semigroup b) => Semigroup (AccumulateBoth a b) where
        AccumulateBoth (Success a) <> AccumulateBoth (Success b)    = AccumulateBoth (Success (a <> b))
        AccumulateBoth (Failure a) <> AccumulateBoth (Failure b)    = AccumulateBoth (Failure (a <> b))
        AccumulateBoth (Failure a) <> _                             = AccumulateBoth (Failure a)
        _                          <> AccumulateBoth (Failure a)    = AccumulateBoth (Failure a)


instance (Arbitrary a, Arbitrary b) => Arbitrary (AccumulateBoth a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    elements [(AccumulateBoth (Success a)), (AccumulateBoth (Failure b))]

type AccumulateBothAssoc = AccumulateBoth String Ordering -> AccumulateBoth String Ordering -> AccumulateBoth String Ordering -> Bool



--TODO check newType vs data
main :: IO ()
main = do
    quickCheck (semigroupAssoc :: TrivialAssoc)
    quickCheck (semigroupAssoc :: IdentityAssoc)
    quickCheck (semigroupAssoc :: TwoAssoc)
    quickCheck (semigroupAssoc :: ThreeAssoc)
    quickCheck (semigroupAssoc :: FourAssoc)
    quickCheck (semigroupAssoc :: BoolConjAssoc)
    quickCheck (semigroupAssoc :: BoolDisjAssoc)
    quickCheck (semigroupAssoc :: OrAssoc)
    quickCheck (semigroupAssoc :: ValidationAssoc)
    quickCheck (semigroupAssoc :: AccumulateRightAssoc)
    quickCheck (semigroupAssoc :: AccumulateBothAssoc)
 

