function memori(){
  ctx.font = '6pt Arial';
  ctx.fillStyle = 'rgb(0, 255, 0)';
  for(var i = 100; i<1160;i+=20){
    for(var ii = 0; ii < 720 ; ii += 20)
      ctx.fillText(i/20-5, i+10, 18 +ii);
      //ctx.fillText(i/20-5, i+8, 720);
  }
  ctx.fillStyle = 'rgb(0, 0, 255)';
  for(var i = 0; i<720;i+=20){
    for(var ii = 0; ii<1060; ii += 20)
    ctx.fillText(i/20-1, 100 +ii, i-10);
    //ctx.fillText(i/20-1, 1140, i-10);
  }
}
