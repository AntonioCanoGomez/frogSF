.pragma library
.import QtQuick 2.0 as QQ




var gameState;

function getGameState() { return gameState; }


function newGameState(mainbar)
{
    gameState = mainbar;
    gameState.ranas = [];
    for (var k in gameState.ranas) {
        gameState.ranas=null;
    }
    gameState.piedras = [];
    for (var k in gameState.piedras) {
        gameState.piedras=null;
    }

    return gameState;
}



function startGame() {
    gameState.gameRunning=true;
}

function stopGame() {
    gameState.gameRunning=false;
}


var ranaComponent = Qt.createComponent("RanasBase.qml");
var piedraComponent = Qt.createComponent("BasePiedra.qml");

function newRana(x,y,width,height)
{
//    console.log("x:"+x+"y:"+y+"width:"+width+"height:"+height);
//    console.log("Estado: "+ranaComponent.status);
    var ret = ranaComponent.createObject(gameState.frogzgame , { "x" : x, "y" : y  , "width" : width , "height" : height} );
    ret.x=x; ret.y=y;  ret.width=width; ret.height=height;

    gameState.ranas.push(ret);
    return ret;
}


function newPiedra(x,y,fuerzalanzamiento,width,height) {
//    console.log("x:"+x+"y:"+y+"fuerzalanzamiento:"+fuerzalanzamiento+"width:"+width+"height:"+height);
    var ret = piedraComponent.createObject(gameState.frogzgame , { "x" : x, "y" : y , "fuerzalanzamiento":fuerzalanzamiento , "width":width , "height":height  } );
    ret.x=x; ret.y=y; ret.width=width; ret.height=height;
//    ret.piedra.x=x; ret.piedra.y=y; ret.piedra.width=width; ret.piedra.height=height;
    gameState.piedras.push(ret);
    return ret;
}



function tick() {
    if (!gameState.gameRunning)
        return;


    // Ini: actualizamos el cursos
    if (gameState.frogzgame.piedra.state=="lanzando" && (gameState.frogzgame.piedra.y>27*gameState.frogzgame.height/40) ) {
        if (gameState.frogzgame.piedra.fuerzalanzamiento == -1) gameState.frogzgame.piedra.fuerzalanzamiento=gameState.frogzgame.piedra.y-(27*gameState.frogzgame.height/40) ;
        gameState.frogzgame.piedra.y=gameState.frogzgame.piedra.y-((2/300)*gameState.frogzgame.height);
    }

    if (gameState.frogzgame.piedra.state=="lanzando" && (gameState.frogzgame.piedra.y<=27*gameState.frogzgame.height/40) ) {
        gameState.frogzgame.piedra.state="";
        newPiedra(gameState.frogzgame.piedra.x,gameState.frogzgame.piedra.y,gameState.frogzgame.piedra.fuerzalanzamiento,
                  gameState.frogzgame.piedra.width,gameState.frogzgame.piedra.height);
        gameState.frogzgame.piedra.fuerzalanzamiento=-1;
    }
    // Fin: actualizamos el cursos



    // Ini: actualizamos piedras
//    console.log("gameState.piedras.length: "+gameState.piedras.length);
    for (var k in gameState.piedras) {
        var conflict = gameState.piedras[k];
        conflict.y=conflict.y-((2/300)*gameState.frogzgame.height);
        if (conflict.y<5) {
            conflict.destroy();
            gameState.piedras.splice( k, 1 );
        }

    }
    // Fin: actualizamos piedras

    // Ini: Miramos colisiones


    // Finf: Miramos colisiones
    for (var p in gameState.piedras) {
            for (var r in gameState.ranas) {
/*                console.log("Mirando: Rana: "+r+" y Piedra: "+p);
                console.log("gameState.piedras[p].x: "+gameState.piedras[p].x);
                console.log("gameState.piedras[p].y: "+gameState.piedras[p].y);
                console.log("gameState.ranas[r].x: "+gameState.ranas[r].x);
                console.log("gameState.ranas[r].y: "+gameState.ranas[r].y); */
                if (
                        (gameState.piedras[p].x > gameState.ranas[r].x - (1/3)*gameState.piedras[p].width
                         &&
                        gameState.piedras[p].x < gameState.ranas[r].x + (5/3)*gameState.piedras[p].width
                        )
                        &&
                        (gameState.piedras[p].y  > gameState.ranas[r].y - (5/3)*gameState.piedras[p].height
                         &&
                         gameState.piedras[p].y < gameState.ranas[r].y + (2/3)*gameState.piedras[p].height
                        )
                )
                {
//                    console.log("Tocada");
                    var apuntadorRana = gameState.ranas[r] ;
                    gameState.ranas.splice(r, 1 );
                    apuntadorRana.destroy();
                    var apuntadorPiedra=gameState.piedras[p];
                    gameState.piedras.splice(p, 1 );
                    apuntadorPiedra.destroy();

               }
            }
    }

    // Ini: actualizamos ranas
//    console.log("gameState.ranas.length: "+gameState.ranas.length);

    if (gameState.ranas.length<1) newRana(Math.floor(Math.random() * ((gameState.frogzgame.width-gameState.frogzgame.piedra.width) - 5 + 1))+5
                                        , Math.floor(Math.random() * ((gameState.frogzgame.height/2) - 5 + 1))+5
                                          , gameState.frogzgame.piedra.width
                                          , gameState.frogzgame.piedra.height );

    // Fin: actualizamos ranas

}
