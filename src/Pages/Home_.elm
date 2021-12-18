module Pages.Home_ exposing (page)

import Gen.Params.Home_ exposing (Params, parser)
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
            , p []
                [ text """
This year, I am not making an effort to create readable or easy to follow code,
but rather to focus on making my solutions efficient. I wont spend a lot of time
optimizing them if they are reasonably fast to start, but I will build from the
beginning with an eye toward avoiding duplicate passes through data structures or
inefficient access patterns.
"""
                ]
            , p []
                [ text """
I'm also not going to come back and tidy things up once I have a working solution,
I'll just move on to the next problem. As a result the code may be hard to read.
"""
                ]
            , p []
                [ text """
I've also started late, and put most of my time into getting this site up and
running, so... who knows how much will get done this year? \u{D83D}\u{DE05}
"""
                ]
            ]
        ]
    }
