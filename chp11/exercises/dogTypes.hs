module DogTypes where

data DogueDeBordeaux doge = DogueDeBordeaux doge

data Doggies a =
        Husky a
    | Mastiff a
    deriving (Eq, Show)
