function drawSkillGage(){
  if(start == 1){
  if(isEnatlation){
  if(skillgageEliminate<90){
    skillgageEliminate++;
  }
  }
  if(time%4 == 0){
  if(skillgageLaser<90){
    skillgageLaser++;
  }
  }
  if(skillgageGback<90){
    skillgageGback++;
  }
  }
  ctx.drawImage(imgs[8],1165,240,100,100);
  ctx.beginPath();
  //ctx.fillStyle = 'rgb(255,0,0)';
  //ctx.fillRect(x, y, 5, 5);
  ctx.fillStyle = 'rgb(0, 0, 0)';
  ctx.fillRect(1165, 240, 5, 100);
  ctx.fillRect(1260, 240, 5, 100);
  ctx.fillRect(1165, 240, 100, 5);
  ctx.fillRect(1165, 335, 100, 5);
  ctx.fillStyle = 'rgba(0, 0, 255,0.5)';
  ctx.fillRect(1170, 335-skillgageEliminate, 90, 0 +skillgageEliminate);
  if(skillgageEliminate == 90 && !(time%20 == 0)){
    ctx.font = '12pt Impact';
    ctx.fillStyle = 'rgb(0, 0, 0)';
    ctx.fillText('press A', 1190,325);
  }
  ctx.fill();
  ctx.closePath();
  ctx.drawImage(imgs[9],1165,360,100,100);
  ctx.beginPath();
  ctx.fillStyle = 'rgb(0, 0, 0)';
  ctx.fillRect(1165, 360, 5, 100);
  ctx.fillRect(1260, 360, 5, 100);
  ctx.fillRect(1165, 360, 100, 5);
  ctx.fillRect(1165, 455, 100, 5);
  ctx.fillStyle = 'rgba(255, 0, 0,0.5)';
  ctx.fillRect(1170, 455-skillgageLaser, 90, 0 +skillgageLaser);
  if(skillgageLaser == 90 && !(time%20 == 0)){
    ctx.font = '12pt Impact';
    ctx.fillStyle = 'rgb(0, 0, 0)';
    ctx.fillText('press S', 1190,445);
  }
  ctx.fill();
  ctx.closePath();
  ctx.drawImage(imgs[10],1165,480,100,100);
  ctx.beginPath();
  ctx.fillStyle = 'rgb(0, 0, 0)';
  ctx.fillRect(1165, 480, 5, 100);
  ctx.fillRect(1260, 480, 5, 100);
  ctx.fillRect(1165, 480, 100, 5);
  ctx.fillRect(1165, 575, 100, 5);
  ctx.fillStyle = 'rgba(255, 0, 0,0.5)';
  ctx.fillRect(1170, 575-skillgageGback, 90, 0 +skillgageGback);
  if(skillgageGback == 90 && !(time%20 == 0)){
    ctx.font = '12pt Impact';
    ctx.fillStyle = 'rgb(0, 0, 0)';
    ctx.fillText('press D', 1190,570);
  }
  ctx.fill();
  ctx.closePath();
}
