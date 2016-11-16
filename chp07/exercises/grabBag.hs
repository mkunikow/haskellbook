module GrabBag where
    mTh1 x y z = x * y * z
    mTh2 x y = \z -> x * y * z
    mTh3 x = \y -> \z -> x * y * z
    mTh4 = \x -> \y -> \z -> x * y * z

    addOneIfOdd n = case odd n of
      True -> f n
      False -> n
      where f n = n + 1

    addOneIfOddLamda n = case odd n of
      True -> f n
      False -> n
      where f = \n -> n + 1

    addFive x y = (if x > y then y else x) + 5
    addFiveLamda = \x -> \y -> (if x > y then y else x) + 5

    mflip f = \x -> \y -> f y x
    mflipNoLamda f x y = f y x
