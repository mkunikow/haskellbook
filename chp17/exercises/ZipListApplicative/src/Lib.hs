module Lib where

import Data.Monoid

data List a =
    Nil
    | Cons a (List a)
    deriving (Eq, Show)

instance Functor List where
    fmap _ Nil = Nil
    fmap f (Cons a t) = Cons (f a) (fmap f t)
    
append :: List a -> List a -> List a
append Nil ys = ys
append ys Nil = ys
append (Cons x xs) ys = Cons x $ xs `append` ys
    
fold :: (a -> b -> b) -> b -> List a -> b
fold _ b Nil = b
fold f b (Cons h t) = f h (fold f b t)
    
concat' :: List (List a) -> List a
concat' = fold append Nil

instance Monoid (List a) where
    mempty  = Nil
    mappend = append
      
instance Applicative List where
    pure x = Cons x Nil
    Nil <*> _   = Nil
    _   <*> Nil = Nil
    Cons f ft <*> l = (f <$> l) <> (ft <*> l)

take' :: Int -> List a -> List a
take' n Nil = Nil
take' 1 (Cons x _) = Cons x Nil
take' n (Cons x t) = Cons x (take' (n-1) t)

newtype ZipList' a =
    ZipList' (List a)
    deriving (Eq, Show)


instance Functor ZipList' where
    fmap f (ZipList' xs) =
        ZipList' $ fmap f xs

zipApplicative' :: List(a -> b) -> List a  -> List b
zipApplicative' Nil _ = Nil
zipApplicative' _ Nil = Nil
zipApplicative' (Cons f ft) (Cons x xs) = Cons (f x) Nil <> zipApplicative' ft xs

zipWith' :: (a -> b -> c) -> List a -> List b -> List c
zipWith' _ Nil _                   = Nil
zipWith' _ _ Nil                   = Nil
zipWith' f (Cons x xs) (Cons y ys) = Cons (f x y) (zipWith' f xs ys)

repeat' :: a -> List a
repeat' x = xs
  where xs = Cons x xs

instance Applicative ZipList' where
    pure x = ZipList' (Cons x Nil)

    ZipList' Nil  <*> _ = ZipList' Nil
    _  <*> ZipList' Nil = ZipList' Nil
    ZipList' xs <*> ZipList' ys = ZipList' (xs `zipApplicative'` ys)
    -- ZipList' xs <*> ZipList' ys = ZipList' (zipWith' id xs ys)

            
                            
zl' = ZipList'
z = zl' (Cons (+9) (Cons (*2) (Cons (+8) Nil)))
z' = zl' (Cons 1 (Cons 2 (Cons 3 Nil)))
r = z <*> z'

z2' = zl' (repeat' 1)
r2 = z <*> z2'




       
    

someFunc :: IO ()
someFunc = putStrLn "someFunc"
