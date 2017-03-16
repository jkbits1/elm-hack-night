module Tree exposing (..)

type Tree a
    = Empty
    | Node a (Tree a) (Tree a)


empty : Tree a
empty =
    Empty

sum t =
    case t of
      Empty -> 0        
      Node x Empty Empty -> x
      Node x l r -> x + sum l + sum r

flatten t =
    case t of
      Empty -> []
      Node x Empty Empty -> [x]
      Node x l r -> [x] ++ flatten l ++ flatten r

contains e t =
    case t of 
      Empty -> False
      Node x Empty Empty -> e == x
      Node x l r ->
        if e == x
        then True
        else
            contains e l || contains e r

-- based on foldr example here:
-- https://hackage.haskell.org/package/base-4.9.1.0/docs/Data-Foldable.html
-- 
-- basic list foldr here:
-- https://wiki.haskell.org/Fold
-- foldr f z []     = z 
-- foldr f z (x:xs) = f x (foldr f z xs) 
fold f z t =
    case t of
        Empty -> z
        Node x Empty Empty -> f x z
        Node x l r -> fold f (f x (fold f z r)) l

-- point-free style
fsum = fold (+) 0       
fflatten = fold (::) []
fcontains e = fold (\a b -> b || (a == e) ) False

-- singleton : a -> Tree a
-- insert : comparable -> Tree comparable -> Tree comparable
-- fromList : List comparable -> Tree comparable
-- depth : Tree a -> Int
-- map : (a -> b) -> Tree a -> Tree b
{-----------------------------------------------------------------

Exercises:

(1) Sum all of the elements of a tree.

       sum : Tree number -> number

(2) Flatten a tree into a list.

       flatten : Tree a -> List a

(3) Check to see if an element is in a given tree.

       contains : a -> Tree a -> Bool

(4) Write a general fold function that acts on trees. The fold
    function does not need to guarantee a particular order of
    traversal.

       fold : (a -> b -> b) -> b -> Tree a -> b

(5) Use "fold" to do exercises 1-3 in one line each. The best
    readable versions I have come up have the following length
    in characters including spaces and function name:
      sum: 16
      flatten: 21
      contains: 45
    See if you can match or beat me! Don't forget about currying
    and partial application!

(6) Can "fold" be used to implement "map" or "depth"?

(7) Try experimenting with different ways to traverse a
    tree: pre-order, in-order, post-order, depth-first, etc.
    More info at: http://en.wikipedia.org/wiki/Tree_traversal

-----------------------------------------------------------------}
