module SquareCube where

mySqr = [x^2 | x <- [1..5]]
myCube = [y^3 | y <- [1..5]]

myTuples = [(x, y) | x <- mySqr, y <- myCube]
myTuples2 = [(x, y) | x <- mySqr, y <- myCube, x < 50, y< 50]
len = length myTuples2

main :: IO ()
main =
    print $ "myTuples: " ++ show myTuples ++ "\n myTuples2: " ++ show myTuples2 ++ " total: " ++ show len
    

