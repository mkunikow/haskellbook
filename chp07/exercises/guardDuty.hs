module GuardDuty where

avgGrade :: (Fractional a, Ord a) => a -> Char
avgGrade x
    | otherwise = 'F'
    | y >= 0.9 = 'A'
    | y >= 0.8 = 'B'
    | y >= 0.7 = 'C'
    | y >= 0.59 = 'D'
    | y <  0.59 = 'F'
    where y = x / 100


-- 1. It is probably clear to you why you wouldn’t put an otherwise in
-- your top-most guard, but try it with avgGrade anyway and see
-- what happens. It’ll be more clear if you rewrite it as an actual
-- otherwise match: | otherwise = 'F'. What happens now if you
-- pass a 90 as an argument? 75? 60?

-- always returns 'F'

-- 2. What happens if you take avgGrade as it is written and reorder
-- the guards? Does it still typecheck and work the same? Try
-- moving | y >= 0.7 = 'C' and passing it the argument 90, which
-- should be an ‘A.’ Does it return an ‘A’?


-- 3. The following function returns
-- b) True when xs is a palindrome
pal xs
    | xs == reverse xs = True
    | otherwise = False

-- 4.What types of arguments can pal take?
-- List, each element must be Eq

-- 5. What is the type of the function pal?
-- pal :: Eq a ==> [a] -> Bool

--  6. The following function returns

numbers x
    | x < 0 = -1
    | x == 0 = 0
    | x > 0 = 1

-- c) an indication of whether its argument is a positive or nega-
-- tive number or zero

-- 7. What types of arguments can numbers take?
-- Ord

-- 8. What is the type of the function numbers?
-- numbers :: (Num a, Num a1, Ord a1) => a1 -> a




    


   
