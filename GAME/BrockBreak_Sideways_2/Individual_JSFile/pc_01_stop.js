function stop(){
  ctx.beginPath();
  ctx.font = '24pt Arial';
  ctx.fillStyle = 'rgb(0, 0, 0)';
  ctx.fillText('PAUSE', $('canvas')[0].width/2-100,$('canvas')[0].height/2);
  ctx.font = '18pt Arial';
  ctx.fillText('back to press P key', $('canvas')[0].width/2-150,$('canvas')[0].height/2+30);
  ctx.fillStyle = 'rgba(0, 200, 200,0.005)';
  ctx.fillRect(0, 0, $('canvas')[0].width,$('canvas')[0].height);
  ctx.fill();
  ctx.closePath();
}
