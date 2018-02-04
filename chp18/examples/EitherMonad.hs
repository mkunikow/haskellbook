module EitherMonad where


-- m ~ Either e
-- (>>=) :: Monad m
--     =>  m a
--     -> (a ->m b)
--     ->  m b

-- (>>=) :: Either e a
--     -> (a -> Either e b)
--     -> Either e b

-- same as pure
-- return :: Monad m => a ->        m aq
-- return ::            a -> Either e a


-- years ago
type Founded = Int

-- number of programmers
type Coders = Int

data SoftwareShop = Shop
  { founded :: Founded
  , programmers :: Coders
  } deriving (Eq, Show)

data FoundedError
  = NegativeYears Founded
  | TooManyYears Founded
  | NegativeCoders Coders
  | TooManyCoders Coders
  | TooManyCodersForYears Founded
                          Coders
  deriving (Eq, Show)

validateFounded :: Int -> Either FoundedError Founded
validateFounded n
  | n < 0 = Left $ NegativeYears n
  | n > 500 = Left $ TooManyYears n
  | otherwise = Right n

-- Tho, many programmers *are* negative.
validateCoders :: Int -> Either FoundedError Coders
validateCoders n
  | n < 0 = Left $ NegativeCoders n
  | n > 5000 = Left $ TooManyCoders n
  | otherwise = Right n

mkSoftware :: Int -> Int -> Either FoundedError SoftwareShop
mkSoftware years coders = do
  founded <- validateFounded years
  programmers <- validateCoders coders
  if programmers > div founded 10
    then Left $ TooManyCodersForYears founded programmers
    else Right $ Shop founded programmers

-- Example of ussage    
-- mkSoftware 0 0
