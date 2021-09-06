

/**
 * 押下時の処理を追加
 * @type {[type]}
 */
document.addEventListener("keydown", keyDownHandler, false);

/**
 * key押下時の機能
 * @param  {[type]} e [description]
 * @return {[type]}   [description]
 */
function keyDownHandler(e) {
    //console.log(e.keyCode);
    if(e.keyCode == 32){
      if(start == 0){
        dx = startalfa[startalfanum].x/10;
        dy = startalfa[startalfanum].y/10;
      }
      if(waitBall > 0){
        start = 1;
      }
      waitBall++;
    }
    if(e.keyCode == 38) {
        UpPressed = true;
    }
    else if(e.keyCode == 40) {
        DownPressed = true;
    }
    //デバッグ用-----------------
    if(debugModeCommand){
      //デバッグモード切り替え
      if(e.keyCode == 84){
        if(debugMode){
          debugMode = false;
        }else{
          debugMode = true;
        }
      }
      //スキルゲージをMaxに
      if(e.keyCode == 89){
        skillgageGback = 90;
        skillgageLaser = 90;
        skillgageEliminate = 90;
      }
    }

}
