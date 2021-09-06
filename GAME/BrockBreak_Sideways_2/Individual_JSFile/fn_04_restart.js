/**
 * ボール発射時の軌道
 * @return {[type]} [description]
 */
function restart(){
  if(time<2000){
    time++;
  }else{
    time=0;
  }
  //ボールを発射する角度を調整する
  if(time%20 == 0 ){
    isStartalfanum++;
    if(isStartalfa){
      startalfanum++;
      if(isStartalfanum%4 == 0) isStartalfa = false;
    }else{
      startalfanum--;
      if(isStartalfanum%4 == 0) isStartalfa = true;
    }
  }
}
