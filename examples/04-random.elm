module Main exposing (Model, Msg(..), init, main, stringify, subscriptions, svgCirclesForDieFace, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (..)
import Random
import Svg exposing (..)
import Svg.Attributes exposing (cx, cy, fill, r, rx, ry, stroke, strokeWidth, style, viewBox, x, y)



-- MAIN


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


type alias Model =
    { dieFace : Int
    , dieSign : String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model 1 " is positive!"
    , Cmd.none
    )



-- UPDATE


type Msg
    = Roll
    | NewFace Int


stringify : Int -> String
stringify dieFace =
    case dieFace < 0 of
        True ->
            " is negative!"

        False ->
            " is positive!"


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model
            , Random.generate NewFace (Random.int 1 6)
            )

        NewFace newFace ->
            ( Model newFace (stringify newFace)
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ Html.text (String.fromInt model.dieFace) ]
        , button [ onClick Roll ] [ Html.text "Roll" ]
        , div [] [ Html.text ("\"" ++ String.fromInt model.dieFace ++ "\"" ++ model.dieSign) ]
        , svg
            [ Html.Attributes.width 120
            , Html.Attributes.height 120
            , Html.Attributes.style "margin-top" "40px"
            , viewBox "0 0 120 120"
            , fill "white"
            , stroke "black"
            , strokeWidth "3"
            ]
            (List.append
                [ rect [ x "1", y "1", Svg.Attributes.width "100", Svg.Attributes.height "100", rx "15", ry "15" ] [] ]
                (svgCirclesForDieFace model.dieFace)
            )
        ]


svgCirclesForDieFace : Int -> List (Svg Msg)
svgCirclesForDieFace dieFace =
    case dieFace of
        1 ->
            [ circle [ cx "50", cy "50", r "10", fill "grey" ] [] ]

        2 ->
            [ circle [ cx "25", cy "25", r "10", fill "red" ] []
            , circle [ cx "75", cy "75", r "10", fill "red" ] []
            ]

        3 ->
            [ circle [ cx "25", cy "25", r "10", fill "green" ] []
            , circle [ cx "50", cy "50", r "10", fill "green" ] []
            , circle [ cx "75", cy "75", r "10", fill "green" ] []
            ]

        4 ->
            [ circle [ cx "25", cy "25", r "10", fill "yellow" ] []
            , circle [ cx "75", cy "25", r "10", fill "yellow" ] []
            , circle [ cx "25", cy "75", r "10", fill "yellow" ] []
            , circle [ cx "75", cy "75", r "10", fill "yellow" ] []
            ]

        5 ->
            [ circle [ cx "25", cy "25", r "10", fill "cyan" ] []
            , circle [ cx "75", cy "25", r "10", fill "cyan" ] []
            , circle [ cx "25", cy "75", r "10", fill "cyan" ] []
            , circle [ cx "75", cy "75", r "10", fill "cyan" ] []
            , circle [ cx "50", cy "50", r "10", fill "cyan" ] []
            ]

        6 ->
            [ circle [ cx "25", cy "20", r "10", fill "orange" ] []
            , circle [ cx "25", cy "50", r "10", fill "orange" ] []
            , circle [ cx "25", cy "80", r "10", fill "orange" ] []
            , circle [ cx "75", cy "20", r "10", fill "orange" ] []
            , circle [ cx "75", cy "50", r "10", fill "orange" ] []
            , circle [ cx "75", cy "80", r "10", fill "orange" ] []
            ]

        _ ->
            [ circle [ cx "50", cy "50", r "50", fill "red", stroke "none" ] [] ]
