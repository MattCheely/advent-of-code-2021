module Pages.Home_ exposing (page)

import Gen.Params.Home_ exposing (Params)
import Html exposing (a, div, h1, p, text)
import Html.Attributes exposing (class, href)
import Page exposing (Page)
import Request
import Shared
import View exposing (View)


page : Shared.Model -> Request.With Params -> Page
page shared req =
    Page.static
        { view = view shared
        }


view : Shared.Model -> View Never
view shared =
    { title = "Advent of Code " ++ shared.year ++ " Solutions"
    , body =
        [ h1 [] [ text "Advent of Code: ", text shared.year ]
        , div [ class "eighty-col" ]
            [ p []
                [ text "These are solutions for the "
                , a [ href ("https://adventofcode.com/" ++ shared.year) ]
                    [ text shared.year, text " Advent of Code" ]
                , text " in Elm."
                ]
            ]
        ]
    }
