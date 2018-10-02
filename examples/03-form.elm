module Main exposing
    ( Model
    , Msg(..)
    , init
    , main
    , update
    , validatePasswordIsNotEmpty
    , validatePasswordMinimumLength
    , validatePasswordsIdentical
    , view
    , viewInput
    , viewValidation
    )

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Parser exposing (..)
import String exposing (append, concat, isEmpty, join, length)



-- MAIN


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL "the state of your application"


type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    , validationMessages : List String

    -- , validationColor : String
    }



-- validationErrors =
--     { passwordsIdentical = "Password and re-entered password must be identical!"
--     , passwordMinimumLength = "Password must be at least 8 characters in length"
--     , passwordIsNotEmpty = "Please enter a password"
--     , passwordContainsNumber = "Password must contain at least one number (0-9)"
--     , passwordContainsUpperCase = "Password must contain at least one capitalized letter"
--     , passwordContainsLowerCase = "Password must contain at least one uncapitalized letter"
--     , ageIsEmpty = "Please enter an age"
--     }
--
-- type alias Numerical =
--     { password : String }
--
--
-- numerical : Parser Numerical
-- numerical =
--     succeed Numerical
--         |. symbol
--


init : Model
init =
    Model "" "" "" [ "" ]



-- UPDATE "the way to update the model ("the state of your application")"


type Msg
    = Name String
    | Password String
    | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        Password password ->
            { model | password = password }

        PasswordAgain password ->
            { model | passwordAgain = password }



-- Password validations
-- validatePassword : Model -> Model
-- validatePassword model =
--   validatePasswordsIdentical model;
--   validatePasswordIsNotEmpty model;
--   validatePasswordMinimumLength model;
-- validatePasswordContainsNumber : Model -> Model
-- validatePasswordContainsNumber model =
-- VIEW "the way to view your model ("the state of your application") as HTML"


view : Model -> Html Msg
view model =
    div []
        [ viewInput "text" "Name" model.name Name
        , viewInput "password" "Password" model.password Password
        , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain

        -- , div [ style "color" model.validationColor ] [ text model.validationMessage ]
        , viewValidation model

        -- , validatePasswordIdentical model
        -- , validatePasswordLength model
        ]


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
    input [ type_ t, placeholder p, value v, onInput toMsg ] []



-- Password Validation


validatePassword : String -> String -> List ( Bool, String )
validatePassword password passwordAgain =
    List.map
        [ validatePasswordsIdentical password passwordAgain
        , validatePasswordIsNotEmpty password passwordAgain
        , validatePasswordMinimumLength password
        ]


validatePasswordsIdentical : String -> String -> ( Bool, String )
validatePasswordsIdentical password passwordAgain =
    if password /= passwordAgain then
        -- { model | validationMessages = [ "Password and re-entered password are identical!" ] }
        ( False, "Password and re-entered password are not identical!" )

    else
        ( True, "" )


validatePasswordIsNotEmpty : String -> String -> ( Bool, String )
validatePasswordIsNotEmpty password passwordAgain =
    if isEmpty password && isEmpty passwordAgain then
        ( False, "Please enter a password" )

    else
        -- { model | validationMessages = [ "You have entered a password" ] }
        ( True, "" )


validatePasswordMinimumLength : String -> ( Bool, String )
validatePasswordMinimumLength password =
    if length password < 8 then
        ( False, "Password must be at least 8 characters in length" )

    else
        -- { model | validationMessages = [ "Password is at least 8 characters in length" ] }
        ( True, "" )


viewValidation : Model -> Html msg
viewValidation model =
    -- boolean for case seems unnecessary, but case is elm-like
    case model.password == model.passwordAgain of
        True ->
            -- { model | validationMessage = "Password and re-entered password are identical!" }
            div [ style "color" "green" ] [ text (join " " model.validationMessages) ]

        False ->
            -- { model | validationMessage = "Password and re-entered password are not identical!" }
            div [ style "color" "red" ] [ text (join " " model.validationMessages) ]



-- div [ style "color" "red" ] [ text "Passwords do not match!" ]
--
-- viewValidation : Model -> Html msg
-- viewValidation model =
--     -- boolean for case seems unnecessary, but case is elm-like
--     div [ style "color" model.validationColor ] [ text model.validationMessage ]
--
--
-- validatePasswordIdentical : Model -> Html msg
-- validatePasswordIdentical model =
--     if model.password == model.passwordAgain then
--         -- div
--         --     [ style "color" "green"
--         --     , style "margin" "20px 0px"
--         --     ]
--         -- "OK - Passwords Match!"
--         -- [ text model.validationMessage ]
--         { model | validationMessage = concat "Password and re-entered password are identical!" }
--         -- model.validationMessage = concat [ model.validationMessage, "Password and re-entered password are identical!" ]
--
--     else
--         -- div
--         --     [ style "color" "red"
--         --     , style "margin-bottom" "20px"
--         --     ]
--         -- [ text "NOT OK - Passwords do not match!" ]
--         -- [ text model.validationMessage ]
--         { model | validationMessage = concat "Password and re-entered password are not identical!" }
--
--
-- validatePasswordLength : Model -> Html msg
-- validatePasswordLength model =
--     if String.length model.password > 7 && String.length model.passwordAgain > 7 then
--         div
--             [ style "color" "green"
--             , style "margin-bottom" "20px"
--             ]
--             -- "OK - Password Length is at least 8 characters in length"
--             [ text model.validationMessage ]
--
--     else
--         div
--             [ style "color" "red"
--             , style "margin-bottom" "20px"
--             ]
--             -- "NOT OK - Password must be at least 8 characters in length"
--             [ text model.validationMessage ]
--
-- validatePasswordContents : Model -> Html Msg
-- validatePasswordContents model =
--     if contains (regex "1234567890") model.password then
--         div
--             [ style "color" "green"
--             , style "margin-bottom" "20px"
--             ]
--             [ text "OK - Password contains numbers" ]
--
--     else
--         div
--             [ style "color" "red"
--             , style "margin-bottom" "20px"
--             ]
--             [ text "NOT OK - Password must contain at least one number (0-9)" ]
