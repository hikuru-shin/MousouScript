function wallDetection(){
  if(y + dy < ballRadius) {
    dy = -dy;
    if(dx ==0){
      dx = 3;
    }
  } else if(y + dy > $('canvas')[0].height - ballRadius) {
    dy = -dy;
  }

  if(x + dx  > $('canvas')[0].width-ballRadius-140) {
      dx = -dx;
  }else if(x + dx -100 < ballRadius){
    if(y > paddleY && y< paddleY + paddleHeight){
      dx = -dx;
      if( dx >10 ){
        dx = 5;
      }
      if(y<paddleY + 30){
       if(dy>0){
          dy = -dy;
       }else if( dy == 0){
          dx = 3;
          dy = -7;
       }
      }
      if(y>paddleY+70){
       if(dy<0){
          dy = -dy;
       }else if(dy == 0){
          dx = 3;
          dy = 7;
       }
      }
    }else{
    start = 0;
    x = 110;
    y = paddleY+50;
    dx = -dx;
    elife1 --;
    }
  }
}
