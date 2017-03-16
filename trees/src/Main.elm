module Main exposing (..)

import Html exposing (..)
import Tree exposing (..)
import TreeView


myTree =
    -- Tree.empty
    -- Node 1 Tree.empty Tree.empty
    Node 1 
        (Node 2 
            (Node 3 
                (Tree.empty) 
                (Node 4 Tree.empty Tree.empty)
            ) 
            (Node 5 Tree.empty Tree.empty) 
        )
        (Node 6 
            Tree.empty 
            (Node 7 Tree.empty Tree.empty)
        )

main : Html msg
main =
    let 
        _ = Debug.log "sum"         <| sum myTree
        _ = Debug.log "flatten"     <| flatten myTree
        _ = Debug.log "contains 5"  <| contains 5 myTree
        _ = Debug.log "contains 8"  <| contains 8 myTree
        _ = Debug.log "fold + 0"    <| fold (+) 0 myTree
        _ = Debug.log "fsum"        <| fsum myTree
        _ = Debug.log "fflatten"    <| fflatten myTree
        _ = Debug.log "fcontains 1" <| fcontains 1 myTree
        _ = Debug.log "fcontains 8" <| fcontains 8 myTree
        _ = Debug.log "fcontains [1..8]" <| 
                List.map (\e -> fcontains e myTree) <| List.range 1 8
    in
        TreeView.draw 800 myTree
