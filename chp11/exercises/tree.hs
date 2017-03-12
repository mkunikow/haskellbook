module Tree where

data BinaryTree a =
    Leaf
    | Node (BinaryTree a) a (BinaryTree a)
    deriving (Eq, Ord, Show)

insert' :: Ord a => a -> BinaryTree a -> BinaryTree a
insert' b Leaf = Node Leaf b Leaf
insert' b (Node left a right)
    | b == a = Node left a right
    | b < a  = Node (insert' b left) a right
    | b > a  = Node left a (insert' b right)


-- filling in some details to help you along
-- Note, you do *not* need to use insert' for this.
-- Retain the original structure of the tree.

mapTree :: (a -> b) -> BinaryTree a -> BinaryTree b
mapTree _ Leaf = Leaf
mapTree f (Node left a right) =
    Node (mapTree f left) (f a) (mapTree f right)

testTree' :: BinaryTree Integer
testTree' =
    Node (Node Leaf 3 Leaf) 1 (Node Leaf 4 Leaf)

mapExpected =
    Node (Node Leaf 4 Leaf) 2 (Node Leaf 5 Leaf)

-- acceptance test for mapTree
mapOkay =
    if mapTree (+1) testTree' == mapExpected
    then print "yup okay!"
    else error "test failed!"


-- Write functions to convert BinaryTree values to lists. Make certain
-- your implementation passes the tests.

preorder :: BinaryTree a -> [a]

preorder Leaf  = []
preorder (Node left a right)  = 
    a : preorder left 
    ++ preorder right


inorder :: BinaryTree a -> [a]

inorder Leaf = []
inorder (Node left a right) = 
    inorder left
    ++ [a]
    ++ inorder right

postorder :: BinaryTree a -> [a]

postorder Leaf  = []
postorder (Node left a right)  = 
    postorder left 
    ++ postorder right 
    ++ [a] 

testTree :: BinaryTree Integer
testTree = Node (Node Leaf 1 Leaf) 2 (Node Leaf 3 Leaf)

testPreorder :: IO ()
testPreorder =
    if preorder testTree == [2, 1, 3]
    then putStrLn "Preorder fine!"
    else putStrLn "Bad news bears."

testInorder :: IO ()
testInorder =
    if inorder testTree == [1, 2, 3]
    then putStrLn "Inorder fine!"
    else putStrLn "Bad news bears."
testPostorder :: IO ()
testPostorder =
    if postorder testTree == [1, 3, 2]
    then putStrLn "Postorder fine!"
    else putStrLn "postorder failed check"

main :: IO ()
main = do
    testPreorder
    testInorder
    testPostorder


-- Write foldr for BinaryTree
-- any traversal order is fine
foldTree :: (a -> b -> b) -> b -> BinaryTree a -> b
foldTree _ z Leaf = z
foldTree f z (Node left a right) = f a (foldTree f (foldTree f z right) left)

testFoldTree :: IO ()
testFoldTree = 
    if foldTree (+) 0 testTree == 6 
    then putStrLn "foldTree fine!"
    else putStrLn "foldTree failed check"






