-- Now for some exercises. First, determine in your head what the
-- following expressions will return, then validate in the REPL:
-- 1. let x = 5 in x
-- 2. let x = 5 in x * x
-- 3. let x = 5; y = 6 in x * y
-- 4. let x = 3; y = 1000 in x + 3

mult3 = x * y
  where x = 5
        y = 6

mult4 = x + 3
 where  x = 3
        y = 1000

-- Rewrite the following let expressions into declarations with where
-- clauses:
-- 1. let x = 3; y = 1000 in x * 3 + y
-- 2. let y = 10; x = 10 * 5 + y in x * 5
-- 3. let x = 7; y = negate x; z = y * 10 in z / x + y

m1 = x * 3 + y
 where x = 3
       y = 1000

m2 = x * 5
 where y = 10
       x = 10 * 5

m3 = z / x + y
 where x = 7
       y = negate x
       z = y * 10
