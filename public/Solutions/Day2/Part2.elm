module Solutions.Day2.Part2 exposing (answer)

import Solutions.Day2.Input exposing (Command(..), parseCommand)


type alias State =
    { aim : Int
    , horiz : Int
    , depth : Int
    }


answer : List String -> String
answer movements =
    movements
        |> List.foldl applyCmd2 (State 0 0 0)
        |> (\{ horiz, depth } -> horiz * depth)
        |> String.fromInt


applyCmd2 : String -> State -> State
applyCmd2 cmdStr state =
    case parseCommand cmdStr of
        Ok (Forward val) ->
            { state
                | horiz = state.horiz + val
                , depth = state.depth + (state.aim * val)
            }

        Ok (Down val) ->
            { state | aim = state.aim + val }

        Ok (Up val) ->
            { state | aim = state.aim - val }

        Err _ ->
            state
