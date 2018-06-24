module AxingTediousCode where

-- Thanks for the great example, Alex
data Query = Query

data SomeObj = SomeObj

data IoOnlyObj = IoOnlyObj

data Err = Err

-- There's a decoder function that makes
-- some object from String
decodeFn :: String -> Either Err SomeObj
decodeFn = undefined

-- There's a query, that runs against the
-- DB and returns array of strings
fetchFn :: Query -> IO [String]
fetchFn = undefined

-- an additional "context initializer",
-- that also has IO
makeIoOnlyObj :: [SomeObj] -> IO [(SomeObj, IoOnlyObj)]
makeIoOnlyObj = undefined


-- before
pipelineFn :: Query -> IO (Either Err [(SomeObj, IoOnlyObj)])
pipelineFn query = do
    a <- fetchFn query
    case sequence (map decodeFn a) of
        (Left err) -> return $ Left err
        (Right res) -> do
            a <- makeIoOnlyObj res
            return $ Right a

pipelineFn' :: Query -> IO (Either Err [(SomeObj, IoOnlyObj)])
pipelineFn' query = do
    a <- fetchFn query
    traverse makeIoOnlyObj (mapM decodeFn a)

--  :t mapM decodeFn ["a"]
--  mapM decodeFn ["a"] 
-- :: Either Err [SomeObj]

-- :t traverse makeIoOnlyObj (mapM decodeFn ["a"])
-- traverse makeIoOnlyObj (mapM decodeFn ["a"]) 
-- :: IO (Either Err [(SomeObj, IoOnlyObj)])


pipelineFn'' :: Query -> IO (Either Err [(SomeObj, IoOnlyObj)])
pipelineFn'' = (((traverse makeIoOnlyObj) . (mapM decodeFn)) =<<) . fetchFn

pipelineFn2 :: Query -> IO (Either Err [(SomeObj, IoOnlyObj)])
pipelineFn2 = (traverse makeIoOnlyObj . mapM decodeFn =<<) . fetchFn

-- :t traverse makeIoOnlyObj . (mapM decodeFn =<<)

-- :t traverse makeIoOnlyObj
-- traverse makeIoOnlyObj
--  :: Traversable t => t [SomeObj] -> IO (t [(SomeObj, IoOnlyObj)])


-- mapM decodeFn
--   :: Traversable t => t String -> Either Err (t SomeObj)

-- :t ((traverse makeIoOnlyObj) . (mapM decodeFn))
-- :: [String] -> IO (Either Err [(SomeObj, IoOnlyObj)])

-- :t (=<<)
-- (=<<) :: Monad m => (a -> m b) -> m a -> m b



-- :t (traverse makeIoOnlyObj . traverse decodeFn =<<)
--   :: IO [String] -> IO (Either Err [(SomeObj, IoOnlyObj)])



pipelineFn''' :: Query -> IO (Either Err [(SomeObj, IoOnlyObj)])
pipelineFn''' = (traverse makeIoOnlyObj . traverse decodeFn =<<) . fetchFn



-- TODO remove this
-- sequenceA   :: Applicative f    => t (f a)  -> f (t a)
-- fmap        :: Functor f        => (a -> b) -> f a      -> f b
    

    
    
    
            

