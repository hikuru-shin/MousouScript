/**
 * マウスクリック時の機能追加
 */
document.addEventListener("click", mouseClickHandler, false);

/**
 * マウスクリック時の機能
 */
 function mouseClickHandler(e){
   if(start == 0){
     dx = startalfa[startalfanum].x/10;
     dy = startalfa[startalfanum].y/10;
   }
   if(waitBall > 0){
     start = 1;
   }
   waitBall++;
 }
