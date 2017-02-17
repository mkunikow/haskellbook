module DatabaseProcessing where

import Data.Time

data DatabaseItem = DbString String
                    | DbNumber Integer
                    | DbDate UTCTime
                    deriving (Eq, Ord, Show)

theDatabase :: [DatabaseItem]
theDatabase =
    [ DbDate (UTCTime (fromGregorian 1911 5 1) (secondsToDiffTime 34123))
    , DbNumber 9001
    , DbString "Hello, world!"
    , DbDate (UTCTime (fromGregorian 1921 5 1) (secondsToDiffTime 34123))
    ]

filterDbDate :: [DatabaseItem] -> [UTCTime]
filterDbDate = foldr (\a acc -> case a of DbDate t -> t : acc; _ -> acc) []

filterDbNumber :: [DatabaseItem] -> [Integer]
filterDbNumber = foldr (\a acc -> case a of DbNumber n -> n : acc; _ -> acc) []

sumDb :: [DatabaseItem] -> Integer
sumDb = sum . filterDbNumber

avgDb :: [DatabaseItem] -> Double
avgDb xs = sumDb / countDb
      where sumDb     =  fromIntegral $ sum dbNumbers
            countDb   =  fromIntegral $ length dbNumbers
            dbNumbers = filterDbNumber xs


 



