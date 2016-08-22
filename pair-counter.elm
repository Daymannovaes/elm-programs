import Counter

import Html exposing (Html, button, div, text, input)
import Html.App as App
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (..)

main =
    App.beginnerProgram { model = model, view = view, update = update }

-- MODEL

type alias Model = {
  top: Int,
  bottom: Int
}

model: Model
model = Model 0 0

-- UPDATE

type Message = Reset | Top Counter.Message | Bottom Counter.Message

update: Message -> Model -> Model

update message model =
  case message of
    Top msg -> { model | top = Counter.update msg model.top }
    Bottom msg -> { model | bottom = Counter.update msg model.bottom }
    Reset -> Model 0 0

-- VIEW

view : Model -> Html Message
view model =
  div [] [
    App.map Top (Counter.view model.top),
    App.map Bottom (Counter.view model.bottom),
    button [onClick Reset] [text "Reset All"]
  ]
