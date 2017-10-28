module WhoCares where

    data WhoCares a =
        ItDoesnt
        | Matter a
        | WhatThisIsCalled
        deriving (Eq, Show)

    instance Functor WhoCares where
        fmap _ ItDoesnt = ItDoesnt
        fmap _ WhatThisIsCalled = WhatThisIsCalled
        fmap f (Matter a) = Matter (f a)

    -- break id law    
    -- instance Functor WhoCares where
    --     fmap _ ItDoesnt = WhatThisIsCalled
    --     fmap f WhatThisIsCalled = ItDoesnt
    --     fmap f (Matter a) = Matter (f a)
            
                