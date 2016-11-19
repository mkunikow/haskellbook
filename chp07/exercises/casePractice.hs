module CasePractise where
    functionC x y = if (x > y) then x else y
    functionCCase x y = 
        case x > y of
            True  -> x
            False -> y

    ifEvenAdd2 n = if even n then (n+2) else n
    ifEvenAdd2Case n =
        case even n of
            True  -> n + 2
            False -> n

    nums x =
        case compare x 0 of
            LT -> -1
            GT -> 1
            EQ -> 0

