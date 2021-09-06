/**
 * パドルの描画
 * @return {[type]} [description]
 */
function drawPaddle() {
      ctx.drawImage(imgs[0],paddleX,paddleY,paddleWidth, paddleHeight);
      ctx.font = '24pt Arial';
      ctx.fillStyle = 'rgb(255, 255, 255)';
      ctx.fillText(elife1, 1225, 90);
      if(elife1 == 0){
      elose1 += 10;
      tyrano.plugin.kag.variable.tf.elose1 = elose1;
      clearInterval(interval);
    }
}
