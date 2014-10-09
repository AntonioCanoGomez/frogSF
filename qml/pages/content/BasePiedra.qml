import QtQuick 2.0
import "logic.js" as Logic
import "."

/*Item {
    id: container
    x:0
    y:0
    z: 1001
    height: 50
    width: 50
    property real fuerzalanzamiento


    Image {
        id:piedra
        x:0
        y:0
        width: parent.width
        height: parent.height
        source:"stone.png"
        transform: Rotation {
          angle: 45
        }
    }

}*/

Image {
    id:container
//    x:0
//    y:0
    z:1001
//    width: 50
//    height: 50
    property real fuerzalanzamiento
    source:"stone.png"
    transform: Rotation {
        id:rotation
      angle: 45
    }
}
