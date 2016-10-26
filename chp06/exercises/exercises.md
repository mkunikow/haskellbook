# 6.14 Chapter Exercises

## Multiple choice

1. The Eq class
   * a) includes all types in Haskell
   * b) is the same as the Ord class
   * **c) makes equality tests possible**
   * d) only includes numeric types

2. The typeclass Ord
   * a) allows any two values to be compared
   * **b) is a subclass of Eq**
   * c) is a superclass of Eq
   * d) has no instance for Bool

3. Suppose the typeclass Ord has an operator >. What is the type of >?
   * **a) Ord a => a -> a -> Bool**
   * b) Ord a => Int -> Bool
   * c) Ord a => a -> Char
   * d) Ord a => Char -> [Char]

4. In x = divMod 16 12
   * a) the type of x is Integer
   * b) the value of x is undecidable
   * **c) the type of x is a tuple**
   * d) x is equal to 12 / 16

5. The typeclass Integral includes
   * **a) Int and Integer numbers**
   * b) integral, real, and fractional numbers
   * c) Schrodinger’s cat
   * d) only positive numbers

## Does it typecheck?

1. Does the following code typecheck? If not, why not?

```Haskell
data Person = Person Bool
printPerson :: Person -> IO ()
printPerson person = putStrLn (show person)
```

Answear No.
There is no instance of Person that implmenets Show typeclass.

2. Does the following typecheck? If not, why not?

```Haskell
data Mood = Blah | Woot deriving Show
settleDown x = if x == Woot then Blah else x
```
Answear No.
There is no instance of Mood that implmenets Eq typeclass.

3. If you were able to get settleDown to typecheck:

Fix

```Haskell
data Mood = Blah | Woot deriving (Show, Eq)
settleDown x = if x == Woot then Blah else x
```

   * a) What values are acceptable inputs to that function? The values of type Show
   settleDown :: Mood -> Mood
   * b) What will happen if you try to run settleDown 9? Why? Error -> 9 is type Num. No instance of Mood that implement Num.
   * c) What will happen if you try to run Blah > Woot? Why? Error No instance of Mood that implements Ord.

4. Does the following typecheck? If not, why not?

```Haskell
type Subject = String
type Verb = String
type Object = String

data Sentence = Sentence Subject Verb Object deriving (Eq, Show)

s1 = Sentence "dogs" "drool"
s2 = Sentence "Julie" "loves" "dogs"
```

Answear: Yes. (s1 return partial function Sentence "dogs" "drool" :: Object -> Sentence)

## Given a datatype declaration, what can we do?

Given the following datatype definitions:


```Haskell
data Rocks = Rocks String deriving (Eq, Show)

data Yeah = Yeah Bool deriving (Eq, Show)

data Papu = Papu Rocks Yeah deriving (Eq, Show)
```
Which of the following will typecheck? For the ones that don’t
typecheck, why don’t they?

1. Error
```Haskell 
phew = Papu "chases" True
```

Fix

```Haskell
phew = Papu (Rocks "aaaa") $ Yeah True
```

2. OK
```Haskell 
truth = Papu (Rocks "chomskydoz")(Yeah True)
```

3. OK
```Haskell
equalityForall :: Papu -> Papu -> Bool
equalityForall p p' = p == p'
```

4. Error no instance Papu implements Ord
```Haskell 
comparePapus :: Papu -> Papu -> Bool
comparePapus p p' = p > p'
```

### Match the types

1. Error

```Haskell
i :: Num a => a
i = 1
i :: a
``` 
2. Error

```Haskell
f :: Float
f = 1.0

f :: Num a => a
```
3. OK

```Haskell
f :: Float
f = 1.0

f :: RealFrac a => a
```
4. OK

```Haskell
f :: Float
f = 1.0

f :: Fractional a => a
```
5. OK

```Haskell
freud :: a -> a
freud x = x

freud :: Ord a => a -> a
```
6. OK

```Haskell
freud' :: a -> a
freud' x = x

freud' :: Int -> Int

```
7. Error

```Haskell
myX = 1 :: Int
sigmund :: Int -> Int
sigmund x = myX

sigmund :: a -> a
```
8. Error

```Haskell
myX = 1 :: Int
sigmund' :: Int -> Int
sigmund' x = myX

sigmund' :: Num a => a -> a
```
9. OK

```Haskell
jung :: Ord a => [a] -> a
jung xs = head (sort xs)

jung :: [Int] -> Int
```
10. OK

```Haskell
young :: [Char] -> Char
young xs = head (sort xs)

young :: Ord a => [a] -> a
```
11. Error

```Haskell
mySort :: [Char] -> [Char]
mySort = sort
signifier :: [Char] -> Char
signifier xs = head (mySort xs)

signifier :: Ord a => [a] -> a
```

### Type-Kwon-Do Two: Electric Typealoo

1.

```Haskell
chk :: Eq b => (a -> b) -> a -> b -> Bool
chk  f a b = f a == b
```

2.

```Haskell
arith :: Num b => (a -> b) -> Integer -> a -> b
arith f i a = f a +
``` 
 

 





















