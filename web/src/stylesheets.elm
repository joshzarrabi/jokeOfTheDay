port module Stylesheets exposing (main)

import Stylesheet
import Joke

{-|
-}
port files : Stylesheet.CssFileStructure -> Cmd msg


{-|
-}
main : Program Never () Never
main =
  let
    command =
      Joke.myStylesheet
        |> Stylesheet.toFileStructure "style.css"
        |> files

  in
    { init = ( (), command )
    , update = \_ _ -> ( (), Cmd.none )
    , subscriptions = \_ -> Sub.none
    }
      |> Platform.program
