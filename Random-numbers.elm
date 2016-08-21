import Html exposing (Html, div, h1, button, text)
import Html.App as App
import Html.Events exposing (onClick)
import Random

main =
  App.program {
    init = init,
    update = update,
    view = view,
    subscriptions = subscriptions
  }


 -- MODEL

type alias Model = { face: Int }

init: (Model, Cmd Message)

init = (Model 1, Cmd.none)

 -- UPDATE

type Message = Roll | NewFace Int

update: Message -> Model -> (Model, Cmd Message)
update message model =
  case message of
    Roll ->
      (model, Random.generate NewFace (Random.int 1 6))

    NewFace newFace -> (Model newFace, Cmd.none)


 -- SUBSCRIPTIONS

subscriptions: Model -> Sub Message
subscriptions model =
  Sub.none

 -- VIEW

view: Model -> Html Message

view model =
  div [] [
    h1 [] [text (toString model.face)],
    button [onClick Roll] [text "Roll"]
  ]