function drawScore(){
  ctx.beginPath();
  ctx.font = '24pt Impact';
  ctx.fillStyle = 'rgb(255, 255, 255)';
  ctx.fillText(score, 1170,700);
  ctx.closePath();
  if(time%2==0){
    if(start != 0){
    score-=scoreDegTime;
    }
  }
}
