
/**
 * key押上時の機能追加
 */
document.addEventListener("keyup", keyUpHandler, false);

/**
 * key押上時の機能
 * @param  {[type]} e [description]
 * @return {[type]}   [description]
 */
function keyUpHandler(e) {
    if(e.keyCode == 80){
        if(pause){
          pause = false;
        }else{
          pause = true;
        }
        pauseCase = 0;
    }
    if(start == 1){
    if(!pause){
    if(e.keyCode == 83){
      if(skillgageLaser == 90){
      var sound = new Audio('data/sound/laser1.ogg');
      sound.play();
      skillgageLaser =0;
      pauseCase = 1;
      pause = true;
      skillTime = time + laserWaitTime;
      if(skillTime>2000){
        skillTime -=2000;
      }
      var sClear = Math.floor((paddleY+50)/brickHeight);
      for(var c=0; c<brickColumnCount; c++) {
          var b = bricks[c][sClear];
          var bb = bricks[c][sClear-1];
          var bbb = bricks[c][sClear+1];
          if(b.status == 1) {
            b.status = 0;
          }
          if(bb.status == 1) {
            bb.status = 0;
          }
          if(bbb.status == 1) {
            bbb.status = 0;
          }
      }
    }
    }
    if(e.keyCode == 68){
    if(skillgageGback == 90){
      skillgageGback = 0;
      pauseCase = 2;
      pause = true;
      skillTime = time + gbackWaitTime;
      if(skillTime>2000){
        skillTime -=2000;
      }
      var sClear = Math.floor(paddleY/brickHeight);
      for(var c=0; c<brickColumnCount; c++) {
        for(var i = 0; i<6; i++){
          var b = bricks[c][sClear+i];
          if(b.status == 1){
            backGX = b.x;
            backGXX = c;
            backGXY = sClear;
            return;
            }
          }
      }
      backGX = $('canvas')[0].width-ballRadius-140;
      backGXX = brickColumnCount-1;
      backGXY = sClear ;
      isBackGXX = true;
      }
    }

    if(e.keyCode == 65){
      if(skillgageEliminate==90){
      //skillgageEliminate = 0;
      isEnatlation = false;
      enatlation = 1 ;
      skillTimeEnalation = time +enatlationWaitTime;
      skillTimeEnalationOrigin = time;
      if(skillTimeEnalation>2000){
        //skillTimeEnalation -=2000;
      }
      }
    }
    }
    }
    if(e.keyCode == 38) {
        UpPressed = false;
    }
    else if(e.keyCode == 40) {
        DownPressed = false;
    }
}
