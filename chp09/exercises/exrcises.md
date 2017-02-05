# Intermission: Is it in normal form?

For each expression below, determine whether it’s in:

1. normal form, which implies weak head normal form;
2. weak head normal form only; or,
3. neither.


1. `[1, 2, 3, 4, 5]` -- WHNF & NF
2. `1 : 2 : 3 : 4 : _` -- ??
3. `enumFromTo 1 10` -- WHNF
4. `length [1, 2, 3, 4, 5]`
5. `sum (enumFromTo 1 10)`
6. `['a'..'m'] ++ ['n'..'z']`
7. `(_, 'b')` -- ??

# Exercises: More Bottoms
1. Will the following expression return a value or be ⊥?
```haskell
take 1 $ map (+1) [undefined, 2, 3]
```
*Bottom*
2. Will the following expression return a value?
```haskell
take 1 $ map (+1) [1, undefined, 3]

```
*Return value*
3. Will the following expression return a value?
```haskell
take 2 $ map (+1) [1, undefined, 3]
```
*Bottom*
4. What does the following mystery function do? What is its type?
Describe it (to yourself or a loved one) in standard English and
then test it out in the REPL to make sure you were correct.

```haskell
itIsMystery xs = map (\x -> elem x "aeiou") xs

```
```haskell
itIsMystery :: [Char] -> [Bool]
```


5. What will be the result of the following functions:
```haskell
a) map (^2) [1..10]
[1,4,9,16,25,36,49,64,81,100]

b) map minimum [[1..10], [10..20], [20..30]]
-- n.b. `minimum` is not the same function
-- as the `min` that we used before
[1,10,20]
c) map sum [[1..5], [1..5], [1..5]]
[15,15,15]

```

6. Back in the Functions chapter, you wrote a function called
`foldBool`. That function exists in a module known as `Data.Bool`
and is called bool. Write a function that does the same (or simi-
lar, if you wish) as the map` (if-then-else)` function you saw above
but uses bool instead of the `if-then-else syntax`. Your first step
should be bringing the bool function into scope by typing import
`Data.Bool` at your Prelude prompt.





