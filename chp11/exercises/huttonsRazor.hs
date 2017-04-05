module HuttonsRazor where

data Expr
    = Lit Integer
    | Add Expr Expr

eval :: Expr -> Integer
eval (Lit i) = i
eval (Add e1 e2) = eval e1 + eval e2

printExpr :: Expr -> String
printExpr (Lit i) = show i
printExpr (Add e1 e2) = printExpr e1 ++ " + " ++ printExpr e2


testEval :: IO ()
testEval = 
    if eval (Add (Lit 1) (Lit 9001)) == 9002
    then putStrLn "eval fine!"
    else putStrLn "eval failed!"


testPrintExpr :: IO ()
testPrintExpr = 
    if printExpr (Add (Lit 1) (Lit 9001)) == "1 + 9001"
    then putStrLn "eval fine!"
    else putStrLn "eval failed!"


