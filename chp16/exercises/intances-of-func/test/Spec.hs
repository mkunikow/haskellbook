import Test.QuickCheck
import Test.QuickCheck.Function


--1
newtype Identity a = Identity a deriving (Eq, Show)

instance (Arbitrary a) => Arbitrary (Identity a) where
  arbitrary = do
      a <- arbitrary
      return (Identity a)

instance Functor Identity where
  fmap f (Identity a) = Identity (f a)

identityFunctorIdentity x = functorIdentity (x :: Identity (Int))
identityFunctorCompose x = functorCompose (+1) (*2) (x :: Identity (Int))

type IdentityFunctorIdentity = Identity (Int) -> Bool
type IdentityFunctorCompose = Identity (Int) -> IntToInt -> IntToInt -> Bool

--2
data Pair a = Pair a a deriving (Eq, Show)

instance (Arbitrary a) => Arbitrary (Pair a) where
    arbitrary = do
        a <- arbitrary
        b <- arbitrary
        return (Pair a b)

instance Functor Pair where
  fmap f (Pair a b) = Pair (f a) (f b)

type PairFunctorIdentity = Pair Int -> Bool
type PairFunctorCompose = Pair Int -> IntToInt -> IntToInt -> Bool

--3
data Two a b = Two a b deriving (Eq, Show)

instance Functor (Two a) where
    fmap f (Two a b) = Two a (f b)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Two a b) where
    arbitrary = do
        a <- arbitrary
        b <- arbitrary
        return (Two a b)
    
type TwoFunctorIdentity = Two Int Int -> Bool
type TwoFunctorCompose = Two Int Int -> IntToInt -> IntToInt -> Bool

--4
data Three a b c = Three a b c deriving (Eq, Show)

instance Functor (Three a b) where
    fmap f (Three a b c) = Three a b (f c)

instance (Arbitrary a, Arbitrary b, Arbitrary c) => Arbitrary (Three a b c) where
    arbitrary = do
        a <- arbitrary
        b <- arbitrary
        c <- arbitrary
        return (Three a b c)
    
type ThreeFunctorIdentity = Three Int Int Int -> Bool
type ThreeFunctorCompose = Three Int Int Int -> IntToInt -> IntToInt -> Bool

--5
data Three' a b = Three' a b b deriving (Eq, Show)

instance Functor (Three' a ) where
    fmap f (Three' a b c) = Three' a (f b) (f c)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Three' a b) where
    arbitrary = do
        a <- arbitrary
        b <- arbitrary
        c <- arbitrary
        return (Three' a b c)
        
type Three'FunctorIdentity = Three' Int Int -> Bool
type Three'FunctorCompose = Three' Int Int -> IntToInt -> IntToInt -> Bool

--6 
data Four a b c d = Four a b c d deriving (Eq, Show)

instance Functor (Four a b c) where
    fmap f (Four a b c d) = Four a b c (f d)

instance (Arbitrary a, Arbitrary b, Arbitrary c, Arbitrary d) 
    => Arbitrary (Four a b c d) where
    arbitrary = do
        a <- arbitrary
        b <- arbitrary
        c <- arbitrary
        d <- arbitrary
        return (Four a b c d)
    
type FourFunctorIdentity = Four  Int Int Int Int -> Bool
type FourFunctorCompose = Four Int Int Int Int -> IntToInt -> IntToInt -> Bool

--7
data Four' a b = Four' a a a b deriving (Eq, Show)

instance Functor (Four' a ) where
    fmap f (Four' a b c d) = Four' a b c (f d)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Four' a b) where
    arbitrary = do
        a <- arbitrary
        b <- arbitrary
        c <- arbitrary
        d <- arbitrary
        return (Four' a b c d)
        
type Four'FunctorIdentity = Four' Int Int -> Bool
type Four'FunctorCompose = Four' Int Int -> IntToInt -> IntToInt -> Bool

--8
data Trivial = Trivial deriving (Eq, Show)
--cant impplement functor for Trivial, wrong kind
-- :k Trivial
-- Trivial :: *





-- helpers

functorIdentity :: (Functor f, Eq (f a)) => f a -> Bool
functorIdentity f = fmap id f == f

functorCompose :: (Eq (f c), Functor f) => (a -> b) -> (b -> c) -> f a -> Bool
functorCompose f g x = (fmap g (fmap f x)) == (fmap (g . f) x)

functorCompose' :: (Eq (f c), Functor f) =>
    f a
  -> Fun a b
  -> Fun b c
  -> Bool

functorCompose' x (Fun _ f) (Fun _ g) =
    (fmap (g . f) x) == (fmap g . fmap f $ x)

type IntToInt = Fun Int Int
type IntFC = [Int] -> IntToInt -> IntToInt -> Bool
type IntIdFC = [Int] -> Bool


main :: IO ()
main = do
    quickCheck (functorIdentity:: IntIdFC)
    quickCheck (functorCompose':: IntFC)
    quickCheck (functorIdentity:: IdentityFunctorIdentity)
    quickCheck (functorCompose':: IdentityFunctorCompose)
    quickCheck (functorIdentity:: PairFunctorIdentity)
    quickCheck (functorCompose':: PairFunctorCompose)
    quickCheck (functorIdentity:: TwoFunctorIdentity)
    quickCheck (functorCompose':: TwoFunctorCompose)
    quickCheck (functorIdentity:: ThreeFunctorIdentity)
    quickCheck (functorCompose':: ThreeFunctorCompose)
    quickCheck (functorIdentity:: Three'FunctorIdentity)
    quickCheck (functorCompose':: Three'FunctorCompose)
    quickCheck (functorIdentity:: FourFunctorIdentity)
    quickCheck (functorCompose':: FourFunctorCompose)
    quickCheck (functorIdentity:: Four'FunctorIdentity)
    quickCheck (functorCompose':: Four'FunctorCompose)
  