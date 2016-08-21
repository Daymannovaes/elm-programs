module Counter exposing (Model, Message, model, update, view)

import Html exposing (Html, button, div, text, input, span)
import Html.App as App
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (..)
import String

-- MODEL

type alias Model = Int

model: Model
model = 0

-- UPDATE

type Message = Increment | Decrement | Reset

update: Message -> Model -> Model

update message model =
    case message of
        Increment -> model + 1

        Decrement -> model - 1

        Reset -> 0

-- VIEW

view : Model -> Html Message
view model =
    div [] [
        button [onClick Decrement] [text "-"],
        span [] [text (toString model)],
        button [onClick Increment] [text "+"],
        button [onClick Reset] [text "Reset"]
    ]
