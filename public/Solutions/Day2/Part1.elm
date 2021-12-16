module Solutions.Day2.Part1 exposing (answer)

import Solutions.Day2.Input exposing (Command(..), parseCommand)


answer : List String -> String
answer movements =
    movements
        |> List.foldl applyCmd ( 0, 0 )
        |> (\( x, y ) -> x * y)
        |> String.fromInt


applyCmd : String -> ( Int, Int ) -> ( Int, Int )
applyCmd moveStr ( x, y ) =
    case parseCommand moveStr of
        Ok (Forward delta) ->
            ( x + delta, y )

        Ok (Down delta) ->
            ( x, y + delta )

        Ok (Up delta) ->
            ( x, y - delta )

        Err err ->
            ( x, y )
