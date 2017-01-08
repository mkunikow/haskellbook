# Exercises: Grab Bag

Note the following exercises are from source code files, not written
for use directly in the REPL. Of course, you can change them to test
directly in the REPL if you prefer.

1. Which (two or more) of the following are equivalent?
   * a) `mTh x y z = x * y * z`
   * b) `mTh x y = \z -> x * y * z`
   * c) `mTh x = \y -> \z -> x * y * z`
   * d) `mTh = \x -> \y -> \z -> x * y * z`
   
   Answear:

   a) == b) == c) == d)

2. The type of mTh (above) is `Num a => a -> a -> a -> a`.
Which is the type of mTh 3?
   * a) `Integer -> Integer -> Integer`
   * b) `Num a => a -> a -> a -> a`
   * c) `Num a => a -> a`
   * **d)** `Num a => a -> a -> a`

3. Next, we’ll practice writing anonymous lambda syntax.
For example, one could rewrite:

   `addOne x = x + 1`

   Into:

   `addOne = \x -> x + 1`

   Try to make it so it can still be loaded as a top-level definition
by GHCi. This will make it easier to validate your answers.

   * a) Rewrite the f function in the where clause.

   ```haskell   
   addOneIfOdd n = case odd n of
      True -> f n
      False -> n
      where f n = n + 1
   ```

   ```haskell
   addOneIfOddLamda n = case odd n of
      True -> f n
      False -> n
      where f = \n -> n + 1
   ```

   * b) Rewrite the following to use anonymous lambda syntax:

   ```haskell
   addFive x y = (if x > y then y else x) + 5
   ```

   ```haskell
   addFiveLamda = \x -> \y -> (if x > y then y else x) + 5
   ```

   * c) Rewrite the following so that it doesn’t use anonymous
lambda syntax:

   ```haskell
   mflip f = \x -> \y -> f y x
   ```

   ```haskell
   mflipNoLamda f x y = f y x 
   ```

# Exercises: Variety Pack

1. Given the following declarations

```haskell
k (x, y) = x
k1 = k ((4-1), 10)
k2 = k ("three", (1 + 2))
k3 = k (3, True)
```

   * a) What is the type of k?
   `k::(x,y) -> x`
   * b) What is the type of k2? Is it the same type as k1 or k3?
   `k1:Num k2::String k3::Num`
   * c) Of k1, k2, k3, which will return the number 3 as the result? 
   `k1, k3` 

2. Fill in the definition of the following function:

```haskell
-- Remember: Tuples have the same syntax for their
-- type constructors and their data constructors.
f :: (a, b, c) -> (d, e, f) -> ((a, d), (c, f))
f (a, b, c) (d, e, f) = ((a, d), (c, f))
```

# Exercises: Case Practice

First, rewrite if-then-else expressions into case expressions.

1. The following should return x when x is greater than y.

```haskell
functionC x y = if (x > y) then x else y

functionC x y = 
    case x > y of
        True  -> x
        False -> y
```
2. The following will add 2 to even numbers and otherwise simply
return the input value.

```haskell
ifEvenAdd2 n = if even n then (n+2) else n
ifEvenAdd2 n =
    case even n of
        True  -> n + 2
        False -> n
```

3. The following compares a value, x, to zero and returns an indi-
cator for whether x is a postive number or negative number. But
what if x is 0? You may need to play with the compare function a
bit to find what to do.

```haskell
 nums x =
    case compare x 0 of
        LT -> -1
        GT -> 1
        EQ -> 0
```

# 7.11 Chapter Exercises

1. A polymorphic function

   * a) changes things into sheep when invoked
   * b) has multiple arguments
   * c) has a concrete type
   * **d)** may resolve to values of different types, depending on in-puts

2. Two functions named f and g have types `Char -> String` and `String -> [String]` respectively. The composed function `g . f` has the type

   * a) `Char -> String`
   * **b)** `Char -> [String]`
   * c) `[[String]]`
   * d) `Char -> String -> [String]`

3. A function `f` has the type `Ord a => a -> a -> Bool` and we apply it to one numeric value. What is the type now?

   * a) `Ord a => a -> Bool`
   * **b)** `Num -> Num -> Bool`
   * c) `Ord a => a -> a -> Integer`
   * d) `(Ord a, Num a) => a -> Bool`

4. A function with the type `(a -> b) -> c`

    * a) requires values of three different types
    * **b)** is a higher-order function
    * c) must take a tuple as its first argument
    * d) has its parameters in alphabetical order

5. Given the following definition of `f`, what is the type of `f True`?

```haskell
f :: a -> a
f x = x
```
* a) `f True :: Bool`
* b) `f True :: String`
* **c)** `f True :: Bool -> Bool`
* d) `f True :: a`

   
   

   








  
   




