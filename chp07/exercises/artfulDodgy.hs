module  ArtfulDodgy where 

dodgy x y = x + y * 10
oneIsOne = dodgy 1
oneIsTwo = (flip dodgy) 2

-- dodgy 1 0 --> 1
-- dodgy 1 1 --> 11
-- dodgy 2 2 --> 22
-- dodgy 1 2 --> 21
-- dodgy 2 1 --> 12
-- oneIsOne 1 --> 11
-- oneIsOne 2 --> 21
-- oneIsTwo 1 --> 21
-- oneIsTwo 2 --> 22
-- oneIsOne 3 --> 31
-- oneIsTwo 3 --> 23



