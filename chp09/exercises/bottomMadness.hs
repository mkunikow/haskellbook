module BottomMadness where

x1 = [x^y | x <- [1..5], y <- [2, undefined]] -- blow
x2 = take 1  [x^y | x <- [1..5], y <- [2, undefined]] -- OK
x3 = sum [1, undefined, 3] -- blow
x4 = length [1, 2, undefined] -- OK
x5 = length $ [1, 2, 3] ++ undefined-- blow
x6 = take 1 $ filter even [1, 2, 3, undefined] -- OK
x7 = take 1 $ filter even [1, 3, undefined]  -- Blow
x8 = take 1 $ filter odd [1, 3, undefined]  -- OK
x9 = take 2 $ filter odd [1, 3, undefined] --OK
x10 = take 3 $ filter odd [1, 3, undefined] -- blow

main :: IO ()
main =
    print $ show x10

