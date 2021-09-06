function pauseCases(){
  if(pauseCase == 0){
    stop();
  }
  if(pauseCase == 1){
    stopLaser();
  }
  if(pauseCase == 2){
    stopGback();
  }
}
