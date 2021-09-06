/**
 * 反射時のボールの座標及び結果
 * @param  {[type]} b    [description]
 * @param  {[type]} text [description]
 * @return {[type]}      [description]
 */
function debugText(b , text){
      if(debugMode){
      alert("ボールの座標:( " +x+ " , "+ y + " )\n"+
      "前ボール座標:( " +lastx+ " , "+ lasty + " )\n"+
      "ブロクの座標:( " +b.x+" , "+ b.y + " )\n"+
      "ボール加速度:( " +dx +" , "+ dy + " )\n"+
      "結果:"+text);
      }
}
