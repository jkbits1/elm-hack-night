module Rest exposing (..)

import Album.Rest as Album
import Album.Types as Album
import Array exposing (Array)
import Exts.Http exposing (cgiParameters)
import Http exposing (Error)
import Json.Decode exposing (..)
import Types exposing (..)


search : String -> Cmd Msg
search query =
    Http.get (searchUrl query) decodeAlbums
        |> Http.send SpotifyResponse


searchUrl : String -> String
searchUrl query =
    "https://api.spotify.com/v1/search?"
        ++ (cgiParameters
                [ ( "q", query )
                , ( "type", "album" )
                , ( "market", "GB" )
                , ( "limit", "50" )
                ]
           )


decodeAlbums : Decoder (Array Album.Model)
decodeAlbums =
    at [ "albums", "items" ] (array Album.decodeAlbum)
