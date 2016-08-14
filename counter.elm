import Html exposing (Html, button, div, text, input)
import Html.App as App
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (..)
import String

main =
    App.beginnerProgram { model = model, view = view, update = update }

-- MODEL

type alias Model =
    { number: Int, inc: Int, incString: String }

model: Model
model = Model 0 1 "1"

-- UPDATE

type Message = Increment | Decrement | Reset | Inc String

update: Message -> Model -> Model

update message model =
    case message of
        Increment -> { model | number = model.number + model.inc }

        Decrement -> { model | number = model.number - model.inc }

        Reset -> { model | number = 0 }

        Inc input -> defineInc input model

defineInc: String -> Model -> Model
defineInc input model =
    case String.toInt input of
        Ok inc -> { model | incString = input, inc = inc }
        Err msg -> { model | incString = input }

inputToInt: Model -> Int
inputToInt model =
    case String.toInt model.incString of
        Ok int -> int
        Err msg -> model.inc

-- VIEW

view : Model -> Html Message
view model =
    div [] [
        button [onClick Decrement] [text "-"],
        input [onInput Inc, value (toString (inputToInt model))] [],
        div [] [text ("number " ++ (toString model.number))],
        button [onClick Increment] [text "+"],
        button [onClick Reset] [text "Reset"]
    ]
