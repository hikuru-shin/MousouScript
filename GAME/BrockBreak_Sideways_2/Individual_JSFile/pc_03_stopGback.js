function stopGback(){
  if(paddleX<backGX-100){
    drawFrontImage();
    drawBricks();
    ctx.beginPath();
    ctx.fillStyle = 'rgba(0, 0, 0,0.5)';
    ctx.fillRect(100, 0, 1050, 720);
    ctx.fill();
    ctx.closePath();
    restart();
    paddleX+=10;
    if(!(paddleX+10<backGX-100)){
      skillTime = time +25;
      if(skillTime>2000){
      skillTime -=2000;
      }
    }
  }else{
  ctx.drawImage(imgs[2],0,0,$('canvas')[0].width,$('canvas')[0].height);
  drawBall();
  drawBricks();
  ctx.drawImage(imgs[7],paddleX-30,paddleY-30,paddleWidth+60, paddleHeight+60);
  restart();
  if(skillTime == time){
    pause =false;
    systemGback(backGXX,backGXY);
    paddleX = 0;
    backGX =0;
    backGXX = 0;
    backGXY = 0;
    isBackGXX = false;
    skillTime = 0;
    elife1--;
    var sound = new Audio('data/sound/bomb1.ogg');
    sound.play();
    }
  }
}
