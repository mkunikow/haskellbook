module ZippingExercises where

myzip :: [a] -> [b] -> [(a, b)] 

myzip _ [] = []
myzip [] _ = []
myzip (x:xs) (y: ys) = (x, y) : myzip xs ys

myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith _ _ [] = []
myZipWith _ [] _ = []
myZipWith f (x:xs) (y: ys) = f x y : myZipWith f xs ys

myZipByZipWith :: [a] -> [b] -> [(a,b)]
myZipByZipWith = myZipWith (,)



main :: IO ()
main = 
    print $ show $ myZipByZipWith [1,2] [10, 11]
