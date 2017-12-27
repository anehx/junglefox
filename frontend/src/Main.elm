module Main exposing (..)

import Html exposing (Html, text, div, input)
import Html.Events exposing (onInput)
import Html.Attributes exposing (class, placeholder)
import WebSocket


---- MODEL ----


type alias Model =
    { term : String }


init : ( Model, Cmd Msg )
init =
    ( { term = "" }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = Input String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Input term ->
            ( { model | term = term }, WebSocket.send "ws://echo.websocket.org" term )



---- VIEW ----


view : Model -> Html Msg
view model =
    div [ class "junglefox-search" ]
        [ input [ onInput Input, placeholder "Enter track name...", class "junglefox-search-input" ] []
        , div [ class "junglefox-search-result" ] [ text model.term ]
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
