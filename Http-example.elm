import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Json
import Task

main =
  App.program {
    init = init,
    update = update,
    view = view,
    subscriptions = subscriptions
  }

-- MODEL

type alias Model = { topic: String, url: String, message: String }

init : (Model, Cmd Message)
init = (Model "cats" "waiting.gif" "", Cmd.none)

-- UPDATE

type Message = LoadGif | FetchSuccess String | FetchFail Http.Error

update : Message -> Model -> (Model, Cmd Message)
update message model =
  case message of
    LoadGif -> ({ model | message = "Loading" }, performGetRandomGif model.topic)

    FetchSuccess url -> (Model model.topic url "", Cmd.none)

    FetchFail _ -> (Model model.topic model.url errorMessage, Cmd.none)

performGetRandomGif: String -> Cmd Message
performGetRandomGif topic =
  Task.perform FetchFail FetchSuccess (Http.get gifDecoder (gifUrl topic))

gifUrl: String -> String
gifUrl topic = "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic

errorMessage: String
errorMessage = "Error fetching data"

gifDecoder: Json.Decoder String
gifDecoder =
  Json.at ["data", "image_url"] Json.string

-- SUBSCRIPTIONS

subscriptions: Model -> Sub Message
subscriptions model = Sub.none

-- VIEW

view : Model -> Html Message
view model =
  div [] [
    h2 [] [text model.topic],
    img [src model.url] [],
    button [onClick LoadGif] [text "Load More!"],
    span [] [text model.message]
  ]