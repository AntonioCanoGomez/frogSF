import QtQuick 2.0
import "logic.js" as Logic
import "."


Item {
    id: container
//    x:10
//    y:10
    z: 1001
//    height: 10
//    width: 10
    property string name: "Rana"
    property int col: 0
    property int row: 0
    property string state: ""



    SpriteSequence {
        id: ranaSprite
        width: container.width
        height: container.height
        interpolate: false
        goalSprite: ""

        Sprite {
            name: "left"
            source: "frog_sprite.png"
            frameX:2
            frameWidth: 100
            frameHeight: 100
            frameCount: 1
            frameDuration: 800
            frameDurationVariation: 400
            to: { "right" : 1 }
        }

        Sprite {
            name: "right"
            source: "frog_sprite_rev.png"
            frameX:2
            frameWidth: 100
            frameHeight: 100
            frameCount: 1
            frameDuration: 800
            frameDurationVariation: 400
            to: { "left" : 1 }
        }


    }
}
