import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Http
import Array
import Browser

main =
  Browser.element
  {
    init = init,
    update = update,
    subscriptions = subscriptions,
    view = view
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
      button
        [ if model.showAnswer then onClick DoNothing else onClick ShowAnswer, class "myButton" ]
        [ if model.showAnswer then text "Hope you liked your joke of the day!!!" else text "Get Punchline"]
    , if model.showAnswer then text model.jokeAnswer else text model.jokeQuestion
    ]

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

getJoke : Cmd Msg
getJoke =
  Http.send JokeGotten ( Http.getString "/jokes")
