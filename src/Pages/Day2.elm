module Pages.Day2 exposing (Model, Msg, page)

import Advent exposing (TimedResult, getInput, getSolution)
import Gen.Params.Day01 exposing (Params)
import Html exposing (Html, a, button, code, div, h1, h2, p, pre, span, text)
import Html.Attributes exposing (class, href, target)
import Html.Events exposing (onClick)
import Http
import Page
import Request
import Shared
import Solutions.Day2.Input as Input
import Solutions.Day2.Part1 as Part1
import Solutions.Day2.Part2 as Part2
import SyntaxHighlight as Highlight
import View exposing (View)


page : Shared.Model -> Request.With Params -> Page.With Model Msg
page shared req =
    Page.element
        { init = init
        , update = update
        , view = view shared
        , subscriptions = subscriptions
        }



-- INIT


day =
    2


type alias Model =
    { part1Code : Maybe String
    , part1Result : Maybe (TimedResult String)
    , part2Code : Maybe String
    , part2Result : Maybe (TimedResult String)
    , inputCode : Maybe String
    }


init : ( Model, Cmd Msg )
init =
    ( { part1Code = Nothing
      , part1Result = Nothing
      , part2Code = Nothing
      , part2Result = Nothing
      , inputCode = Nothing
      }
    , Cmd.batch
        [ getSolution GotPart1 { day = day, part = 1 }
        , getSolution GotPart2 { day = day, part = 2 }
        , getInput GotInput day
        ]
    )



-- UPDATE


type Msg
    = GotPart1 (Result Http.Error String)
    | GotPart2 (Result Http.Error String)
    | GotInput (Result Http.Error String)
    | RunPart1
    | Part1Result (TimedResult String)
    | RunPart2
    | Part2Result (TimedResult String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotPart1 result ->
            ( { model | part1Code = Result.toMaybe result }, Cmd.none )

        GotPart2 result ->
            ( { model | part2Code = Result.toMaybe result }, Cmd.none )

        GotInput result ->
            ( { model | inputCode = Result.toMaybe result }, Cmd.none )

        RunPart1 ->
            ( model, Advent.timeFn Part1Result (\_ -> Part1.answer Input.input) )

        Part1Result result ->
            ( { model | part1Result = Just result }, Cmd.none )

        RunPart2 ->
            ( model, Advent.timeFn Part2Result (\_ -> Part2.answer Input.input) )

        Part2Result result ->
            ( { model | part2Result = Just result }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Shared.Model -> Model -> View Msg
view sharedModel model =
    let
        title =
            "Day " ++ String.fromInt day

        problemUrl =
            String.join "/" [ "https://adventofcode.com", sharedModel.year, "day", String.fromInt day ]
    in
    { title = title
    , body =
        [ h1 [] [ text title ]
        , a [ href problemUrl, target "_blank" ] [ text "The Problems" ]
        , div []
            [ h2 [ class "section-heading" ] [ text "Part One" ]
            , runView model.part1Result RunPart1
            , codeView model.part1Code
            ]
        , div []
            [ h2 [ class "section-heading" ] [ text "Part Two" ]
            , runView model.part2Result RunPart2
            , codeView model.part2Code
            ]
        , div []
            [ h2 [ class "section-heading" ] [ text "Input & Parsing" ]
            , codeView model.inputCode
            ]
        ]
    }


runView : Maybe (TimedResult String) -> Msg -> Html Msg
runView result msg =
    p []
        [ case result of
            Nothing ->
                button [ onClick msg ] [ text "Run" ]

            Just solution ->
                span []
                    [ text solution.result
                    , span [ class "demphasis" ]
                        [ text " ("
                        , text (String.fromInt solution.duration)
                        , text "ms)"
                        ]
                    ]
        ]


codeView : Maybe String -> Html Msg
codeView maybeCode =
    case maybeCode of
        Nothing ->
            text "No Solution Found"

        Just codeStr ->
            div []
                [ Highlight.useTheme Highlight.oneDark
                , Highlight.elm codeStr
                    |> Result.map (Highlight.toBlockHtml Nothing)
                    |> Result.withDefault (code [] [ text codeStr ])
                ]
