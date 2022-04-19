module Shared exposing
    ( Flags
    , Model
    , Msg(..)
    , init
    , randomSignIn
    , subscriptions
    , update
    )

import Gen.Route
import Json.Decode as Json
import Random
import Request exposing (Request)


type alias Flags =
    Json.Value


type alias Model =
    { user : Maybe () }


type Msg
    = SignIn
    | RandomSignIn Bool
    | SignOut


randomBool : Random.Generator Bool
randomBool =
    Random.map ((==) 1) (Random.int 0 1)


randomSignIn : Cmd Msg
randomSignIn =
    Random.generate RandomSignIn randomBool


init : Request -> Flags -> ( Model, Cmd Msg )
init req _ =
    ( { user = Nothing }
    , if req.route == Gen.Route.Home_ then
        randomSignIn

      else
        Cmd.none
    )


update : Request -> Msg -> Model -> ( Model, Cmd Msg )
update req msg model =
    case msg of
        SignIn ->
            ( model, randomSignIn )

        RandomSignIn isSucceeded ->
            if isSucceeded then
                ( { model | user = Just () }, Request.replaceRoute Gen.Route.Home_ req )

            else
                ( { model | user = Nothing }, Request.replaceRoute Gen.Route.NotFound req )

        SignOut ->
            ( { model | user = Nothing }, Request.replaceRoute Gen.Route.NotFound req )


subscriptions : Request -> Model -> Sub Msg
subscriptions _ _ =
    Sub.none
