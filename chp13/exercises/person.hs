module Person where

type Name = String
type Age = Integer

data Person = Person Name Age deriving Show

data PersonInvalid = NameEmpty
  | AgeTooLow
  | PersonInvalidUnknown String
  deriving (Eq, Show)

mkPerson :: Name
          -> Age
          -> Either PersonInvalid Person
mkPerson name age
  | name /= "" && age > 0 = Right $ Person name age
  | name == "" = Left NameEmpty
  | age <= 0 = Left AgeTooLow
  | otherwise = Left $ PersonInvalidUnknown $
                      "Name was: " ++ show name ++
                      " Age was: " ++ show age

gimmePerson :: IO ()
gimmePerson = do
    putStr "Enter name: "
    name <- getLine
    putStr "Enter age: "
    age <- getLine
    case mkPerson name (read age :: Integer) of
      Right person -> putStrLn $ "Yay! Successfully got a person: " ++ show person
      Left NameEmpty -> putStrLn "Name empty"
      Left AgeTooLow -> putStrLn "Age too low"
      Left (PersonInvalidUnknown err) -> putStrLn $ "Person invalid: " ++ err
    
