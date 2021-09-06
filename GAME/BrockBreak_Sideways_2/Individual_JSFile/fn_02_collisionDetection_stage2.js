function collisionDetection() {
    var clear = 0;
    for(var c=0; c<brickColumnCount; c++) {
        for(var r=0; r<brickRowCount; r++) {
            var b = bricks[c][r];
            if(b.status == 1) {
                clear++;
                if(x >= b.x && x <= b.x+brickWidth && y >= b.y && y <= b.y+brickHeight) {
                  b.status = 0;
                  score += 100;
		              var sound = new Audio('data/sound/brk.ogg');
                  sound.play();
                  if(enatlation == 0){
                  if((b.x < lastx) && ((b.x + brickWidth) > lastx)){
                    debugText(b , "上下侵入　y反転");
                    if(b.y-lasty>0){
                        y = b.y - ballRadius;
                    }else if(b.y-lasty<0){
                        y = b.y + brickHeight;
                    }
                    dy = -dy;
                      return;
                  }
                  if((b.y < lasty) && ((b.y + brickHeight) > lasty)){
                    debugText(b , "左右侵入　x反転");
                    if(b.x-lastx>0){
                        x = b.x - ballRadius;
                    }else if(b.x-lastx<0){
                        x = b.x + brickWidth +ballRadius;
                    }
                    dx = -dx;
                    return;
                  }
                  var lostX = b.x-lastx;
                  if(lostX<0){
                    lostX = -lostX;
                  }
                  if(lostX>brickWidth){
                    lostX -= brickWidth;
                  }
                  var lostY = b.y-lasty;
                  if(lostY<0){
                    lostY = -lostY;
                  }
                  if(lostY>brickHeight){
                    lostY -= brickHeight;
                  }
                  if(lostX<lostY){
                    debugText(b , "斜め侵入　y反転");
                    if(b.y-lasty>0){
                      if(bricks[c][r-1].status == 1){
                        debugText(b, "上にブロックあったわ");
                        dx = -dx;
                        if(b.x-lastx>0){
                            x = b.x - ballRadius;
                        }else if(b.x-lastx<0){
                            x = b.x + brickWidth +ballRadius;
                        }
                        return;
                      }
                    }
                    if(b.y-lasty<0){
                      if(bricks[c][r+1].status == 1){
                        debugText(b,"下にブロックあったわ");
                        dx = -dx;
                        if(b.x-lastx>0){
                            x = b.x - ballRadius;
                        }else if(b.x-lastx<0){
                            x = b.x + brickWidth +ballRadius;
                        }
                        return;
                      }
                    }
                    dy = -dy;
                    if(b.y-lasty>0){
                        y = b.y - ballRadius;
                    }else if(b.y-lasty<0){
                        y = b.y + brickHeight;
                    }
                    return;
                  }
                  if(lostX>lostY){
                    debugText(b , "斜め侵入　x反転");
                    if(b.x-lastx>0){
                      if(bricks[c-1][r].status ==1){
                        debugText(b,"左にブロックあったわ");
                        dy = -dy;
                        if(b.y-lasty>0){
                            y = b.y - ballRadius;
                        }else if(b.y-lasty<0){
                            y = b.y + brickHeight;
                        }
                        return;
                        }
                    }
                    if(b.x-lastx<0){
                      if(bricks[c+1][r].status ==1){
                        debugText(b,"右にブロックあったわ");
                        dy = -dy;
                        if(b.y-lasty>0){
                            y = b.y - ballRadius;
                        }else if(b.y-lasty<0){
                            y = b.y + brickHeight;
                        }
                        return;
                        }
                      }
                      dx = -dx;
                      if(b.x-lastx>0){
                          x = b.x - ballRadius;
                      }else if(b.x-lastx<0){
                          x = b.x + brickWidth +ballRadius;
                      }
                      return;
                    }
                  //斜めから侵入時処理：デバッグ用
                  debugText(b,"斜め");
                  dx = -dx;
                  dy = -dy;
                  }
                }
            }
        }
    }
    if(clear == 0){
      eflag1 += 10;
      tyrano.plugin.kag.variable.tf.score = score;
      tyrano.plugin.kag.variable.tf.eflag1 = eflag1;
      for(var i = 0; i < 3 ; i ++ ){
        if(isDrawOuter[i].isDraw){
          //spclear1 = true;
          spclear2 = true;
          //spnclear1 = true;
          //spnclear2 = true;
        }
      }
      //tyrano.plugin.kag.variable.sf.spclear1 = spclear1;
      tyrano.plugin.kag.variable.sf.spclear2 = spclear2;
      //tyrano.plugin.kag.variable.sf.spnclear1 = spnclear1;
      //tyrano.plugin.kag.variable.sf.spnclear2 = spnclear2;
      //spclear系がtrueならレーザーを壊してない
      clearInterval(interval);
    }
}
