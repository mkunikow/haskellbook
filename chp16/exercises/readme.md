
# Intermission: Exercises
## Exercises: Be Kind

1. What’s the kind of a? 

```haskell
a -> a
```

Answear: `a` is kind `*`

2. What are the kinds of `b` and `T` ? (The `T` is capitalized on purpose!)

```haskell
a -> b a -> T (b a)
```

Answear: `a` is kind `*`, `T` is kind `* -> *`, `b` is kind: `* -> *`

3. What’s the kind of `c` ?
```haskell
c a b -> c b a
```

Answear: `c` is kind : `* -> * -> *`

