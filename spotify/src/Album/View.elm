module Album.View exposing (root)

import Album.Types exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import View.Bootstrap exposing (..)


root : Model -> Html Msg
root model =
    panel
        [ text model.name
        , text " "
        , text (toString model.clickCount)
        ]
        [ div [ onClick Click ]
            [ case List.head model.images of
                Nothing ->
                    span [] [ text "" ]

                Just image ->
                    img [ class "img-responsive", src image ]
                        []
            ]
        ]
