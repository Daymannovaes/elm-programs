import Counter

import Html exposing (Html, button, div, text, input, span)
import Html.App as App
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (..)

main =
    App.beginnerProgram { model = model, view = view, update = update }

-- MODEL

type alias Model = {
  counters: List CounterModel,
  count: Int
}

type alias CounterModel = {
  model: Counter.Model,
  id: Int
}

model: Model
model = Model [] 0

-- UPDATE

type Message = Add | Delete Int | Proxy Int Counter.Message | Reset

update: Message -> Model -> Model

update message model =
  case message of
    Add ->
      { model |
        counters = [CounterModel 0 model.count] ++ model.counters,
        count = model.count + 1
      }
    Reset ->
      { model | counters = List.map resetCounter model.counters }

    Proxy id message ->
      { model | counters = List.map (updateCounters id message) model.counters }

    Delete id ->
      { model | counters = List.filter (deleteCounter id) model.counters }

deleteCounter: Int -> CounterModel -> Bool
deleteCounter id counter =
  counter.id /= id

updateCounters: Int -> Counter.Message -> CounterModel -> CounterModel
updateCounters id message counter =
  if counter.id == id then
    { counter | model = Counter.update message counter.model }
  else
    counter

resetCounter: CounterModel -> CounterModel
resetCounter counter =
  CounterModel 0 counter.id

-- VIEW

view : Model -> Html Message
view model =
  div [] [
    button [onClick Add] [text "Add"],
    button [onClick Reset] [text "Reset All"],
    div [] (List.map divCounter model.counters)
  ]

divCounter: CounterModel -> Html Message
divCounter counter =
  div [] [
    button [onClick (Delete counter.id)] [text "Delete"],
    App.map (Proxy counter.id) (Counter.view counter.model)
  ]