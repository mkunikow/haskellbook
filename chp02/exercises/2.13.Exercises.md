Example:
-- We want to make this more explicit
2 + 2 * 3 - 3
-- this will produce the same result
2 + (2 * 3) - 3

Attempt the above on the following expressions.
1. 2 + 2 * 3 - 1     ->  2 + (2 * 3) - 1
2. (^) 10 $ 1 + 1    ->  (^) 10 (1 + 1) -> (^) 10 2 -> 100
3. 2 ^ 2 * 4 ^ 5 + 1 ->  (2 ^ 2) * (4 ^ 5) + 1 -> ((2 ^ 2) * (2 ^ 5)) + 1


Equivalent expressions
Which of the following pairs of expressions will return the same result
when evaluated? Try to reason them out in your head by reading the
code and then enter them into the REPL to check your work:

1. 1 + 1 = 2
2. 10 ^ 2 = 100
3. (-) 37 400 == 37 - 400
4. 100 `div` 3 = 33 != 100/3 = 33.333
5. 2 * 5 + 18 = (2 * 5) + 18 != 2 * (5 + 18)


More fun with functions

waxOn = 1125
Is your programming language unreasonable?

10 + waxOn = 1135
-- or
(+10) waxOn = 1135
-- or
(-) 15 waxOn = - 1110
-- or
(-) waxOn 15 = 1110

4. Rewrite waxOn as a function with a where clause in your source file.
Load it into your REPL and make sure it still works as expected!

let waxOn = x * 5
 where z = 7
       y = z + 8
       x = y ^ 2





