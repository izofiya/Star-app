-- https://ellie-app.com/5vTr4224PpWa1
port module Main exposing (..)

import Html exposing (Html, div, p, img, textarea, span, dl, dt, button, text, li, section, ul, header, h1, input, label)
import Html.Attributes as H exposing (..)
import Html.Events exposing (..)
import Browser
import String exposing (fromInt, toInt)
    
main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }

init : () -> ( Model, Cmd Msg )
init _ = 
  ( { entries = ["Reggie Dawson", "Drew Russell", "Tanner Holmes", "Brett George", "Taylor Fisher"]
      , classHidden = "hidden"
      , isActive = False
      , classHiddenInfo = "hiddenDivShowInfo" }
      , Cmd.none )
    
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
  
type Msg 
    = IsOpen
    | ShowInfo
    | HiddenShowInfo

type alias Model =
    { entries : List String
    , classHidden : String
    , isActive : Bool
    , classHiddenInfo : String
    }

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        IsOpen -> 
            ( { model | classHidden = "secondClassForDiv", classHiddenInfo = "hiddenDivShowInfo", isActive = not model.isActive }, Cmd.none)
        ShowInfo -> 
            ( { model | classHiddenInfo = "secondClassForDiv", classHidden = "hidden" }, Cmd.none)
        HiddenShowInfo ->
            ( { model | classHiddenInfo = "hiddenDivShowInfo", classHidden = "hidden"}, Cmd.none)

view : Model -> Html Msg  
view model = 
    div [ class "todoMVC-wrapper" ]
    [ section [ class "todoapp"]
        [ showHeader
        , showEntries model
        , showForm model
        , showInfo model
        ]
    ]

showHeader =
    header [ class "header" ] 
    [ h1 [] [ text "Guests"]
    ]
    
showEntries model =
    section [ class "main" ] 
        [ dl [ class "todo-list" ] ( List.map showEntry model.entries )
        ]
        
showEntry entry =
    dt [] 
        [ div [ class "view" ]
            [ label [] 
            [input [type_ "checkbox"] []
            , span [class "pseudocheckbox", onClick IsOpen] [text entry]]
            ]
        ]

showForm model =
    if model.isActive then
    div [ class model.classHidden ]
           [ label []
                [ text "NAME"
                , p [class "NamePForm"] [text "Mark Z"]
                , div [] 
                [ img [src "http://pngimg.com/uploads/star/star_PNG1592.png"] []
                , img [src "http://pngimg.com/uploads/star/star_PNG1592.png"] []
                , img [src "http://pngimg.com/uploads/star/star_PNG1592.png"] []
                , img [src "http://pngimg.com/uploads/star/star_PNG41451.png"] []
                , img [src "http://pngimg.com/uploads/star/star_PNG41451.png"] []]
                , text "PHONE"
                , input [type_ "text",  H.minlength 3, H.maxlength 11 ] []
                ]
            , label []
                [ text "COMMENT"
                , textarea [] []
                ]
            , button [ type_ "submit", class "buttonForm", onClick ShowInfo ] [ text "CANCEL" ]
            ]  
    else div [] []

showInfo model =
    div [class model.classHiddenInfo] 
        [ label []
                [ text "NAME"
                , span [class "spanDelete", onClick HiddenShowInfo] [ text "delete" ]
                , p [class "NamePForm"] [text "Mark Z"]
                , div [] 
                [ img [src "http://pngimg.com/uploads/star/star_PNG1592.png"] []
                , img [src "http://pngimg.com/uploads/star/star_PNG1592.png"] []
                , img [src "http://pngimg.com/uploads/star/star_PNG1592.png"] []
                , img [src "http://pngimg.com/uploads/star/star_PNG41451.png"] []
                , img [src "http://pngimg.com/uploads/star/star_PNG41451.png"] []]
                , text "PHONE"
                , p [] [text "+3652145562"]
                ]
            , label []
                [ text "COMMENT"
                , p [] [text "Good!"]
                ]
            ]  


