module Shared exposing
    ( Flags
    , Model
    , Msg
    , init
    , subscriptions
    , update
    , view
    )

import Html exposing (Html, a, div, nav, span, text)
import Html.Attributes exposing (class, href)
import Path
import Request exposing (Request)
import View exposing (View)


year =
    "2021"


type alias Flags =
    Int


type alias Model =
    { year : String
    , implementedDays : List Int
    }


type Msg
    = NoOp


init : Request -> Flags -> ( Model, Cmd Msg )
init _ onDay =
    ( { year = year
      , implementedDays = List.range 1 onDay
      }
    , Cmd.none
    )


update : Request -> Msg -> Model -> ( Model, Cmd Msg )
update _ msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


subscriptions : Request -> Model -> Sub Msg
subscriptions _ _ =
    Sub.none


view : View msg -> Model -> View msg
view page model =
    { title = page.title
    , body =
        [ navView model.implementedDays
        , div [] page.body
        ]
    }


navView : List Int -> Html msg
navView days =
    let
        dayLinks =
            List.map dayLink days

        homeLink =
            a [ href (Path.inApp "/") ] [ text "Home" ]
    in
    nav []
        (homeLink
            :: dayLinks
            |> List.intersperse (span [ class "nav-divider" ] [])
        )


dayLink : Int -> Html msg
dayLink day =
    a [ href (Path.inApp ("/day" ++ String.fromInt day)) ] [ text "Day ", text (String.fromInt day) ]
