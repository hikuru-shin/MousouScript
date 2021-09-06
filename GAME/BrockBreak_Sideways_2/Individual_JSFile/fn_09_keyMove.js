function keyMove(){
  if(UpPressed && paddleY > 0) {
      paddleY -= 10;
      if(start ==0){
        y = paddleY + paddleHeight/2;
      }
  }
  else if(DownPressed && paddleY < 720-paddleHeight) {
      paddleY += 10;
      if(start ==0){
        y = paddleY + paddleHeight/2;
      }
  }
}
