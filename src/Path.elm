module Path exposing (inApp, normalizeUrl)

import BuildConfig exposing (basePath)
import Url exposing (Url)


{-| Convert a path relative to the root of the app to a path based on our
deploy location. This is useful for generating links and navigation commands.
-}
inApp : String -> String
inApp path =
    deployPath ++ path


{-| Given a Url with a full path, trim the deployPath from the front of it. If
we do this before handing the Url to elm-spa for routing, everything should work
nicely.
-}
normalizeUrl : Url -> Url
normalizeUrl url =
    let
        newPath =
            if String.startsWith deployPath url.path then
                String.dropLeft (String.length deployPath) url.path

            else
                url.path
    in
    { url | path = newPath }


deployPath : String
deployPath =
    if String.endsWith "/" basePath then
        String.dropRight 1 basePath

    else
        basePath
