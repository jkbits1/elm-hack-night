module App exposing (..)

import Html
import State
import Types exposing (..)
import View


main : Program Never Model Msg
main =
    Html.program
        { init = State.init
        , update = State.update
        , view = View.root
        , subscriptions = always Sub.none
        }
