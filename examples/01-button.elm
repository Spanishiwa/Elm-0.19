module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Html, br, button, div, text)
import Html.Events exposing (onClick)


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    Float


init : Model
init =
    0



-- increment :
-- UPDATE


type Msg
    = Increment
    | IncrementBySix
    | Decrement
    | Double
    | Halve
    | Reset
    | Remainder


flip : (a -> b -> c) -> (b -> a -> c)
flip f b a =
    f a b


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            model + 1

        IncrementBySix ->
            model + 6

        Decrement ->
            model - 1

        Double ->
            model * 2

        Halve ->
            model / 2

        Reset ->
            0

        Remainder ->
            toFloat (round (model * 1000)) / 1000.0



-- model * 1000 |> round |> toFloat |> flip (/) 1000
-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "Decrement BY ONE" ]
        , button [ onClick Reset ] [ text "Reset TO ZERO" ]
        , div [] [ text (String.fromFloat model) ]
        , button [ onClick Increment ] [ text "Increment BY ONE" ]
        , button [ onClick IncrementBySix ] [ text "Increment BY SIX" ]
        , br [] []
        , button [ onClick Double ] [ text "Double" ]
        , button [ onClick Remainder ] [ text "Round to THREE DECIMAL PLACES" ]
        , br [] []
        , button [ onClick Halve ] [ text "Halve" ]
        , div [] [ text ("yessum " ++ String.fromFloat model ++ " yep") ]
        ]
