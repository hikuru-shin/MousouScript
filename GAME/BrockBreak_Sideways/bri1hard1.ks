*start
;-----------------------------------------------------書き換え用
[title name="ステージ1：難易度HARD"]

[bg  storage="wv.gif" time="10"  ]
@eval exp="tf.elose1=sf.reset"
@eval exp="tf.eflag1=sf.reset"

@fadeinbgm storage=rbgm6.ogg time=7000 volume=50
[layopt layer=0 visible=true]
[iscript]
//前景レイヤ0に、キャンバスを追加します
$('.0_fore').prepend('<canvas id="canvas" style="position:absolute;"></canvas>');
//メッセージより前に表示する場合は、以下を使用ください
//$('.message0_fore').prepend('<canvas id="canvas" style="position:absolute;z-index:1002"></canvas>');
var debug=2;
//2はブロック枠、1はブロック数描画、0はどっちも無し
//-----------------------------------------------------キャンバスの初期設定
$('canvas').attr('width', $('#tyrano_base').width());
$('canvas').attr('height', $('#tyrano_base').height());
var ctx = $('canvas')[0].getContext('2d');
//;-----------------------------------------------------書き換え用
var elife1 = 15;
var eflag1 = 0;
var elose1 = 0;
//-----------------------------------------------------キャンバスの初期設定:end

//alert(eflag1);

//---------------------------ティラノ背景表示
 const TG = tyrano.plugin.kag;
 const tmp = TG.stat.is_strong_stop;
 TG.stat.is_strong_stop = true;
 tyrano.plugin.kag.ftag.startTag('bg', {
	storage: "stage6.png",
	time: 10,
    });
 if (!tmp) TG.stat.is_strong_stop = false;
//---------------------------ティラノ背景表示終了

var pause = false;
var pauseCase = 0;
var time = 0;
var score = 100000;
var scoreDegTime = 10; //10ずつ減らす
var debugMode = false;
var debugModeCommand = false;//開発者コマンド
var laserWaitTime = 90;
var skillTimeEnalationOrigin = 0;
var enatlationWaitTime  = 250;
var gbackWaitTime = 50;
//-----------------------------------------------------ボール・パドル・ブロック：初期設定
//------------------------------ボールの初期設定
//*@type ballRadius ボールの大きさ
//*@type x ボールのX座標
//*@type y ボールのY座標
//*@type dx ボールの加速度(x座標)
//*@type dy ボールの加速度(y座標)
//*@type lastx 前回のボール位置(x座標)
//*@type lasty 前回のボール位置(y座標)
//*@type enatlation ボールの貫通付与
//*@type waitBall ボールの発射判定
var ballRadius = 7;
var x = 120;
var y = $('canvas')[0].height-107;
var dx = +5;
var dy = -5;
var lastx = 0;
var lasty = 0;
var enatlation = 0;
var waitBall = 0;
var start = 0;
var serch = 0;
var startalfanum = 0;
var isStartalfa = true;
var isStartalfanum = 0;
var startalfa = [];
startalfa[0] = {x:30,y:70};
startalfa[1] = {x:60,y:40};
startalfa[2] = {x:100,y:0};
startalfa[3] = {x:60,y:-40};
startalfa[4] = {x:30,y:-70};
//----------------------------ボールの初期設定:end


//---------------------------パドル(バー)の初期設定
//@type paddleHeight バーの高さ
//@type paddleWidth バーの長さ
//@type paddleX バーのX座標
//@type UpPressed →key押下時の判定用
//@type DownPressed ←key押下時の判定用
var paddleHeight = 100;
var paddleWidth = 100;
//var paddleX = ($('canvas')[0].width-paddleWidth)/2;
var paddleX = 0;
var paddleY = 1000;
var UpPressed = false;
var DownPressed = false;
//---------------------------パドル(バー)の初期設定:end


//----------------------------ブロックの初期設定
//@type brickRowCount ブロック列数
//@type brickColumnCount ブロック行数
//@type brickWidth ブロックの長さ
//@type brickHeight ブロックの高さ
//@type brickPadding ブロックのパディング
//@type brickOffsetTop ブロック全体の位置調整(高さ)
//@type brickOffsetLeft ブロック全体の位置調整(横)
var brickCum = 0;
var brickRowCount =36;
var brickColumnCount = 53;
var brickWidth = 20;
var brickHeight = 20;
var brickPadding = 0;
var brickOffsetTop = 0;
var brickOffsetLeft = 80;
var bricks = [];　//ブロック生成ループ
//ブロック生成
for(var c=0; c<brickColumnCount; c++) {
    bricks[c] = [];
    for(var r=0; r<brickRowCount; r++) {
      bricks[c][r] = { x: 0, y: 0, status: 0 };
    }
}

var brickChange = [];
var brickChangeNum = 0;
brickChange[brickChangeNum] = { r:15 , cMin:36 , cMax:39 };
brickChange[++brickChangeNum] = { r:16 , cMin:36 , cMax:39 };
brickChange[++brickChangeNum] = { r:17 , cMin:36 , cMax:40 };
brickChange[++brickChangeNum] = { r:18 , cMin:36 , cMax:41 };
brickChange[++brickChangeNum] = { r:19 , cMin:35 , cMax:41 };
brickChange[++brickChangeNum] = { r:20 , cMin:34 , cMax:40 };
brickChange[++brickChangeNum] = { r:21 , cMin:33 , cMax:37 };
brickChange[++brickChangeNum] = { r:22 , cMin:32 , cMax:39 };
brickChange[++brickChangeNum] = { r:23 , cMin:32 , cMax:39 };
brickChange[++brickChangeNum] = { r:24 , cMin:31 , cMax:39 };
brickChange[++brickChangeNum] = { r:25 , cMin:30 , cMax:39 };
brickChange[++brickChangeNum] = { r:25 , cMin:20 , cMax:26 };
brickChange[++brickChangeNum] = { r:26 , cMin:20 , cMax:39 };
brickChange[++brickChangeNum] = { r:27 , cMin:20 , cMax:39 };
brickChange[++brickChangeNum] = { r:27 , cMin:17 , cMax:20 };
brickChange[++brickChangeNum] = { r:28 , cMin:16 , cMax:21 };
brickChange[++brickChangeNum] = { r:28 , cMin:21 , cMax:39 };
brickChange[++brickChangeNum] = { r:29 , cMin:16 , cMax:21 };
brickChange[++brickChangeNum] = { r:29 , cMin:21 , cMax:39 };
brickChange[++brickChangeNum] = { r:30 , cMin:19 , cMax:21 };
brickChange[++brickChangeNum] = { r:30 , cMin:22 , cMax:39 };
brickChange[++brickChangeNum] = { r:31 , cMin:28 , cMax:38 };
brickChange[++brickChangeNum] = { r:32 , cMin:31 , cMax:37 };
for(var c=0; c<brickColumnCount; c++) {
  for(var r=0; r<brickRowCount; r++) {
    for(var i = 0; i <brickChangeNum+1 ; i++){
      if((r==brickChange[i].r) && c < brickChange[i].cMax && c > brickChange[i].cMin){
        bricks[c][r] = { x: 0, y: 0, status: 1 };
      }
    }
  }
}


//----------------------------ブロックの初期設定:end 差し替え完了

//----------------------------スキルゲージ設定
var skillCoordinates = [];
skillCoordinates[0] = { x:0, y:0};
var skillTime = 0;
var skillTimeEnalation = 0;
var skillgageEliminate = 0;
var skillgageLaser = 0;
var skillgageGback = 0;
var backGX = 0;
var backGXX = 0;
var backGXY = 0;
var isBackGXX = false;
var isEnatlation = true;
//------------------------------------------

//--------------------------------------------------ボール・パドル・ブロック：初期設定:end

//--------------------------------------------------------key＆mouseAction

document.addEventListener("keydown", keyDownHandler, false); //key押下時
document.addEventListener("keyup", keyUpHandler, false); //key押下時
document.addEventListener("mousemove", mouseMoveHandler, false); //マウス操作
document.addEventListener("click", mouseClickHandler, false); //マウスクリック
document.addEventListener("touchmove", sumartMoveHandler, false); //スマホ操作


function keyDownHandler(e) {
    console.log(e.keyCode);
    if(e.keyCode == 32){
    if(start == 0){
      dx = startalfa[startalfanum].x/10;
      dy = startalfa[startalfanum].y/10;
    }
      if(waitBall > 0){
        start = 1;
      }
      waitBall++;
    }
    if(e.keyCode == 38) {
        UpPressed = true;
    }
    else if(e.keyCode == 40) {
        DownPressed = true;
    }
    if(pause && pauseCase == 0){
    if(e.keyCode == 81) {
      pause=false;
      stopTimer();
      //alert("Q");
       const TG = tyrano.plugin.kag;
       const tmp = TG.stat.is_strong_stop;
       TG.stat.is_strong_stop = true;
       tyrano.plugin.kag.ftag.startTag('jump', {
     	storage: "returns.ks",
       });
       if (!tmp) TG.stat.is_strong_stop = false;
    }
    }
    //デバッグ用-----------------
    if(debugModeCommand){
    if(e.keyCode == 84){
      if(debugMode){
        debugMode = false;
      }else{
        debugMode = true;
      }
    }
    if(e.keyCode == 89){
      skillgageGback = 90;
      skillgageLaser = 90;
      skillgageEliminate = 90;
    }
    }

}
function keyUpHandler(e) {
    if(e.keyCode == 90){
        if(pause){
          pause = false;
        }else{
          pause = true;
        }
        pauseCase = 0;
    }
    if(start == 1){
    if(!pause){
    if(e.keyCode == 83){
      if(skillgageLaser == 90){
      var sound = new Audio('data/sound/laser1.ogg');
      sound.play();
      skillgageLaser =0;
      pauseCase = 1;
      pause = true;
      skillTime = time +90;
      if(skillTime>2000){
        skillTime -=2000;
      }
      var sClear = Math.floor((paddleY+50)/brickHeight);
      for(var c=0; c<brickColumnCount; c++) {
          var b = bricks[c][sClear];
          var bb = bricks[c][sClear-1];
          var bbb = bricks[c][sClear+1];
          if(b.status == 1) {
            b.status = 0;
          }
          if(bb.status == 1) {
            bb.status = 0;
          }
          if(bbb.status == 1) {
            bbb.status = 0;
          }
      }
    }
    }
    if(e.keyCode == 68){
    if(skillgageGback == 90){
      skillgageGback = 0;
      pauseCase = 2;
      pause = true;
      skillTime = time + gbackWaitTime;
      if(skillTime>2000){
        skillTime -=2000;
      }
      var sClear = Math.floor(paddleY/brickHeight);
      for(var c=0; c<brickColumnCount; c++) {
        for(var i = 0; i<6; i++){
          var b = bricks[c][sClear+i];
          if(b.status == 1){
            backGX = b.x;
            backGXX = c;
            backGXY = sClear;
            return;
            }
          }
      }
      backGX = $('canvas')[0].width-ballRadius-140;
      backGXX = brickColumnCount-1;
      backGXY = sClear ;
      isBackGXX = true;
      }
    }

    if(e.keyCode == 65){
      if(skillgageEliminate==90){
      //skillgageEliminate = 0;
      isEnatlation = false;
      enatlation = 1 ;
      skillTimeEnalation = time +enatlationWaitTime;
      skillTimeEnalationOrigin = time;
      }
    }
    }
    }
    if(e.keyCode == 38) {
        UpPressed = false;
    }
    else if(e.keyCode == 40) {
        DownPressed = false;
    }

}

function mouseMoveHandler(e) {
	if(pause) return;
    var canvas_ob = document.getElementById("canvas");
    var windowRatio = window.innerHeight/canvas_ob.height;
    if(window.innerHeight<=canvas_ob.height){
      var topMargin = 0;
      var relativeY = (e.clientY - topMargin)/windowRatio;
    }else{
      var topMargin = window.innerHeight/2 - canvas_ob.height/2;
      var relativeY = e.clientY - topMargin;
    }
    if(relativeY < canvas_ob.height -paddleHeight/2 && relativeY > paddleHeight/2){
        paddleY = relativeY - paddleHeight/2;
    }
    if(start == 0){
      y = paddleY+50;
    }
}

function debugText(b , text){
      if(debugMode){
      alert("ボールの座標:( " +x+ " , "+ y + " )\n"+
      "前ボール座標:( " +lastx+ " , "+ lasty + " )\n"+
      "ブロクの座標:( " +b.x+" , "+ b.y + " )\n"+
      "ボール加速度:( " +dx +" , "+ dy + " )\n"+
      "結果:"+text);
      }
}



function sumartMoveHandler(e) {
    e.preventDefault();
    var canvas_ob = document.getElementById("canvas");
    var windowRatio = window.innerWidth/canvas_ob.width;
    if(window.innerWidth<=canvas_ob.width){
      var leftMargin = 0;
      var relativeX = (e.changedTouches[0].pageX - leftMargin)/windowRatio;
    }else{
      var leftMargin = window.innerWidth /2 - canvas_ob.width/2;
      var relativeX = e.changedTouches[0].pageX - leftMargin;
    }
    //console.log(relativeX);
    if(debug==3){
      //console.log("windowsize:"+window.innerWidth+" leftMargin: "+leftMargin+" relativeX:"+relativeX);
    }
    if(relativeX > canvas_ob.width*0.06+paddleWidth/2 && relativeX < canvas_ob.width*0.94-paddleWidth/2) {
      paddleX = relativeX - paddleWidth/2;
    if(start == 0){
      x = relativeX ;
    }
    serch = relativeX;
    }
}


function mouseClickHandler(e){
  if(start == 0){
    dx = startalfa[startalfanum].x/10;
    dy = startalfa[startalfanum].y/10;
  }
  if(waitBall > 0){
    start = 1;
  }
  waitBall++;
}
//--------------------------------------------------------key＆mouseAction:end


//--------------------------------------------------------ボールの描画
function drawBall() {
    if(start!=1){
      ctx.beginPath();
      ctx.moveTo(x,y);
      ctx.lineTo(x+startalfa[startalfanum].x,y+startalfa[startalfanum].y);
      ctx.closePath();
    }
    ctx.stroke();
    ctx.beginPath();
    ctx.arc(x, y, ballRadius, 0, Math.PI*2 , false);
    if(enatlation == 0){
      ctx.fillStyle = 'rgb(0, 0, 0)';
    }else{
      ctx.fillStyle = 'rgb(255, 0, 0)';
    }
    ctx.fill();
    ctx.closePath();
}
//--------------------------------------------------------ボールの描画:end

//----------------------------画像をプリロード


var imgs_url= [
  "data/bgimage/paddle.png",
  "data/bgimage/rst1.png",
  "data/bgimage/rst2.png",
  "data/bgimage/pause.png",
  "data/bgimage/laser1.png",
  "data/bgimage/laser2.png",
  "data/bgimage/laser3.png",
  "data/bgimage/bakuhatu.png",
  "data/bgimage/skill3.png",
  "data/bgimage/skill2.png",
  "data/bgimage/skill1.png"
];
var imgs = new Array(imgs_url.length);
for(var i =0 ;i < imgs.length;i++){
  imgs[i] = new Image();
  imgs[i].src = imgs_url[i];
  prelord(i);
}

function prelord(num){
  imgs[num].onload = function(){
  var img = document.createElement('img');
  img.src = imgs_url[num];
  }
}

//---------------------------プリロード終了


//--------------------------------------------------------パドル(バー)の描画
function drawPaddle() {
      ctx.drawImage(imgs[0],paddleX,paddleY,paddleWidth, paddleHeight);
      ctx.font = '24pt Arial';
      ctx.fillStyle = 'rgb(0, 0, 0)';
      ctx.fillText(elife1, 1225, 90);
      if(elife1 == 0){
      elose1 = 10;
      tf.elose1 = elose1;
      stopTimer();
        //alert("GAME OVER");
      //}
    }
}
//--------------------------------------------------------パドル(バー)の描画:end

//--------------------------------------------------------ブロックの描画
function drawBricks() {
    brickCum = 0;
    //var imgblock = new Image();
    //imgblock.src = "data/bgimage/neko1.png";
    //imgblock.onload = function(){
    for(var c=0; c<brickColumnCount; c++) {
        for(var r=0; r<brickRowCount; r++) {
            if(bricks[c][r].status == 1) {
                brickCum++;
                var brickX = (c*(brickWidth+brickPadding))+brickOffsetLeft;
                var brickY = (r*(brickHeight+brickPadding))+brickOffsetTop;
                bricks[c][r].x = brickX;
                bricks[c][r].y = brickY;
                ctx.drawImage(imgs[1],brickX,brickY,brickWidth,brickHeight,brickX,brickY,brickWidth,brickHeight);
                //----------------デバッグ用
                if(debug ==2){
                ctx.beginPath();
                ctx.rect(brickX, brickY, brickWidth, brickHeight);
                ctx.stroke();
                ctx.closePath();
                }
                //----------------デバッグ用:end
            }

        }
    }
    if(debug >0){
    ctx.font = '20pt Arial';
    ctx.fillStyle = 'rgb(0, 0, 0)';
    ctx.fillText(brickCum, 1215, 170);
    //alert("a");
    //}
    }
}
//--------------------------------------------------------ブロックの描画:end

//--------------------------------------------------------画像描画
function drawFrontImage(){
  //var imgblock = new Image();
   //imgblock.src = "data/bgimage/bg21d.png";
   //imgblock.src = "data/bgimage/neko2.png";
   //imgblock.onload = function(){
     ctx.drawImage(imgs[2],0,0,$('canvas')[0].width,$('canvas')[0].height);
     drawBall();
     //}
     drawPaddle();
}
//--------------------------------------------------------画像描画:end


function collisionDetection() {
    var clear = 0;
    for(var c=0; c<brickColumnCount; c++) {
        for(var r=0; r<brickRowCount; r++) {
            var b = bricks[c][r];
            if(b.status == 1) {
                clear++;
                if(x >= b.x && x <= b.x+brickWidth && y >= b.y && y <= b.y+brickHeight) {
                  b.status = 0;
                  score += 100;
		              var sound = new Audio('data/sound/brk.ogg');
                  sound.play();
                  if(enatlation == 0){
                  if((b.x < lastx) && ((b.x + brickWidth) > lastx)){
                    debugText(b , "上下侵入　y反転");
                    if(b.y-lasty>0){
                        y = b.y - ballRadius;
                    }else if(b.y-lasty<0){
                        y = b.y + brickHeight;
                    }
                    dy = -dy;
                      return;
                  }
                  if((b.y < lasty) && ((b.y + brickHeight) > lasty)){
                    debugText(b , "左右侵入　x反転");
                    if(b.x-lastx>0){
                        x = b.x - ballRadius;
                    }else if(b.x-lastx<0){
                        x = b.x + brickWidth +ballRadius;
                    }
                    dx = -dx;
                    return;
                  }
                  var lostX = b.x-lastx;
                  if(lostX<0){
                    lostX = -lostX;
                  }
                  if(lostX>brickWidth){
                    lostX -= brickWidth;
                  }
                  var lostY = b.y-lasty;
                  if(lostY<0){
                    lostY = -lostY;
                  }
                  if(lostY>brickHeight){
                    lostY -= brickHeight;
                  }
                  if(lostX<lostY){
                    debugText(b , "斜め侵入　y反転");
                    if(b.y-lasty>0){
                      if(bricks[c][r-1].status == 1){
                        debugText(b, "上にブロックあったわ");
                        dx = -dx;
                        if(b.x-lastx>0){
                            x = b.x - ballRadius;
                        }else if(b.x-lastx<0){
                            x = b.x + brickWidth +ballRadius;
                        }
                        return;
                      }
                    }
                    if(b.y-lasty<0){
                      if(bricks[c][r+1].status == 1){
                        debugText(b,"下にブロックあったわ");
                        dx = -dx;
                        if(b.x-lastx>0){
                            x = b.x - ballRadius;
                        }else if(b.x-lastx<0){
                            x = b.x + brickWidth +ballRadius;
                        }
                        return;
                      }
                    }
                    dy = -dy;
                    if(b.y-lasty>0){
                        y = b.y - ballRadius;
                    }else if(b.y-lasty<0){
                        y = b.y + brickHeight;
                    }
                    return;
                  }
                  if(lostX>lostY){
                    debugText(b , "斜め侵入　x反転");
                    if(b.x-lastx>0){
                      if(bricks[c-1][r].status ==1){
                        debugText(b,"左にブロックあったわ");
                        dy = -dy;
                        if(b.y-lasty>0){
                            y = b.y - ballRadius;
                        }else if(b.y-lasty<0){
                            y = b.y + brickHeight;
                        }
                        return;
                        }
                    }
                    if(b.x-lastx<0){
                      if(bricks[c+1][r].status ==1){
                        debugText(b,"右にブロックあったわ");
                        dy = -dy;
                        if(b.y-lasty>0){
                            y = b.y - ballRadius;
                        }else if(b.y-lasty<0){
                            y = b.y + brickHeight;
                        }
                        return;
                        }
                      }
                      dx = -dx;
                      if(b.x-lastx>0){
                          x = b.x - ballRadius;
                      }else if(b.x-lastx<0){
                          x = b.x + brickWidth +ballRadius;
                      }
                      return;
                    }
                  //斜めから侵入時処理：デバッグ用
                  debugText(b,"斜め");
                  dx = -dx;
                  dy = -dy;
                  }
                }
            }
        }
    }
    if(clear == 0){
      eflag1 = 10;
      tf.score = score;
      tf.eflag1 = eflag1;
      stopTimer();
      //alert("clear");
    }
}

function ballStart(){
  lastx=x;
  lasty=y;
  x += dx;
  y += dy;
}

function restart(){
  if(time<2000){
    time++;
  }else{
    time=0;
  }
  if(time%40 == 0 ){
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

function systemGback(c , r){
  for(var i = 0; i<11; i++){
    for(var ii = 0 ; ii < 3 ; ii++){
      if(!isBackGXX){
        if(!(r+i-3<0) && !(r+i-3 > brickRowCount-1)){
          var b = bricks[c+ii][r+i-3];
          b.status = 0;
        }
      }
      if(i<5){
        if(!(r-ii<0)){
          var b = bricks[c-i][r-ii];
          b.status = 0;
        }
        if(!(r+ii+5>brickRowCount-1)){
          var b = bricks[c-i][r+ii+5];
          b.status = 0;
        }
      }
    }
    //b.status = 0;
  }
}

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
  ctx.fillStyle = 'rgba(255, 0, 0,0.5)';
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
  ctx.fillStyle = 'rgba(0, 255, 0,0.5)';
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
  ctx.fillStyle = 'rgba(0, 0, 255,0.5)';
  ctx.fillRect(1170, 575-skillgageGback, 90, 0 +skillgageGback);
  if(skillgageGback == 90 && !(time%20 == 0)){
    ctx.font = '12pt Impact';
    ctx.fillStyle = 'rgb(0, 0, 0)';
    ctx.fillText('press D', 1190,570);
  }
  ctx.fill();
  ctx.closePath();
}

function memori(){
  ctx.font = '8pt Arial';
  for(var i = 100; i<1160;i+=20){
    ctx.fillText(i/20-5, i, 20);
    ctx.fillText(i/20-5, i, 710);
  }
  for(var i = 0; i<720;i+=20){
    ctx.fillText(i/20-1, 100, i);
    ctx.fillText(i/20-1, 1140, i);
  }
}


function draw() {
    if(pause) {
    if(pauseCase == 0){
      ctx.beginPath();
      ctx.font = '24pt Arial';
      ctx.fillStyle = 'rgb(0, 0, 0)';
      ctx.fillText('PAUSE', $('canvas')[0].width/2-100,$('canvas')[0].height/2);
      ctx.font = '18pt Arial';
      ctx.fillText('back to press Z key', $('canvas')[0].width/2-150,$('canvas')[0].height/2+30);
      ctx.fillText('back title to press Q key', $('canvas')[0].width/2-140,$('canvas')[0].height/2+60);
      ctx.fillStyle = 'rgba(0, 200, 200,0.005)';
      ctx.fillRect(0, 0, $('canvas')[0].width,$('canvas')[0].height);
      ctx.fill();
      ctx.closePath();


    }
    if(pauseCase == 1){
      drawFrontImage();
      drawBricks();
      var timeasist = skillTime -time;
      //console.log(timeasist);
      ctx.beginPath();
      ctx.fillStyle = 'rgba(0, 0, 0,0.5)';
      ctx.fillRect(100, 0, 1050, 720);
      ctx.fill();
      ctx.closePath();
      var paddleyyy = 25;
      if(timeasist>70){

      }else if(timeasist>60){
        ctx.drawImage(imgs[4],paddleX+100,paddleY+paddleyyy,$('canvas')[0].width-ballRadius-240, paddleHeight-50);
      }else if(timeasist>50){
        ctx.drawImage(imgs[5],paddleX+100,paddleY+paddleyyy,$('canvas')[0].width-ballRadius-240, paddleHeight-50);
      }else if(timeasist>40){
        ctx.drawImage(imgs[6],paddleX+100,paddleY+paddleyyy,$('canvas')[0].width-ballRadius-240, paddleHeight-50);
      }else if(timeasist>30){
        ctx.drawImage(imgs[5],paddleX+100,paddleY+paddleyyy,$('canvas')[0].width-ballRadius-240, paddleHeight-50);
      }else if(timeasist>20){
        ctx.drawImage(imgs[4],paddleX+100,paddleY+paddleyyy,$('canvas')[0].width-ballRadius-240, paddleHeight-50);
      }else{

      }
      if(skillTime == time){
        pause =false;
        skillTime = 0;
      }
      restart();
    }
    if(pauseCase == 2){
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
    return;
    }
    if(y + dy < ballRadius) {
      dy = -dy;
    } else if(y + dy > $('canvas')[0].height - ballRadius) {
      dy = -dy;
    }
    if(enatlation == 1){
      if(skillgageEliminate==0){
        enatlation = 0;
      }
      if(skillgageEliminate>0 && time%2 == 0){
      skillgageEliminate--;
      }
    }
    skillTimeEnalationOrigin++;
    if(skillTimeEnalation == skillTimeEnalationOrigin){
      //enatlation =0;
      isEnatlation = true;
    }
    if(start ==1){
      ballStart();
    }
    drawFrontImage();
    drawBricks();
    collisionDetection();

    if(x + dx  > $('canvas')[0].width-ballRadius-140) {
        dx = -dx;
    }else if(x + dx -100 < ballRadius){
      if(y > paddleY && y< paddleY + paddleHeight){
        dx = -dx;
        if(y<paddleY + 30){
         if(dy>0){
            dy = -dy;
         }else if( dy == 0){
            dx = 3;
            dy = -7;
         }
        }
        if(y>paddleY+70){
         if(dy<0){
            dy = -dy;
         }else if(dy == 0){
            dx = 3;
            dy = 7;
         }
        }
      }else{
      start = 0;
      y = paddleY+50;
      dx = -dx;
      elife1 --;
      }
    }

    if(UpPressed && paddleY > 0) {
        paddleY -= 10;
        if(start ==0){
          y = paddleY + paddleHeight/2;
          serch = x;
        }
    }
    else if(DownPressed && paddleY < 720-paddleHeight) {
        paddleY += 10;
        if(start ==0){
          y = paddleY + paddleHeight/2;
          serch = x;
        }
        if(paddleY > 620){
        paddleY = 619;
        }
    }
    restart();
    drawSkillGage();
    //memori();
    ctx.beginPath();
    ctx.font = '24pt Impact';
    ctx.fillStyle = 'rgb(0, 0, 0)';
    ctx.fillText(score, 1170,700);
    ctx.closePath();
//;-----------------------------------------------------書き換え用
    if(time%1==0){
      if(start != 0){
      score-=scoreDegTime; //ここが割って0の時
      }
    }
}

var interval = setInterval(draw, 20);
function stopTimer(){
    clearInterval(interval);
}
[endscript]


;-----------------------------------------------------ティラノ判定処理
*fcheck1
[if exp="tf.elose1 < 5 "]
[else]
@jump target=*elose1
[endif]

[if exp="tf.eflag1 < 5 "]
@jump target=*fcheck1
[else]
@jump target=*ewin1
[endif]
[s]
;-----------------------------------------------------ティラノ判定処理終了

;-----------------------------------------------------負け処理
*elose1
@title name="ゲームオーバー"

[bg  storage="rst1.png" time="10"  ]
@eval exp="tf.elose1=tf.elose1==0"
[iscript]
//キャンバスの全削除
$('canvas').remove();
[endscript]
@fadeoutbgm time=300
@wait time=300

@layopt layer=message0 visible=true
[position layer="message0" width=800 height=200 top=150 left=180 page=fore opacity=0 visible=true]
[position marginl=0 margint=0 marginr=0 marginb=0]

@image layer=2 storage=bgresult.png visible=true x = 0 y = 0 time = 500
@playbgm storage=rlose.ogg loop=false click=false volume="50"
@image layer=2 name=result storage=lose.png visible=true x = 262 y = 300 time = 500
@wait time=5300
@fadeoutbgm time=100
[bg  storage="stage6.png"  time="100"  ]

@jump target=*closes
[s]


[s]
;-----------------------------------------------------勝ち処理
*ewin1
@title name="ゲームクリア"
@eval exp="tf.eflag1=tf.eflag1==0"
[bg  storage="rst2.png" time="10"  ]
[iscript]
//キャンバスの全削除
$('canvas').remove();
[endscript]

@fadeoutbgm time=300
@wait time=300

@layopt layer=message0 visible=true
[position layer="message0" width=800 height=200 top=260 left=340 page=fore opacity=0 visible=true]
@cm
@clearfix
@image layer=2 storage=bgresult.png visible=true x = 0 y = 0 time = 500
@playse storage=rwin.ogg loop=false click=false sprite_time=0-1670
@image layer=2 name=result storage=win.png visible=true x = 262 y = 300 time = 500
@wait time=1000
@anim name=result top="-=300" effect=linear opacity=255  time=500
@playbgm storage=rwin.ogg loop=true click=false sprite_time=1600-16000
@wait time=1000
[font size=48 color=0xfdfd00 bold=true]
貴方のスコアは[emb exp="tf.score"]です。[r]
@wait time=200
報酬は…
@wait time=500

[if exp="tf.score > 50000 "]
おめでとう！[r]
@wait time=300
報酬ゲットだよ！
;-----------------------------------------------------書き換え用
;-----------------------------------------------------変数書き忘れ注意！！！！！！！！
@eval exp="sf.ri1stage1=true" 
@eval exp="sf.ri1normal1=true"
@eval exp="sf.ri1hard1=true" 
;-----------------------------------------------------変数書き忘れ注意！！！！！！！！
[else]
残念！[r]
スコアが足りないよ！[r]
@wait time=300
またチャレンジしてね！
[endif]

@wait time=300

*result
[button x=350 y=550 graphic= "title/twt1.png" enterimg="title/twt2.png" enterse=cur.ogg clickse=choice.ogg target="tweets"]
[button x=750 y=550 graphic="title/close1.png" enterimg="title/close2.png" target="closes"]
[s]




[s]
;-----------------------------------------------------書き換え用
*tweets
@wait time=300
[tb_twitter_share tweet_str="&'『ステージ1』『難易度：HARD』のスコアは' + tf.score + 'です。貴方も挑戦してみませんか？'" url="https://chloe.animelife.info" hashtags="リタのブロック崩し"]
@jump target=*result
[s]

*closes
[cm]
[breakgame]
[clearstack]
[clearfix]
[freeimage layer=0 time=100]
[freeimage layer=1 time=100]
[freeimage layer=2 time=100]
@layopt layer=message0 visible=false

@fadeoutbgm time=300
[bg  storage="stage6.png"  time="300"  ]

[jump  storage="ritasurvay01.ks"  target=""  ]
[s]




