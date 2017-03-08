module View exposing (root)

import Album.Types as Album
import Album.View as Album
import Array exposing (Array)
import Dialog
import Exts.Maybe as Maybe
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)
import View.Bootstrap exposing (..)


root : Model -> Html Msg
root model =
    div []
        [ bootstrap
        , container
            [ Html.form [ onSubmit Query ]
                [ inputForm model ]
            , case model.results of
                Nothing ->
                    p [] [ text "Type a query." ]

                Just (Err err) ->
                    div [ class "alert alert-danger" ] [ text (toString err) ]

                Just (Ok albums) ->
                    albumsList albums
            ]
        , case model.results of
            Just (Ok albums) ->
                Dialog.view (showDialog albums)

            _ ->
                span [] []
        ]


inputForm : Model -> Html Msg
inputForm model =
    input
        [ type_ "text"
        , placeholder "Search for an album..."
        , value model.query
        , onInput QueryChange
        ]
        []


albumsList : Array Album.Model -> Html Msg
albumsList albums =
    let
        toTile index album =
            div [ class "col-xs-2 col-md-3" ]
                [ Album.root album
                    |> Html.map (AlbumMsg index)
                ]
    in
        row
            (albums
                |> Array.indexedMap toTile
                |> Array.toList
            )


showDialog : Array Album.Model -> Maybe (Dialog.Config Msg)
showDialog albums =
    let
        albumDialog : Int -> Album.Model -> Maybe (Dialog.Config Msg)
        albumDialog index album =
            Album.showDialog album
                |> Dialog.mapMaybe (AlbumMsg index)
    in
        albums
            |> Array.indexedMap albumDialog
            |> Array.toList
            |> Maybe.oneOf
