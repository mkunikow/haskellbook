module EnumFromTo where

eftBool :: Bool -> Bool -> [Bool]
eftBool = eftEnum

eftOrd :: Ordering -> Ordering -> [Ordering]
eftOrd = eftEnum

eftInt :: Int -> Int -> [Int]
eftInt = eftEnum

eftChar :: Char -> Char -> [Char]
eftChar = eftEnum

-- TODO try to implement without reverse
eftEnum :: (Enum  a) => a -> a -> [a]
eftEnum from to = reverse $ go from to []
    where go f t acc
            | fromEnum f >  fromEnum t  = []
            | fromEnum f == fromEnum t = f : acc
            | fromEnum f < fromEnum t  = go (succ f) t (f : acc)
