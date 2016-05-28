# 1. For the following lines of code, read the syntax carefully and
decide if they are written correctly. Test them in your REPL
after you’ve decided to check your work. Correct as many as
you can.


a) concat [[1, 2, 3], [4, 5, 6]] -> OK
b) ++ [1, 2, 3] [4, 5, 6] -> (++) [1, 2, 3] [4, 5, 6]
c) (++) "hello" " world" -> OK
d) ["hello" ++ " world] -> OK
e) 4 !! "hello" -> "hello" !! 4
f) (!!) "hello" 4 -> OK
g) take "4 lovely" -> take 4 "lovely"
h) take 3 "awesome" -> OK

# 2. Next we have two sets: the first set is lines of code and the other
is a set of results. Read the code and figure out which results
came from which lines of code. Be sure to test them in the
REPL.

a) concat [[1 * 6], [2 * 6], [3 * 6]] -> d) [6,12,18]
b) "rain" ++ drop 2 "elbow" -> c) "rainbow"
c) 10 * head [1, 2, 3] -> e) 10
d) (take 3 "Julie") ++ (tail "yes") -> a) "Jules"
e) concat [tail [1, 2, 3], tail [4, 5, 6], tail [7, 8, 9]] -> b) [2,3,5,6,8,9]












