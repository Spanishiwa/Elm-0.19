module Main exposing (Model, Msg(..), init, main, render_reverse, update, view)

import Browser
import Html exposing (Attribute, Html, div, input, li, ol, p, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)



-- MAIN


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { content : String }


init : Model
init =
    { content = "" }



-- UPDATE


type Msg
    = Change String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newContent ->
            { model | content = newContent }



-- VIEW


view : Model -> Html Msg
view model =
    div
        [ style "font-size" "20px"
        , style "color" "red"
        , style "margin" "20px"
        , style "padding" "20px 10px"
        , style "border-bottom" "2px solid grey"
        , style "border-top" "2px solid grey"
        , style "border-left" "2px solid purple"
        , style "border-right" "2px solid purple"
        , style "background" "#9e9e9e"
        , style "border-radius" "2px"
        ]
        [ input
            [ placeholder "Text to reverse"
            , value model.content
            , onInput Change
            , style "margin" "auto"
            , style "margin-bottom" "20px"
            ]
            []
        , div
            [ style "padding" "0px 20px 0px 0px"
            , style "margin" "auto"
            , style "text-align" "center"
            , style "color" "brown"
            , style "text-decoration" "underline"
            ]
            [ text (render_reverse model.content) ]
        , div
            [ style "margin-top" "20px"
            , style "color" "green"
            , style "padding" "0px 20px"
            ]
            [ text "Hardcoded Text 20px Shifted Right" ]
        , div
            [ style "border" "3px dotted deeppink"
            , style "transition" "0.3s ease all"
            , style "border-radius" "2px"
            , style "margin" "auto"
            , style "margin-top" "20px"
            , style "padding" "10px"
            , style "background" "#cbcbcb"
            ]
            [ p
                [ style "margin" "auto"
                , style "color" "orange"
                , style "text-align" "center"
                , style "font-weight" "700"
                ]
                [ text "this guy is nested" ]
            ]
        , div
            [ style "background-color" "#355355"
            , style "border-radius" "2px"
            , style "padding" "10px 20px"
            , style "margin" "0px 20px 10px 40px"
            ]
            [ p
                [ style "color" "cyan"
                , style "font-family" "Times New Roman"
                , style "font-weight" "900"
                , style "text-align" "right"
                ]
                [ text "this guy is on the right" ]
            ]
        , div []
            [ div
                [ style "width" "0px"
                , style "height" "0px"
                , style "border-left" "20px solid transparent"
                , style "border-right" "20px solid transparent"
                , style "border-bottom" "20px solid #f00"
                , style "margin-left" "calc(20px + 0%)"
                ]
                []
            ]
        , div [ style "text-align" "center" ]
            [ ol
                [ style "color" "green"
                , style "font-size" "20px"
                , style "font-style" "italic"
                ]
                [ text "italicized ordered list header"
                , li
                    [ style "font-style" "normal"
                    , style "font-size" "16px"
                    , style "font-weight" "600"
                    ]
                    [ text "bolded, non-italicized, list item 1" ]
                , li
                    [ style "font-style" "normal"
                    , style "font-size" "16px"
                    , style "font-weight" "600"
                    , style "padding-left" "20px"
                    , style "text-indent" "-20px"
                    , style "width" "400px"
                    , style "margin" "auto"
                    ]
                    [ text "bolded, non-italicized, list item 2 with 20px padding and indent left" ]
                , li
                    [ style "font-style" "normal"
                    , style "font-size" "16px"
                    , style "font-weight" "600"
                    , style "font-family" "Comic-Sans MS"
                    ]
                    [ text "bolded, non-italicized, list item 3 COMIC-SANS family" ]
                ]
            ]
        , div
            [ style "color" "#666"
            , style "line-height" "1.5"
            , style "font-family" "Roboto"
            ]
            [ text "let's keep yolo Roboto Family" ]
        , div
            [ style "width" "0px"
            , style "height" "0px"
            , style "border-left" "20px solid transparent"
            , style "border-right" "20px solid transparent"
            , style "border-top" "20px solid purple"
            , style "color" "purple"
            , style "margin-left" "calc(50%)"
            ]
            []
        ]


render_reverse : String -> String
render_reverse userInput =
    case String.length userInput of
        0 ->
            "Type in the Input Box"

        _ ->
            "Your input reversed is: " ++ String.reverse userInput
