# Chapter 5 Exercises

## 5.5 Tyepe Arguments

It turns out that you can check the types of things that aren’t really
implemented yet, so long as you give GHCi an undefined to bind the
signature to.

Prelude> let f :: a -> a -> a -> a; f = undefined
Prelude> let x :: Char; x = undefined
Prelude> :t f x



1. If the type of f is a -> a -> a -> a, and the type of x is Char then
the type of f x is

a) Char -> Char -> Char
b) x -> x -> x -> x
c) a -> a -> a
d) a -> a -> a -> Char

Answear:
a)

2. If the type of g is a -> b -> c -> b, then the type of g 0 'c' "woot" is

a) String
b) Char -> String
c) Int
d) Char

Answear:
d)

3. If the type of h is (Num a, Num b) => a -> b -> b, then the type of
h 1.0 2 is

a) Double
b) Integer
c) Integral b => b
d) Num b => b

Answear:
d)

4. If the type of h is (Num a, Num b) => a -> b -> b, then the type of
h 1 (5.5 :: Double) is

a) Integer
b) Fractional b => b
c) Double
d) Num b => b

Answear:
c)

5. If the type of jackal is (Ord a, Eq b) => a -> b -> a, then the type
of jackal "keyboard" "has the word jackal in it"

a) [Char]
b) Eq b => b
c) b -> [Char]
d) b
e) Eq b => b -> [Char]

Answear:
a)



6. If the type of jackal is (Ord a, Eq b) => a -> b -> a, then the type
of jackal "keyboard"

a) b
b) Eq b => b
c) [Char]
d) b -> [Char]
e) Eq b => b -> [Char]

Answear:
e)

7. If the type of kessel is (Ord a, Num b) => a -> b -> a, then the
type of kessel 1 2 is

a) Integer
b) Int
c) a
d) (Num a, Ord a) => a
e) Ord a => a
f) Num a => a

Answear:
d) ?

8. If the type of kessel is (Ord a, Num b) => a -> b -> a, then the
type of kessel 1 (2 :: Integer) is

a) (Num a, Ord a) => a
b) Int
c) a
d) Num a => a
e) Ord a => a
f) Integer

Answear:
a) ?

9. If the type of kessel is (Ord a, Num b) => a -> b -> a, then the
type of kessel (1 :: Integer) 2 is

a) Num a => a
b) Ord a => a
c) Integer
d) (Num a, Ord a) => a
e) a

Answear:
a)

## 5.5.TypeMatching

<!-- Exercises: Type Matching -->
<!-- Below you’ll find a list of several standard functions we’ve talked -->
<!-- about previously. Under that is a list of their type signatures. Match -->
<!-- the function to its type signature. Try to do it without peeking at the -->
<!-- type signatures (either in the text or in GHCi) and then check your -->
<!-- work. You may find it easier to start from the types and work out -->
<!-- what you think a function of that type would do. -->



1. Functions:
a) not
b) length
c) concat
d) head
e) (<)

2. Type signatures:
a) d :: [a] -> a
b) c :: [[a]] -> [a]
c) a :: Bool -> Bool
d) b :: [a] -> Int
e) e :: Ord a => a -> a -> Bool


## 5.9 Type variable or specific type constructor?

1. You will be shown a type declaration, and you should categorize
each type. The choices are a fully polymorphic type variable,
constrained polymorphic type variable, or concrete type con-
structor.
f :: Num a => a -> b -> Int -> Int
--           [0]  [1]   [2]    [3]
Here, the answer would be: constrained polymorphic (Num) ([0]),
fully polymorphic ([1]), and concrete ([2] and [3]).

2. Categorize each component of the type signature as described
in the previous example.
f :: zed -> Zed -> Blah
     [0]    [1]    [2]

Here, the answer would be: 
*[0] fully polymorphic
*[1] concrete
*[2] concrete

3. Categorize each component of the type signature
f :: Enum b => a -> b -> C
              [0]  [1] [2]

Here, the answer would be: 
*[0] fully polymorphic
*[1] constrained polymorphic
*[2] concrete

4. Categorize each component of the type signature
f :: f -> g -> C
     [0]  [1]  [2]

Here, the answer would be: 
*[0] fully polymorphic
*[1] fully polymorphic
*[2] concrete


## 5.9 Multiple choice

1. A value of type [a] is
  * a) a list of alphabetic characters
  * b) a list of lists
  * c) a list whose elements are all of some type a
  * d) a list whose elements are all of different types

### Answear: c

2. A function of type [[a]] -> [a] could
  * a) take a list of strings as an argument
  * b) transform a character into a string
  * c) transform a string in to a list of strings
  * d) take two arguments

### Answear: a

3. A function of type [a] -> Int -> a
  * a) takes one argument
  * b) returns one element of type a from a list
  * c) must return an Int value
  * d) is completely fictional

### Answear: b

4. A function of type (a, b) -> a
  * a) takes a list argument and returns a Char value
  * b) has zero arguments
  * c) takes a tuple argument and returns the first value
  * d) requires that a and b be of different types

### Answear: c


## 5.9 Does it compile?

For each set of expressions, figure out which expression, if any, causes the compiler to squawk at you (n.b. we do not mean literal squawking) and why. 
Fix it if you can.

1. 

```
bigNum = (^) 5 $ 10
wahoo = bigNum $ 10 -- error 
```

2. 

```
x = print
y = print "woohoo!"
z = x "hello world"
```

Answear: compile.

3.

```
a = (+)
b = 5
c = b 10 -- error
d = c 200 -- error
```
4.

```
a = 12 + b -- error
b = 10000 * c --error
```

## 5.9 Determine the type

For the following functions, determine the type of the specified value.
Note: you can type them into a file and load the contents of the file
in GHCi. You can then query the types after you’ve loaded them.

1. All function applications return a value. Determine the value returned by these function applications and the type of that value.

  a) (* 9) 6                                        => Num a => a
  b) head [(0,"doge"),(1,"kitteh")]                 => Num t => (t, [Char])
  c) head [(0 :: Integer ,"doge"),(1,"kitteh")]     => (Integer, [Char])
  d) if False then True else False                  => Bool
  e) length [1, 2, 3, 4, 5]                         => Int
  f) (length [1, 2, 3, 4]) > (length "TACOCAT")     => Bool
  
2. Given
  x = 5
  y = x + 5
  w = y * 10
What is the type of w?

Answear: 
:t w ::  Num a => a

3. Given
  x = 5
  y = x + 5
  z y = y * 10
What is the type of z?
:t z :: Num a => a -> a

4. Given
  x = 5
  y = x + 5
  f = 4 / y
What is the type of f?
:t f :: Fractional a => a

5. Given
 x = "Julie"
 y = " <3 "
 z = "Haskell"
 f = x ++ y ++ z
What is the type of f?
:t f :: [Char]

 



