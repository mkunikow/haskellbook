instance Applicative Maybe where
    pure = Just

    Nothing <*> _ = Nothing
    _ <*> Nothing = Nothing
    Just f <*> Just a = Just (f a)
    