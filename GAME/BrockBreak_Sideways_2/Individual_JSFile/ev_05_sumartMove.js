/**
 * スマホ操作時機能追加
 */
document.addEventListener("touchmove", sumartMoveHandler, false);
/**
 *スマホ操作時機能
 */
 function sumartMoveHandler(e) {
     e.preventDefault();
     var canvas_ob = document.getElementById("canvas");
     var windowRatio = window.innerWidth/canvas_ob.width;
     if(window.innerWidth<=canvas_ob.width){
       var leftMargin = 0;
       var relativeX = (e.changedTouches[0].pageX - leftMargin)/windowRatio;
     }else{
       var leftMargin = window.innerWidth /2 - canvas_ob.width/2;
       var relativeX = e.changedTouches[0].pageX - leftMargin;
     }
     //console.log(relativeX);
     if(debug==3){
       //console.log("windowsize:"+window.innerWidth+" leftMargin: "+leftMargin+" relativeX:"+relativeX);
     }
     if(relativeX > canvas_ob.width*0.06+paddleWidth/2 && relativeX < canvas_ob.width*0.94-paddleWidth/2) {
       paddleX = relativeX - paddleWidth/2;
     if(start == 0){
       x = relativeX ;
     }
     }
 }
