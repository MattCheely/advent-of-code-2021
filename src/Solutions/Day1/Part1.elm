module Solutions.Day1.Part1 exposing (answer)


answer : List Int -> String
answer data =
    countIncreases 0 data
        |> String.fromInt


countIncreases : Int -> List Int -> Int
countIncreases count data =
    case data of
        n1 :: n2 :: rest ->
            if n2 > n1 then
                countIncreases (count + 1) (n2 :: rest)

            else
                countIncreases count (n2 :: rest)

        _ ->
            count
