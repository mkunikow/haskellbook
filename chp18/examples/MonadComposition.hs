module MonadComposition where

import Control.Monad ((>=>))

sayHi :: String -> IO String
sayHi greeting = do
  putStrLn greeting
  getLine

readM :: Read a => String -> IO a
readM = return . read

getAge :: String -> IO Int
getAge = sayHi >=> readM


-- [1]      [2][3]
-- (a     -> m  b)
-- String -> IO String

--    [4]   [5][6]
-- -> (b  -> m  c)
-- String -> IO a

--   [7]   [8][9]
-- -> a ->  m  c
--   String IO a



askForAge :: IO Int
askForAge = getAge "Hello! How old are you? "
