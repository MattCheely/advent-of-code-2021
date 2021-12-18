module Advent exposing (TimedResult, getInput, getSolution, timeFn)

import Http exposing (expectString)
import Path
import Task
import Time exposing (posixToMillis)


type alias TimedResult a =
    { result : a
    , duration : Int
    }


timeFn :
    (TimedResult a -> msg)
    -> (() -> a)
    -> Cmd msg
timeFn msg fn =
    Time.now
        |> Task.map (\start -> ( start, fn () ))
        |> Task.andThen
            (\( start, res ) ->
                Time.now
                    |> Task.map
                        (\end ->
                            { result = res
                            , duration = posixToMillis end - posixToMillis start
                            }
                        )
            )
        |> Task.perform msg


getInput : (Result Http.Error String -> msg) -> Int -> Cmd msg
getInput msg day =
    Http.get
        { url = inputUrl day
        , expect = expectString (Result.map trimSolutionModule >> msg)
        }


getSolution : (Result Http.Error String -> msg) -> { day : Int, part : Int } -> Cmd msg
getSolution msg { day, part } =
    Http.get
        { url = solutionUrl { day = day, part = part }
        , expect = expectString (Result.map trimSolutionModule >> msg)
        }


inputUrl : Int -> String
inputUrl day =
    ("/Day" ++ String.fromInt day ++ "/Input.elm")
        |> Path.inApp


solutionUrl : { day : Int, part : Int } -> String
solutionUrl { day, part } =
    ("/Day" ++ String.fromInt day ++ "/Part" ++ String.fromInt part ++ ".elm")
        |> Path.inApp


trimSolutionModule : String -> String
trimSolutionModule code =
    code
        |> String.lines
        |> List.drop 1
        |> String.join "\n"
        |> String.trim
