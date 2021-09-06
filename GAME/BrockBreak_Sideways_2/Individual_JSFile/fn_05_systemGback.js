function systemGback(c , r){
  for(var i = 0; i<11; i++){
    for(var ii = 0 ; ii < 3 ; ii++){
      //alert("c:"+c + " r:"+r + " i:"+i + " ii:"+ii + "   a");
      if(!isBackGXX){
        if(!(r+i-3<0) && !(r+i-3 > brickRowCount-1)){
          var b = bricks[c+ii][r+i-3];
          b.status = 0;
        }
      }
      //alert("c:"+c + " r:"+r + " i:"+i + " ii:"+ii + "   b");
      if(i<5){
        if(!(r-ii<0) && c-i >= 0){
          var b = bricks[c-i][r-ii];
          b.status = 0;
        }
        if(!(r+ii+5>brickRowCount-1) && c-i >=0){
          var b = bricks[c-i][r+ii+5];
          b.status = 0;
        }
      }
    }
    //b.status = 0;
  }
}
