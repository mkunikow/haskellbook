module BinaryTree where

data BinaryTree a =
    Leaf
  | Node (BinaryTree a) a (BinaryTree a)
  deriving (Eq, Ord, Show)


unfold :: (a -> Maybe (a,b,a)) -> a -> BinaryTree b
unfold f a' = case f a' of
                Nothing -> Leaf
                Just (l , m , r) -> Node (unfold f l) m (unfold f r)

treeBuild :: Integer -> BinaryTree Integer
treeBuild n = unfold (\i -> if i == n then Nothing else Just (i + 1, i, i+1)) 0