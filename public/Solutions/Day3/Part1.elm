module Solutions.Day3.Part1 exposing (answer)

import Bitwise
import Solutions.Day3.Input exposing (toNums)


answer : List String -> String
answer input =
    List.foldl countBits (List.repeat 12 0) input
        |> toBinary (List.length input)
        |> bitsToInt
        |> (\gamma -> gamma * epsilonFromGamma gamma)
        |> String.fromInt


countBits : String -> List Int -> List Int
countBits str counted =
    List.map2 (+) (toNums str) counted


toBinary : Int -> List Int -> List Int
toBinary length counts =
    List.map
        (\count ->
            if toFloat count > (toFloat length / 2) then
                1

            else
                0
        )
        counts


bitsToInt : List Int -> Int
bitsToInt bits =
    bits
        |> List.foldr
            (\bit ( pos, total ) ->
                if bit == 0 then
                    ( pos + 1, total )

                else
                    ( pos + 1, total + 2 ^ pos )
            )
            ( 0, 0 )
        |> Tuple.second


epsilonFromGamma : Int -> Int
epsilonFromGamma gamma =
    Bitwise.complement gamma
        |> Bitwise.and 4095
