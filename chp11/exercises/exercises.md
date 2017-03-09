# Exercises: Dog Types

Given the datatypes defined in the above sections,
1. Is Doggies a type constructor or a data constructor? -> type constructor
2. What is the kind of Doggies? -> `Doggies :: * -> *` 
3. What is the kind of Doggies String? -> `Doggies String :: *`
4. What is the type of Husky 10? -> `Husky 10 :: Num a => Doggies a`
5. What is the type of Husky (10 :: Integer)? -> `Husky (10 :: Integer) :: Doggies Integer`
6. What is the type of Mastiff "Scooby Doo"? -> `Mastiff "Scooby Doo :: Doggies String`
7. Is DogueDeBordeaux a type constructor or a data constructor? -> can be both
8. What is the type of DogueDeBordeaux? -> `DogueDeBordeaux :: doge -> DogueDeBordeaux doge`
9. What is the type of DogueDeBordeaux "doggie!" -> `DogueDeBordeaux "doggie!" :: DogueDeBordeaux String`

# Exercises: Cardinality

1. `data PugType = PugData`
Anwear: cardinality = 1

2. For this one, recall that Bool is also defined with the |:

```haskell
data Airline =
PapuAir
| CatapultsR'Us
| TakeYourChancesUnited
```
Anwear cardinality = 3

3. Given what we know about Int8, what’s the cardinality of Int16?

Anwear Cardinality = 2 ^ 16 = 65536

4. Use the REPL and maxBound and minBound to examine Int and Integer. What can you say about the cardinality of those types?

Answear:
* maxBound and maxBound is not defined for Integer
* Int ~ Int64

5. Extra credit (impress your friends!): What’s the connection between the 8 in Int8 and that type’s cardinality of 256?
Answear:
cardinality of Int8 = 2 ^ 8

# Exercises: For Example

1. What is the type of data constructor MakeExample? What happens when you request the type of Example?


```haskell
*MakeExample> :t MakeExample
MakeExample :: Example
*MakeExample> :t Example

<interactive>:1:1: Not in scope: data constructor ‘Example’
*MakeExample>
```

2. What if you try :info on Example in GHCi?  Can you determine what typeclass instances are defined for the Example type using :info in GHCi?


```haskell
*MakeExample> :i Example
data Example = MakeExample      -- Defined at makeExample.hs:3:1
instance Show^S^Q Example -- Defined at makeExample.hs:3:37
```
Answear:
The typeclasses instances: Show

3. Try making a new datatype like Example but with a single type argument added to MakeExample, such as Int. What has changed when you query MakeExample with :type in GHCi?


```haskell
data Example2 = MakeExample2 Int deriving Show

MakeExample> :t MakeExample2
MakeExample2 :: Int -> Example2


data Example3 a = MakeExample3 a deriving Show
*MakeExample> :t MakeExample3
MakeExample3 :: a -> Example3 a
```

# Exercises: Pity the Bool

1. Given a datatype

```haskell
data BigSmall =
Big Bool
| Small Bool
deriving (Eq, Show)
```

Cardinality of BigSmall: 2 + 2 = 4

2. Given a datatype

```haskell
import Data.Int

data NumberOrBool =
Numba Int8
| BoolyBool Bool
deriving (Eq, Show)

```
Cardinality of NumberOrBool = 2^8 + 2 = 258

# Exercises: How Does Your Garden Grow?

1. Given the type

```haskell
data FlowerType = Gardenia
    | Daisy
    | Rose
    | Lilac
    deriving Show

type Gardener = String

data Garden =
    Garden Gardener FlowerType
    deriving Show

```
Answear:

```haskell
data Garden = Gardenia Gardener
    | Daisy Gardener
    | Rose Garden
    | Lilac Garden
    deriving Show
```
# Exercises: The Quad
1.
```haskell
data Quad =
    One
    | Two
    | Three
    | Four
    deriving (Eq, Show)

eQuad = 4 + 4 = 8

``` 
2. `prodQuad :: (Quad, Quad)` -> 4 * 4 = 16
3. `funcQuad :: Quad -> Quad` -> 4 ^ 4
4. `prodTBool :: (Bool, Bool, Bool)` -> 2 * 2 * 2 = 8
5. `gTwo :: Bool -> Bool -> Bool` -> 2 ^ (2 * 2)
6. `fTwo :: Bool -> Quad -> Quad` -> 4 ^ (2 * 4)






