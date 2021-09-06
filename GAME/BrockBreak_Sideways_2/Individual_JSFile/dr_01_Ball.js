/**
 * ボールの描画
 * @return {[type]} [description]
 */
function drawBall() {
    if(start!=1){
      ctx.beginPath();
      ctx.moveTo(x,y);
      ctx.lineTo(x+startalfa[startalfanum].x,y+startalfa[startalfanum].y);
      ctx.closePath();
    }
    ctx.stroke();
    ctx.beginPath();
    ctx.arc(x, y, ballRadius, 0, Math.PI*2 , false);
    if(enatlation == 0){
      ctx.fillStyle = 'rgb(0, 255, 0)';
    }else{
      ctx.fillStyle = 'rgb(0, 0, 255)';
    }
    ctx.fill();
    ctx.closePath();
}
