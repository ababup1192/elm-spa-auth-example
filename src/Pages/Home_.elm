module Pages.Home_ exposing (Model, Msg, page)

import Effect exposing (Effect)
import Gen.Params.Home_ exposing (Params)
import Html exposing (..)
import Html.Events exposing (onClick)
import Page
import Request
import Shared
import View exposing (View)


page : Shared.Model -> Request.With Params -> Page.With Model Msg
page _ _ =
    Page.protected.advanced <|
        \user ->
            { init = init
            , update = update
            , view = view
            , subscriptions = subscriptions
            }



-- INIT


type alias Model =
    {}


init : ( Model, Effect Msg )
init =
    ( {}, Effect.none )



-- UPDATE


type Msg
    = SignOut


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        SignOut ->
            ( model, Effect.fromShared Shared.SignOut )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> View Msg
view model =
    { title = "サインイン"
    , body =
        [ p [] [ text "サインイン中" ]
        , button [ onClick SignOut ] [ text "サインアウト" ]
        ]
    }
