module OptionalMonoid where
import Data.Monoid

data Booly a =
    False'
    | True'
    deriving (Eq, Show)


data Optional a =
    Nada
    | Only a
    deriving (Eq, Show)

instance Monoid a => Monoid (Optional a) where
    mempty = Nada
    mappend Nada r = r
    mappend r Nada = r
    mappend (Only a1) (Only a2) = Only (a1 `mappend` a2)

testOptionalMonoid :: IO ()
testOptionalMonoid = 
    if  Only (Sum 1) `mappend` Only (Sum 1) == Only (Sum {getSum = 2})
    then putStrLn "OptionalMonoid fine!"
    else putStrLn "OptionalMonoid failed check"


 