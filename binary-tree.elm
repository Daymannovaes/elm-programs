module BTree exposing (Model)

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import String

main =
  App.beginnerProgram({ model = model, update = update, view = view })

-- MODEL

type Tree = Empty | Leaf Int | Node Int Tree Tree

type alias Model = { number: Int, tree: Tree }

model = Model 0 Empty

-- UPDATE

type Message = Add | SetNumber String

update message model =
  case message of
    Add -> { model | tree = insert model.number model.tree }
    SetNumber number -> insertNumber number model

insertNumber number model =
  case String.toInt number of
    Ok n -> { model | number = n }
    Err msg -> model

insert: Int -> Tree -> Tree

insert n tree =
  case tree of
    Empty ->
      Leaf n
    Leaf t ->
      if (n >= t) then
        Node t Empty (Leaf n)
      else
        Node t (Leaf n) Empty
    Node t left right ->
      if (n >= t) then
        Node t left (insert n right)
      else
        Node t (insert n left) right

-- VIEW
view model =
  div [] [
    input [onInput SetNumber] [],
    button [onClick Add] [text "Add Number"],
    printTree model.tree
  ]

printTree: Tree -> Html Message

printTree tree =
  case tree of
    Empty -> th [style leafStyle] []
    Leaf t -> th [style leafStyle] [text (toString t)]
    Node t left right ->
      table [style nodeStyle] [
        tr [] [
          th [colspan 2, style leafStyle] [text (toString t)]
        ],
        tr [] [
          printTree left,
          printTree right
        ]
      ]

border color =
  [("border", "1px solid " ++ color)]

nodeStyle =
  [("display", "inline-block")] ++ border "black"
leafStyle =
  [("min-width", "10px")] ++ border "red"