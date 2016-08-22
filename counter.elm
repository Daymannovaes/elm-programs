module Counter exposing (Model, Message, model, update, view)

import Html exposing (..)
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
        button [buttonStyle, onClick Decrement] [text "-"],
        span [] [text (toString model)],
        button [buttonStyle, onClick Increment] [text "+"],
        button [buttonStyle, onClick Reset] [text "Reset"]
    ]

buttonStyle =
    style [
        ("font-size", "12pt"),
        ("color", "#222"),
        ("padding", "6px 12px"),
        ("margin", "6px")
    ]