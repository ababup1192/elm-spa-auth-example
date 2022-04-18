module Shared exposing
    ( Flags
    , Model
    , Msg
    , init
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
    = RandomSignIn Bool


randomBool : Random.Generator Bool
randomBool =
    Random.map ((==) 1) (Random.int 0 1)


init : Request -> Flags -> ( Model, Cmd Msg )
init _ _ =
    ( { user = Nothing }, Random.generate RandomSignIn randomBool )


update : Request -> Msg -> Model -> ( Model, Cmd Msg )
update req msg model =
    case msg of
        RandomSignIn isSucceeded ->
            ( { model
                | user =
                    if isSucceeded then
                        Just ()

                    else
                        Nothing
              }
            , Request.pushRoute Gen.Route.Home_ req
            )


subscriptions : Request -> Model -> Sub Msg
subscriptions _ _ =
    Sub.none
