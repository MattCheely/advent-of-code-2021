module Solutions.Day3.Part2 exposing (answer)


answer : List String -> String
answer input =
    (findO2Rating input [] * findCO2Rating input [])
        |> String.fromInt


findO2Rating : List String -> List Bool -> Int
findO2Rating values bitsSoFar =
    case values of
        [ uncollectedStr ] ->
            bitsSoFar
                |> bitsToInt uncollectedStr

        _ ->
            let
                ( ones, zeros ) =
                    partition values
            in
            if List.length ones >= List.length zeros then
                findO2Rating ones (True :: bitsSoFar)

            else
                findO2Rating zeros (False :: bitsSoFar)


findCO2Rating : List String -> List Bool -> Int
findCO2Rating values bitsSoFar =
    case values of
        [ uncollectedStr ] ->
            bitsSoFar
                |> bitsToInt uncollectedStr

        _ ->
            let
                ( ones, zeros ) =
                    partition values
            in
            if List.length zeros <= List.length ones then
                findCO2Rating zeros (False :: bitsSoFar)

            else
                findCO2Rating ones (True :: bitsSoFar)


partition : List String -> ( List String, List String )
partition values =
    partitionRecur values ( [], [] )


partitionRecur : List String -> ( List String, List String ) -> ( List String, List String )
partitionRecur values ( ones, zeros ) =
    case values of
        [] ->
            ( ones, zeros )

        next :: rest ->
            case String.uncons next of
                Just ( '1', strRest ) ->
                    partitionRecur rest ( strRest :: ones, zeros )

                Just ( _, strRest ) ->
                    partitionRecur rest ( ones, strRest :: zeros )

                Nothing ->
                    partitionRecur rest ( ones, zeros )


bitsToInt : String -> List Bool -> Int
bitsToInt unCollectedStr bits =
    let
        ( nextPos, stringTotal ) =
            unCollectedStr
                |> String.foldr
                    (\char ( pos, total ) ->
                        if char == '1' then
                            ( pos + 1, total + 2 ^ pos )

                        else
                            ( pos + 1, total )
                    )
                    ( 0, 0 )
    in
    bits
        |> List.foldl
            (\bit ( pos, total ) ->
                if bit then
                    ( pos + 1, total + 2 ^ pos )

                else
                    ( pos + 1, total )
            )
            ( nextPos, stringTotal )
        |> Tuple.second
