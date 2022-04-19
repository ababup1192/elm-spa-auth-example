module Pages.NotFound exposing (Model, Msg, page)

import Effect exposing (Effect)
import Gen.Params.NotFound exposing (Params)
import Html exposing (..)
import Html.Events exposing (onClick)
import Page
import Request
import Shared
import View exposing (View)


page : Shared.Model -> Request.With Params -> Page.With Model Msg
page _ _ =
    Page.advanced
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
    = SignIn


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        SignIn ->
            ( model, Effect.fromShared Shared.SignIn )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> View Msg
view model =
    { title = "サインイン失敗"
    , body =
        [ p [] [ text "サインイン失敗" ]
        , button [ onClick SignIn ] [ text "サインイン再チャレンジ" ]
        ]
    }
