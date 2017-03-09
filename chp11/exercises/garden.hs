module Garden where

-- data FlowerType = Gardenia
--     | Daisy
--     | Rose
--     | Lilac
--     deriving Show

type Gardener = String

-- data Garden =
--     Garden Gardener FlowerType
--     deriving Show

data Garden = Gardenia Gardener
    | Daisy Gardener
    | Rose Garden
    | Lilac Garden
    deriving Show

