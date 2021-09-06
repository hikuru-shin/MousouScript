function stopLaser(){
  drawFrontImage();
  drawBricks();
  var timeasist = skillTime -time;
  ctx.beginPath();
  ctx.fillStyle = 'rgba(0, 0, 0,0.5)';
  ctx.fillRect(100, 0, 1050, 720);
  ctx.fill();
  ctx.closePath();
  if(isBrockHerf){
  if(timeasist > 50){
  for(var i = 0; i < isDrawOuter.length ; i++){
    if(isDrawOuter[i].isDraw){
      //レーザー削除処理
      //上
      if(isDrawOuter[i].num == 18){
        //描画
        ctx.drawImage(imgs[18] , isDrawOuter[i].x , isDrawOuter[i].y , 100 , 50);
        if(isDrawOuter[i].isAttr){
          //描画
          ctx.drawImage(imgs[19] , isDrawOuter[i].x , isDrawOuter[i].y , 100 , 50);
        }
      }
      //下
      if(isDrawOuter[i].num == 20){
        //描画
        ctx.drawImage(imgs[20] , isDrawOuter[i].x , isDrawOuter[i].y , 100 , 100);
        if(isDrawOuter[i].isAttr){
          //描画
          ctx.drawImage(imgs[21] , isDrawOuter[i].x , isDrawOuter[i].y , 100 , 100);
        }
      }
    }
  }
}else{
  for(var i = 0; i < isDrawOuter.length ; i++){
    if(isDrawOuter[i].isDraw){
      //レーザー削除処理
      //上
      if(isDrawOuter[i].num == 18){
        //描画
        if(isDrawOuter[i].isAttr){
          //描画
          if(paddleY < 50){
            //isDrawOuter[i].isDraw = false;
            //爆破描画
            ctx.drawImage(imgs[7] , isDrawOuter[i].x , isDrawOuter[i].y , 100 , 50);
            if(timeasist == 5 ){
              isDrawOuter[i].isDraw = false;
              isLaserCount --;
            }
          }
        }else{
          ctx.drawImage(imgs[18] , isDrawOuter[i].x , isDrawOuter[i].y , 100 , 50);
        }
      }
      //下
      if(isDrawOuter[i].num == 20){
        //描画
        if(isDrawOuter[i].isAttr){
          //描画
          if(paddleY > 570 ){
            //isDrawOuter[i].isDraw = false;
            //爆破描画
            ctx.drawImage(imgs[7] , isDrawOuter[i].x , isDrawOuter[i].y , 100 , 100);
            if( timeasist == 5 ){
              isDrawOuter[i].isDraw = false;
              isLaserCount --;
            }
          }
        }
        else{
          ctx.drawImage(imgs[20] , isDrawOuter[i].x , isDrawOuter[i].y , 100 , 100);
        }
      }
    }
  }
}
}
  var paddleyyy = 25;
  if(timeasist>70){

  }else if(timeasist>60){
    ctx.drawImage(imgs[26],paddleX+100,paddleY+paddleyyy,$('canvas')[0].width-ballRadius-240, paddleHeight-50);
  }else if(timeasist>50){
    ctx.drawImage(imgs[27],paddleX+100,paddleY+paddleyyy,$('canvas')[0].width-ballRadius-240, paddleHeight-50);
  }else if(timeasist>40){
    ctx.drawImage(imgs[28],paddleX+100,paddleY+paddleyyy,$('canvas')[0].width-ballRadius-240, paddleHeight-50);
  }else if(timeasist>30){
    ctx.drawImage(imgs[27],paddleX+100,paddleY+paddleyyy,$('canvas')[0].width-ballRadius-240, paddleHeight-50);
  }else if(timeasist>20){
    ctx.drawImage(imgs[26],paddleX+100,paddleY+paddleyyy,$('canvas')[0].width-ballRadius-240, paddleHeight-50);
  }else{

  }
  if(skillTime == time){
    pause =false;
    skillTime = 0;
  }
  restart();
}
