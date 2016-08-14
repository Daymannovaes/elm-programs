import Html exposing (Html, input, div, text)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import String

main =
  App.beginnerProgram { model = model, update = update, view = view }

-- MODEL

type alias Model = { content: String, isPalindrome: Bool }

model: Model

model = Model "" False

-- UPDATE

type Message = Change String

update: Message -> Model -> Model

update message model =
  case message of
    Change newContent -> { model | content = newContent, isPalindrome = isPalindrome newContent }

isPalindrome: String -> Bool
isPalindrome word = String.reverse word == word

-- VIEW

view: Model -> Html Message

view model =
  div [] [
    input [ placeholder "Text to reverse", onInput Change ] [],
    div [] [
      text (String.reverse model.content)
    ],
    div [] [
      text (
        if model.content == "" then
          ""
        else if model.isPalindrome then
          "It's a palindome!! :)"
        else
          "Not a palindrome. :("
      )
    ]
  ]