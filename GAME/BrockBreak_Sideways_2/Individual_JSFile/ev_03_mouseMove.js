
/**
 * マウス操作時機能の追加
 */
document.addEventListener("mousemove", mouseMoveHandler, false);

/**
 * マウス操作時の機能
 */
 function mouseMoveHandler(e) {
     if(pause) return;
     if(e.clientY < 720 -paddleHeight/2 && e.clientY > paddleHeight/2){
         paddleY = e.clientY - paddleHeight/2;
     }
     if(start == 0){
       y = paddleY+50;
     }
 }
