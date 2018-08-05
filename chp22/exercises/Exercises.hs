module ReaderPractice where

import Control.Applicative
import Data.Maybe
import Data.Monoid
import Data.Foldable

x = [1, 2, 3]
y = [4, 5, 6]
z = [7, 8, 9]

-- lookup :: Eq a => a -> [(a, b)] -> Maybe b
-- lookup a = foldr (\ (x, y) acc -> if x == a then Just y else Nothing) Nothing

-- zip x and y using 3 as the lookup key
xs :: Maybe Integer
xs = lookup 3 $ zip x y


-- zip y and z using 6 as the lookup key
ys :: Maybe Integer
ys = lookup 6 $ zip y z


-- it's also nice to have one that
-- will return Nothing, like this one
-- zip x and y using 4 as the lookup key
zs :: Maybe Integer
zs = lookup 4 $ zip x y


-- now zip x and z using a
-- variable lookup key
z' :: Integer -> Maybe Integer
z' n = lookup n $ zip x z


x1 :: Maybe (Integer, Integer)
x1 = liftA2 (,) xs ys
-- x1 = (,) <$> xs <*> ys

-- :t (,) <$> xs
--(,) <$> xs :: Maybe (b -> (Integer, b))

x2 :: Maybe (Integer, Integer)
x2 = liftA2 (,) ys zs

x3 :: Integer -> (Maybe Integer, Maybe Integer)
x3  = liftA2 (,) z' z'

summed :: Num c => (c, c) -> c
summed = uncurry (+)

bolt :: Integer -> Bool
-- use &&, >3, <8
bolt = liftA2 (&&) (>3) (<8)

main :: IO ()
main = do
    print $ sequenceA [Just 3, Just 2, Just 1] -- = Just [3,2,1]
    print $ sequenceA [x, y]  -- sequence [[1,2,3], [4,5,6]] = [[1,4],[1,5],[1,6],[2,4],[2,5],[2,6],[3,4],[3,5],[3,6]]
    print $ sequenceA [xs, ys] -- sequenceA [Just 6, Just 9] = Just [6,9] 
    print $ summed <$> ((,) <$> xs <*> ys) --  summed <$> ((,) <$> Just 6 <*> Just 9) summed <$> Just (6,9) = Just 15
    print $ fmap summed ((,) <$> xs <*> zs) -- Nothing
    print $ bolt 7 -- = True
    print $ fmap bolt z -- = [True,False,False]
    print $ sequenceA [(>3), (<8), even] 7 -- ::  Integral a => a -> [Bool]
    
    -- 1
    print $ sequAFold' 3
    -- 2
    print sequAs'
    -- 3
    print boltys

--    sequenceA :: (Applicative f, Traversable t)
--              => t (f a) -> f (t a)
    -- so in this:
 --   sequenceA [(>3), (<8), even] 7
    -- f ~ (->) a and t ~ []
    
sequA :: Integral a => a -> [Bool] 
sequA  = sequenceA [(>3), (<8), even] 


s' = summed <$> ((,) <$> xs <*> ys) -- Just 15

-- getAll $ foldMap All  [True, False] = False

-- 1  fold the boolean conjunction operator over the list of results of sequA (applied to some value).

sequAFold :: Integral a => a -> Bool
sequAFold x = getAll $ foldMap All (sequA x)

sequAFold' :: Integral a => a -> Bool
sequAFold' =  getAll . foldMap All . sequA

-- 2 apply sequA to s'; you’ll need fromMaybe.
sequAs' = sequA . fromMaybe undefined $ s'

-- 3. apply bolt to ys; you’ll need fromMaybe.
boltys = bolt . fromMaybe undefined $ ys

    




