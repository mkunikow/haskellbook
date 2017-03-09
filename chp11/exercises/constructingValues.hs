
module ConstructinValues where

data GuessWhat = Chickenbutt deriving (Eq, Show)

data Id a = MkId a deriving (Eq, Show)

data Product a b =
    Product a b deriving (Eq, Show)

data Sum a b =
    First a
    | Second b
    deriving (Eq, Show)

data RecordProduct a b =
    RecordProduct { pfirst :: a , psecond :: b }
    deriving (Eq, Show)


trivialValue :: GuessWhat
trivialValue = Chickenbutt


idInt :: Id Integer
idInt = MkId 10

idIdentity :: Id (a -> a)
idIdentity = MkId $ \x -> x

type Awesome = Bool
type Name = String

person :: Product Name Awesome
person = Product "Simon" True


data Twitter = Twitter deriving (Eq, Show)

data AskFm = AskFm deriving (Eq, Show)

socialNetwork :: Sum Twitter AskFm
socialNetwork = First Twitter


data SocialNetwork =
    Twitter2
    | AskFm2
    deriving (Eq, Show)

type Twitter2 = String
type AskFm2 = String

twitter :: Sum Twitter2 AskFm2
twitter = First "Twitter"

-- -- It has no way of knowing
-- -- we made a mistake because
-- -- both values are just Strings
askfm :: Sum Twitter2 AskFm2
askfm = First "AskFm"


myRecord :: RecordProduct Integer Float
myRecord = RecordProduct 42 0.00001

myRecord2 :: RecordProduct Integer Float
myRecord2 = RecordProduct { pfirst = 42, psecond = 0.00001 }


data OperatingSystem =
    GnuPlusLinux
    | OpenBSDPlusNevermindJustBSDStill
    | Mac
    | Windows
    deriving (Eq, Show)


data ProgrammingLanguage =
    Haskell
    | Agda
    | Idris
    | PureScript
    deriving (Eq, Show)

data Programmer =
    Programmer { os :: OperatingSystem
                , lang :: ProgrammingLanguage }
    deriving (Eq, Show)

nineToFive :: Programmer
nineToFive = Programmer { os = Mac, lang = Haskell }

-- We can reorder stuff when we use record syntax
feelingWizardly :: Programmer
feelingWizardly = Programmer { lang = Agda, os = GnuPlusLinux }





