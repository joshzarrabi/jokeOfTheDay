module MyProgram exposing (main)

import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href, src)
import Html.Styled.Events exposing (onClick)

import Http
import Array
import Browser

main : Program () Model Msg
main =
  Browser.element
  {
    init = init,
    update = update,
    subscriptions = subscriptions,
    view = view >> toUnstyled
  }

type alias Model =
  { jokeQuestion: String
  , jokeAnswer: String
  , showAnswer: Bool
  }

init : () -> (Model, Cmd Msg)
init _ =
  ( { jokeQuestion = "loading joke"
    , jokeAnswer = ""
    , showAnswer = False
    }
  , getJoke
  )

type Msg
  = GetJoke
  | JokeGotten (Result Http.Error String)
  | ShowAnswer
  | DoNothing

theme : { first: Color, second : Color, third : Color, fourth : Color, fifth : Color }
theme =
  { first = hex "#EAE7DC"
  , second = hex "#D8C3A5"
  , third = hex "8E8D8A"
  , fourth = hex "E98074"
  , fifth = hex "E85A4F"
  }

btn : List (Attribute msg) -> List (Html msg) -> Html msg
btn =
    styled button
        [ margin (px 30)
        , justifyAll (px 100)
        , display inlineBlock
        , color theme.first
        , backgroundColor theme.second
        , hover
            [ backgroundColor theme.third
            , color theme.fourth
            ]
        ]


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    GetJoke ->
      ( model, getJoke )

    JokeGotten (Ok joke) ->
      let
          jokeArray = Array.fromList <| String.split "|" joke

          jokeQuestion =
            case Array.get 0 jokeArray of
              Nothing ->
                ""
              Just q ->
                q

          jokeAnswer =
            case Array.get 1 jokeArray of
              Nothing ->
                ""
              Just a ->
                a
      in
          (
            { model |
              jokeQuestion = jokeQuestion
            , jokeAnswer = jokeAnswer
            , showAnswer = False
            }
            , Cmd.none
          )

    JokeGotten (Err _) ->
      (model, Cmd.none)

    ShowAnswer ->
      ( { model | showAnswer = True}, Cmd.none )

    DoNothing ->
      (model, Cmd.none)

view : Model -> Html Msg
view model =
  div []
    [
      btn
        [ if model.showAnswer then onClick DoNothing else onClick ShowAnswer ]
        [ if model.showAnswer then text "Hope you liked your joke of the day!!!" else text "Get Punchline"]
    , if model.showAnswer then text model.jokeAnswer else text model.jokeQuestion
    ]

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

getJoke : Cmd Msg
getJoke =
  Http.send JokeGotten ( Http.getString "/jokes")
