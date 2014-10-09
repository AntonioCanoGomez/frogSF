import QtQuick 2.0
import QtQuick.Particles 2.0
import "content"
import "content/logic.js" as Logic

Row{
    id:mainbar
    width: frogz.width
    height: frogz.height
    property    bool gameRunning: false
    property var gameState: Logic.newGameState(mainbar);
    property Row mainbar: mainbar
    property Image frogzgame: frogzgame
    property var ranas
    property var piedras
    property int maxRanas:50
    property int maxPiedras:50

    Image {
        id:frogz
        height:frogzgame.height
        width:frogzgame.width
        source:"content/frogzH.png"
        MouseArea {
            anchors.fill: frogz
            onClicked: {
                mainbar.state = "stateMiddleScreen"
            }
        }
    }
    Image {
        id:frogzgray
        height:frogzgame.height
        width:frogzgame.width

        source:"content/frogzgrayH.png"
//        anchors.left: frogzStateChangeScript {
        Image {
            id:play
            x:(8*frogz.width)/20
            y:(10*frogz.height)/20
            width: (4*frogz.width)/20
            height: (2*frogz.height)/20
            source:"content/play.png"
            MouseArea {
                anchors.fill: play
                onClicked: {
                    mainbar.state = "stateGameBegins"
                }
            }
        }

        Image {
            id:flecha
            x:(1*frogz.width)/40
            y:(1*frogz.height)/40
            width: (3*frogz.width)/20
            height: (2*frogz.height)/20

            source:"content/flecha.png"
            MouseArea {
                anchors.fill: flecha
                onClicked: {
                    mainbar.state = ""
                }
            }
        }
    }




    Image {
        id:frogzgame
        width:550
        height:975


        source:"content/lago2.jpg"
        property Image piedra: piedra

        Image {
            id:flecha2
            x:(1*frogz.width)/40
            y:(1*frogz.height)/40
            width: (3*frogz.width)/20
            height: (2*frogz.height)/20

            source:"content/flecha.png"
            MouseArea {
                anchors.fill: flecha2
                onClicked: {
                    mainbar.state = "stateMiddleScreen"
                }
            }
        }


        Image {
            id:piedra
            x:(20*frogz.width)/40
            y:26*gameState.frogzgame.height/40
            width: (4*frogz.width)/30
            height: (4*frogz.height)/30
            source:"content/stone.png"
            property real fuerzalanzamiento:-1
            transform: Rotation {
              angle: 45
            }

            MouseArea {
                id:mouseareapiedra
                hoverEnabled: true
                drag.target: piedra
                anchors.fill: piedra
                drag.minimumX : 2*gameState.frogzgame.width/20
                drag.maximumX : 19*gameState.frogzgame.width/20
                drag.minimumY : 26*gameState.frogzgame.height/40
                drag.maximumY : 35*gameState.frogzgame.height/40

                onPressed: {
                    piedra.state="apuntando"
                }

                onReleased:{
                    piedra.state="lanzando"
                }
            }
            states: [
                State {
                    name: "";
                },
                State {
                    name: "apuntando";
                    StateChangeScript { script : {
                        }
                    }
                },
                State {
                    name: "lanzando";
                    StateChangeScript { script : {
                        }
                    }
                }
            ]
        }
    }



        SoundEffect {
            id: frogzsound
            source: "content/frogz.wav"
        }

        SoundEffect {
            id: gamesound
            source: "content/game.wav"
        }



        Timer {
            interval: 1
            running: true
            onTriggered: frogzsound.play()
        }


        Timer {
            interval: 16
            running: true
            repeat: true
            onTriggered: Logic.tick()
        }


    states: [
        State {
            name: ""; // when: gameState.gameOver == false && passedSplash
            PropertyChanges { target: mainbar; x: 0 }
            StateChangeScript { script : {
                        gamesound.stop()
                        frogzsound.play()
                    }
                }
//            PropertyChanges { target: gameStarter; running: true }
        },
        State {
            name: "stateMiddleScreen"; // when: gameState.gameOver == true
            PropertyChanges { target: mainbar; x: -frogz.width }
            StateChangeScript { script : {
                    gamesound.stop()
                    frogzsound.play()
                    Logic.stopGame()
                }
            }
        },
        State {
            name: "stateGameBegins"; // when: gameState.gameOver == true
            PropertyChanges { target: mainbar; x: -2 * frogz.width }
            StateChangeScript { script : {
                    frogzsound.stop()
                    gamesound.play()
                    Logic.startGame()
                }
            }
        }
    ]

    transitions: Transition {
        NumberAnimation { properties: "x,y"; duration: 1200; easing.type: Easing.OutQuad }
    }
}
