@cancelskip
[title name="stage1"]
@bg storage=st11.png time=800
@playbgm  storage="bgm5.m4a" click=true

[playse storage=pr.m4a loop=false ]
@image storage=rule1.png visible=true x=0 y=0 time=500 layer=1 page=fore 
@wait time=1000

[p]

[playse storage=pr.m4a loop=false ]
[freeimage layer=1 time=100]
@image storage=rule2.png visible=true x=0 y=0 time=500 layer=1 page=fore 

[button x=125 y=250 graphic= "button/easy1.png" enterimg="button/easy2.png" enterse=cur.m4a clickse=choice.m4a target="easy"]
[button x=125 y=450 graphic= "button/normal1.png" enterimg="button/normal2.png" enterse=cur.m4a clickse=choice.m4a target="normal"]
[button x=125 y=650 graphic= "button/hard1.png" enterimg="button/hard2.png" enterse=cur.m4a clickse=choice.m4a target="hard"]
[button x=125 y=850 graphic= "button/vhard1.png" enterimg="button/vhard2.png" enterse=cur.m4a clickse=choice.m4a target="vhard"]

[s]

*easy
[title name="easy"]
@wait time=300
[cm]
[clearfix]
[freeimage layer=1 time=500]
[l]

@eval exp="tf.elose1=0"
@eval exp="tf.eflag1=0"
@bg storage=st1.png time=200
@image layer=1 storage=game.png visible=true top = 0 left = 0 time = 10

@wait time=200

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
var elife1 = 20;
var eflag1 = 0;
var elose1 = 0;
//-----------------------------------------------------キャンバスの初期設定:end

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
var ballRadius = 14;
var x = $('canvas')[0].width/2;
var y = $('canvas')[0].height-107;
var dx = +7;
var dy = -7;
var lastx = 0;
var lasty = 0;
var enatlation = 0;
var waitBall = 0;
var start = 0;
var serch = 0;
var serchX = 0;
var serchY = 0;
var isserchX = 0;
var isserchY = 0;
//----------------------------ボールの初期設定:end


//---------------------------パドル(バー)の初期設定
//@type paddleHeight バーの高さ
//@type paddleWidth バーの長さ
//@type paddleX バーのX座標
//@type rightPressed →key押下時の判定用
//@type leftPressed ←key押下時の判定用
var paddleHeight = 100;
var paddleWidth = 100;
var paddleX = ($('canvas')[0].width-paddleWidth)/2;
var rightPressed = false;
var leftPressed = false;
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
var brickRowCount =35;
var brickColumnCount = 26;
var brickWidth = 25;
var brickHeight = 25;
var brickPadding = 0;
var brickOffsetTop = 0;
var brickOffsetLeft = 50;
var bricks = [];　//ブロック生成ループ
//ブロック生成
for(var c=0; c<brickColumnCount; c++) {
    bricks[c] = [];
    for(var r=0; r<brickRowCount; r++) {
        if(r>3&&r<8 && c >12 && c<19){
          bricks[c][r] = { x: 0, y: 0, status: 1 };
        }else if(r>21 && r<31 && c < 14){
          bricks[c][r] = { x: 0, y: 0, status: 1 };
        }
        else{
          bricks[c][r] = { x: 0, y: 0, status: 0 };
        }
    }
}

//----------------------------ブロックの初期設定:end


//--------------------------------------------------ボール・パドル・ブロック：初期設定:end

//--------------------------------------------------------key＆mouseAction

document.addEventListener("keydown", keyDownHandler, false); //key押下時
document.addEventListener("keyup", keyUpHandler, false); //key押下時
document.addEventListener("mousemove", mouseMoveHandler, false); //マウス操作
document.addEventListener("click", mouseClickHandler, false); //マウスクリック
document.addEventListener("touchmove", sumartMoveHandler, false); //スマホ操作


function keyDownHandler(e) {
    if(e.keyCode == 32){
      if(waitBall > 0){
        start = 1;
      }
      waitBall++;
    }

    if(e.keyCode == 39) {
        rightPressed = true;
    }
    else if(e.keyCode == 37) {
        leftPressed = true;
    }

}
function keyUpHandler(e) {
    if(e.keyCode == 39) {
        rightPressed = false;
    }
    else if(e.keyCode == 37) {
        leftPressed = false;
    }
}

function mouseMoveHandler(e) {
    var canvas_ob = document.getElementById("canvas");
    var windowRatio = window.innerWidth/canvas_ob.width;
    if(window.innerWidth<=canvas_ob.width){
      var leftMargin = 0;
      var relativeX = (e.clientX - leftMargin)/windowRatio;
    }else{
      var leftMargin = window.innerWidth /2 - canvas_ob.width/2;
      var relativeX = e.clientX - leftMargin;
    }
    console.log(relativeX);
    if(debug==1){
      //console.log("windowsize:"+window.innerWidth+" leftMargin: "+leftMargin+" relativeX:"+relativeX + "canvassize:" + canvas_ob.width);
    }
    if(relativeX > canvas_ob.width*0.06+paddleWidth/2 && relativeX < canvas_ob.width*0.94-paddleWidth/2) {
        paddleX = relativeX - paddleWidth/2;
        if(start == 0){
          x = relativeX ;
        }
        serch = relativeX;
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
  if(waitBall > 0){
    start = 1;
  }
  waitBall++;
}
//--------------------------------------------------------key＆mouseAction:end


//--------------------------------------------------------ボールの描画
function drawBall() {
    ctx.beginPath();
    ctx.moveTo(x,y);
    if(start!=1){
    ctx.lineTo(serch+serchX,$('canvas')[0].height/2+300+serchY);
    //console.log((x-(serch+serchX))/10+" "+(($('canvas')[0].height/2+300+serchY)-y)/10);
    dx=-(x-(serch+serchX))/10;
    //dy=(($('canvas')[0].height/2+300+serchY)-y)/10);
    }
    ctx.closePath();
    ctx.stroke();
    ctx.beginPath();
    //ctx.clearRect(0, 0, $('canvas')[0].width, $('canvas')[0].height);キャンパスのくり抜き※こいつが悪い
    ctx.arc(x, y, ballRadius, 0, Math.PI*2 , false);
    if(enatlation == 0){
      ctx.fillStyle = 'rgb(30, 255, 255)';
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
  "data/bgimage/st1.png",
  "data/bgimage/st2.png"
];
var imgs = new Array(imgs_url.length);
for(var i =0 ;i < imgs.length;i++){
  imgs[i] = new Image();
  imgs[i].src = imgs_url[i];
  imgs[i].onload = function(){
    var img = document.createElement('img');
    img.src = imgs_url[i];
    console.log("ok");
  }
}

//---------------------------プリロード終了


//--------------------------------------------------------パドル(バー)の描画
function drawPaddle() {
    //var paddleImg = new Image();
    //paddleImg.src = "data/bgimage/paddle.png";
    //paddleImg.onload = function(){
      ctx.drawImage(imgs[0],paddleX,$('canvas')[0].height-paddleHeight,paddleWidth, paddleHeight);
      ctx.font = '24pt Arial';
      ctx.fillStyle = 'rgb(255, 255, 255)';
      ctx.fillText(elife1, 4, 94);
      if(elife1 == 0){
      elose1 += 10;
      tf.elose1 = elose1;
        //alert("GAME OVER");
      //}
    }
}
//--------------------------------------------------------パドル(バー)の描画:end

//--------------------------------------------------------ブロックの描画
function drawBricks() {
    brickCum = 0;
    //var imgblock = new Image();
    //imgblock.src = "data/bgimage/st1.png";
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
    ctx.fillStyle = 'rgb(255, 255, 255)';
    ctx.fillText(brickCum, 705, 94);
    //alert("a");
    //}
    }
}
//--------------------------------------------------------ブロックの描画:end

//--------------------------------------------------------画像描画
function drawFrontImage(){
  //var imgblock = new Image();
   //imgblock.src = "data/bgimage/bg21d.png";
   //imgblock.src = "data/bgimage/st2.png";
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
		  var sound = new Audio('data/sound/brk.m4a');
                  sound.play();
                  if(enatlation == 0){
                  if((b.x < lastx) && ((b.x + brickWidth) > lastx)){
                    //alert("X判定\n "+"lastx:"+lastx + " , BlockW:" + b.x +" , X: "+ x +"\nlasty:" + lasty +" , blockY:" + b.y + " , Y:"+y);
                    dy = -dy;
                      return;
                  }
                  if((b.y < lasty) && ((b.y + brickHeight) > lasty)){
                    //alert("y判定\n "+"lastx:"+lastx + " , BlockW:" + b.x +" , X: "+ x +"\nlasty:" + lasty +" , blockY:" + b.y+ " , Y:"+y);
                    dx = -dx;
                    return;
                  }
                  var lostX = b.x-lastx;
                  if(lostX<0){
                    lostX = -lostX;
                  }
                  var lostY = b.y-lasty;
                  if(lostY<0){
                    lostY = -lostY;
                  }
                  if(dy>0){
                      if(lostX<lostY){
                        dy = -dy;
                        return;
                      }
                      if(lostX>lostY){
                        dx = -dx;
                        return;
                      }
                  }
                  var anderY = b.y+brickHeight-lasty;
                  if(anderY<0){
                    anderY = -anderY;
                  }
                  if(dy<0){
                      if(lostX>anderY){
                        dy = -dy;
                        return;
                      }
                      if(lostX>anderY){
                        dx = -dx;
                        return;
                      }
                  }
                  //斜めから侵入時処理：デバッグ用
                  dx = -dx;
                  dy = -dy;

                  }
                }
            }
        }
    }
    if(clear == 0){
      eflag1 += 10;
      tf.eflag1 = eflag1;
      //alert("clear");
    }
}

function draw() {
    if(isserchX == 0){
       serchX+=3;
    }else{
       serchX-=3;
    }
    if(serchX > 100){
      isserchX =1;
      isserchY =1;
    }else if(serchX<-100){
     isserchX = 0;
     isserchY = 1;
    }else if(serchX==0){
     isserchY = 0;
    }
    if(isserchY == 0){
       serchY +=2;
    }else{
       serchY -=2;
    }
    if(y + dy < ballRadius) {
      dy = -dy;
    } else if(y + dy > $('canvas')[0].height-ballRadius-paddleHeight+10) {
      if(x > paddleX && x < paddleX + paddleWidth) {
        enatlation = 0;
        dy = -dy;
      }else {
        elife1--;
        start = 0;
        enatlation = 0;
        x = paddleX + paddleWidth/2 ;
        y = $('canvas')[0].height-107;
      }
    }
    if(start ==1){
    lastx=x;
    lasty=y;
    x += dx;
    y += dy;
    }
    drawFrontImage();
    drawBricks();
    collisionDetection();

    if(x + dx +50 > $('canvas')[0].width-ballRadius || x + dx -50 < ballRadius) {
        if( y > 200 && y < 400 ){
          enatlation = 1;
        }
        dx = -dx;
    }

    if(rightPressed && paddleX < 600) {
        paddleX += 7;
        if(start ==0){
          x = paddleX + paddleWidth/2;
          serch = x;
        }
    }
    else if(leftPressed && paddleX > 50) {
        paddleX -= 7;
        if(start ==0){
          x = paddleX + paddleWidth/2;
          serch = x;
        }
    }

}

var interval = setInterval(draw, 20);

[endscript]

*fchecke1
[if exp=" tf.elose1 < 5 "]
[else]
@jump target=*ccanvase1
[endif]

[if exp=" tf.eflag1 < 5 "]
@jump target=*fchecke1
[else]
@jump target=*ccanvase1
[endif]

[s]

*ccanvase1

[if exp=" tf.elose1 < 5 "]
[else]
@jump target=*elose1
[endif]

[bg  storage="st2.png"  time="10"  ]
[iscript]
//キャンバスの全削除
$('canvas').remove();
[endscript]
;------------------------------------


[clearvar exp=tf.eflag1 ]
[clearstack]

@wait time=500
[image layer=2 storage=bgwin.png visible=true x = 0 y = 0 time = 500 ]
[playse storage=power.m4a loop=false ]
[image layer=2 storage=clear11.png visible=true x = 75 y = 455 time = 500 ]
@wait time=1500

@layopt layer=0 visible=false
@layopt layer=1 visible=false
@layopt layer=2 visible=false

@freeimage layer=0 time=100
@freeimage layer=1 time=100
@freeimage layer=2 time=100

@layopt layer=0 visible=true
@layopt layer=1 visible=true
@layopt layer=2 visible=true

[jump  storage="bst2.ks"  target="easy1-2"  ]

[s]

*elose1

[iscript]
//キャンバスの全削除
$('canvas').remove();
[endscript]
;------------------------------------

[clearvar  exp=tf.elose1 ]
[clearstack]

@fadeoutbgm time=500
@wait time=500
[image layer=2 storage=bglose.png visible=true x = 0 y = 0 time = 500 ]
[playse storage=lose.m4a loop=false ]
[image layer=2 storage=lose.png visible=true x = 75 y = 455 time = 500 ]
@wait time=3000

@image storage=retry.png  visible=true x=195 y=200 time=350 layer=2 page=fore 

[glink text='再挑戦' size=28 width=300 x=150 y=390 color=red target=*gb1]
[glink text='諦める' size=28 width=300 x=150 y=550 color=blue target=*gb2]

[s]

*gb1

@image storage=stage6.png  visible=true x=0 y=0 time=200 layer=2 page=fore 

[bg  storage="stage6.png"  time="500"  ]
@wait time=700

@layopt layer=0 visible=false
@layopt layer=1 visible=false
@layopt layer=2 visible=false

@freeimage layer=0 time=100
@freeimage layer=1 time=100
@freeimage layer=2 time=100

@layopt layer=0 visible=true
@layopt layer=1 visible=true
@layopt layer=2 visible=true


@wait time=500
[title name="connecting"]
[image layer=1 storage=w12.gif visible=true top = 420 left = 311 time = 200 ]
@wait time=1000
[freeimage layer=1 time=100]
[title name="easy"]

[bg  storage="st11.png"  time="500"  ]
[playbgm storage=bgm5.m4a click=true ]
@wait time=500

@jump target=easy

[s]

*gb2

[title name="faild"]
@image storage=stage6.png  visible=true x=0 y=0 time=200 layer=2 page=fore 
[bg  storage="stage6.png"  time="500"  ]
@wait time=500

@layopt layer=0 visible=false
@layopt layer=1 visible=false
@layopt layer=2 visible=false

@freeimage layer=0 time=10
@freeimage layer=1 time=10
@freeimage layer=2 time=10

@layopt layer=0 visible=true
@layopt layer=1 visible=true
@layopt layer=2 visible=true
[cm]
[clearfix]

[jump  storage="title1.ks"  target=""  ]

[s]


*normal
[title name="normal"]
@wait time=300
[cm]
[clearfix]
[freeimage layer=1 time=500]
[l]

@eval exp="tf.nlose1=0"
@eval exp="tf.nflag1=0"
@bg storage=st1.png time=200
@image layer=1 storage=game.png visible=true top = 0 left = 0 time = 10
@wait time=200

[layopt layer=0 visible=true]
[iscript]
//前景レイヤ0に、キャンバスを追加します
$('.0_fore').prepend('<canvas id="canvas" style="position:absolute;"></canvas>');
//メッセージより前に表示する場合は、以下を使用ください
//$('.message0_fore').prepend('<canvas id="canvas" style="position:absolute;z-index:1002"></canvas>');
var debug=1;
//2はブロック枠、1はブロック数描画、0はどっちも無し
//-----------------------------------------------------キャンバスの初期設定
$('canvas').attr('width', $('#tyrano_base').width());
$('canvas').attr('height', $('#tyrano_base').height());
var ctx = $('canvas')[0].getContext('2d');
var nlife1 = 20;
var nflag1 = 0;
var nlose1 = 0;
//-----------------------------------------------------キャンバスの初期設定:end

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
var ballRadius = 14;
var x = $('canvas')[0].width/2;
var y = $('canvas')[0].height-107;
var dx = +7;
var dy = -7;
var lastx = 0;
var lasty = 0;
var enatlation = 0;
var waitBall = 0;
var start = 0;
var serch = 0;
var serchX = 0;
var serchY = 0;
var isserchX = 0;
var isserchY = 0;
//----------------------------ボールの初期設定:end


//---------------------------パドル(バー)の初期設定
//@type paddleHeight バーの高さ
//@type paddleWidth バーの長さ
//@type paddleX バーのX座標
//@type rightPressed →key押下時の判定用
//@type leftPressed ←key押下時の判定用
var paddleHeight = 100;
var paddleWidth = 100;
var paddleX = ($('canvas')[0].width-paddleWidth)/2;
var rightPressed = false;
var leftPressed = false;
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
var brickRowCount =35;
var brickColumnCount = 26;
var brickWidth = 25;
var brickHeight = 25;
var brickPadding = 0;
var brickOffsetTop = 0;
var brickOffsetLeft = 50;
var bricks = [];　//ブロック生成ループ
//ブロック生成
for(var c=0; c<brickColumnCount; c++) {
    bricks[c] = [];
    for(var r=0; r<brickRowCount; r++) {
        if(r>3&&r<8 && c >12 && c<19){
          bricks[c][r] = { x: 0, y: 0, status: 1 };
        }else if(r>21 && r<31 && c < 14){
          bricks[c][r] = { x: 0, y: 0, status: 1 };
        }
        else{
          bricks[c][r] = { x: 0, y: 0, status: 0 };
        }
    }
}

//----------------------------ブロックの初期設定:end


//--------------------------------------------------ボール・パドル・ブロック：初期設定:end

//--------------------------------------------------------key＆mouseAction

document.addEventListener("keydown", keyDownHandler, false); //key押下時
document.addEventListener("keyup", keyUpHandler, false); //key押下時
document.addEventListener("mousemove", mouseMoveHandler, false); //マウス操作
document.addEventListener("click", mouseClickHandler, false); //マウスクリック
document.addEventListener("touchmove", sumartMoveHandler, false); //スマホ操作


function keyDownHandler(e) {
    if(e.keyCode == 32){
      if(waitBall > 0){
        start = 1;
      }
      waitBall++;
    }

    if(e.keyCode == 39) {
        rightPressed = true;
    }
    else if(e.keyCode == 37) {
        leftPressed = true;
    }
}
function keyUpHandler(e) {
    if(e.keyCode == 39) {
        rightPressed = false;
    }
    else if(e.keyCode == 37) {
        leftPressed = false;
    }
}

function mouseMoveHandler(e) {
    var canvas_ob = document.getElementById("canvas");
    var windowRatio = window.innerWidth/canvas_ob.width;
    if(window.innerWidth<=canvas_ob.width){
      var leftMargin = 0;
      var relativeX = (e.clientX - leftMargin)/windowRatio;
    }else{
      var leftMargin = window.innerWidth /2 - canvas_ob.width/2;
      var relativeX = e.clientX - leftMargin;
    }
    console.log(relativeX);
    if(debug==1){
      //console.log("windowsize:"+window.innerWidth+" leftMargin: "+leftMargin+" relativeX:"+relativeX + "canvassize:" + canvas_ob.width);
    }
    if(relativeX > canvas_ob.width*0.06+paddleWidth/2 && relativeX < canvas_ob.width*0.94-paddleWidth/2) {
        paddleX = relativeX - paddleWidth/2;
        if(start == 0){
          x = relativeX ;
        }
        serch = relativeX;
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
  if(waitBall > 0){
    start = 1;
  }
  waitBall++;
}
//--------------------------------------------------------key＆mouseAction:end


//--------------------------------------------------------ボールの描画
function drawBall() {
    ctx.beginPath();
    ctx.moveTo(x,y);
    if(start!=1){
    ctx.lineTo(serch+serchX,$('canvas')[0].height/2+300+serchY);
    //console.log((x-(serch+serchX))/10+" "+(($('canvas')[0].height/2+300+serchY)-y)/10);
    dx=-(x-(serch+serchX))/10;
    //dy=(($('canvas')[0].height/2+300+serchY)-y)/10);
    }
    ctx.closePath();
    ctx.stroke();
    ctx.beginPath();
    //ctx.clearRect(0, 0, $('canvas')[0].width, $('canvas')[0].height);キャンパスのくり抜き※こいつが悪い
    ctx.arc(x, y, ballRadius, 0, Math.PI*2 , false);
    if(enatlation == 0){
      ctx.fillStyle = 'rgb(30, 255, 255)';
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
  "data/bgimage/st1.png",
  "data/bgimage/st2.png"
];
var imgs = new Array(imgs_url.length);
for(var i =0 ;i < imgs.length;i++){
  imgs[i] = new Image();
  imgs[i].src = imgs_url[i];
  imgs[i].onload = function(){
    var img = document.createElement('img');
    img.src = imgs_url[i];
    console.log("ok");
  }
}

//---------------------------プリロード終了


//--------------------------------------------------------パドル(バー)の描画
function drawPaddle() {
    //var paddleImg = new Image();
    //paddleImg.src = "data/bgimage/paddle.png";
    //paddleImg.onload = function(){
      ctx.drawImage(imgs[0],paddleX,$('canvas')[0].height-paddleHeight,paddleWidth, paddleHeight);
      ctx.font = '24pt Arial';
      ctx.fillStyle = 'rgb(255, 255, 255)';
      ctx.fillText(nlife1, 4, 94);
      if(nlife1 == 0){
      nlose1 += 10;
      tf.nlose1 = nlose1;
        //alert("GAME OVER");
      }
    //}
}
//--------------------------------------------------------パドル(バー)の描画:end

//--------------------------------------------------------ブロックの描画
function drawBricks() {
    brickCum = 0;
    //var imgblock = new Image();
    //imgblock.src = "data/bgimage/st1.png";
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
    ctx.fillStyle = 'rgb(255, 255, 255)';
    ctx.fillText(brickCum, 705, 94);
    //alert("a");
    //}
    }
}
//--------------------------------------------------------ブロックの描画:end

//--------------------------------------------------------画像描画
function drawFrontImage(){
  //var imgblock = new Image();
   //imgblock.src = "data/bgimage/bg21d.png";
   //imgblock.src = "data/bgimage/st2.png";
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
		  var sound = new Audio('data/sound/brk.m4a');
                  sound.play();
                  if(enatlation == 0){
                  if((b.x < lastx) && ((b.x + brickWidth) > lastx)){
                    //alert("X判定\n "+"lastx:"+lastx + " , BlockW:" + b.x +" , X: "+ x +"\nlasty:" + lasty +" , blockY:" + b.y + " , Y:"+y);
                    dy = -dy;
                      return;
                  }
                  if((b.y < lasty) && ((b.y + brickHeight) > lasty)){
                    //alert("y判定\n "+"lastx:"+lastx + " , BlockW:" + b.x +" , X: "+ x +"\nlasty:" + lasty +" , blockY:" + b.y+ " , Y:"+y);
                    dx = -dx;
                    return;
                  }
                  var lostX = b.x-lastx;
                  if(lostX<0){
                    lostX = -lostX;
                  }
                  var lostY = b.y-lasty;
                  if(lostY<0){
                    lostY = -lostY;
                  }
                  if(dy>0){
                      if(lostX<lostY){
                        dy = -dy;
                        return;
                      }
                      if(lostX>lostY){
                        dx = -dx;
                        return;
                      }
                  }
                  var anderY = b.y+brickHeight-lasty;
                  if(anderY<0){
                    anderY = -anderY;
                  }
                  if(dy<0){
                      if(lostX>anderY){
                        dy = -dy;
                        return;
                      }
                      if(lostX>anderY){
                        dx = -dx;
                        return;
                      }
                  }
                  //斜めから侵入時処理：デバッグ用
                  dx = -dx;
                  dy = -dy;

                  }
                }
            }
        }
    }
    if(clear == 0){
      nflag1 += 10;
      tf.nflag1 = nflag1;
      //alert("clear");
    }
}

function draw() {
    if(isserchX == 0){
       serchX+=3;
    }else{
       serchX-=3;
    }
    if(serchX > 100){
      isserchX =1;
      isserchY =1;
    }else if(serchX<-100){
     isserchX = 0;
     isserchY = 1;
    }else if(serchX==0){
     isserchY = 0;
    }
    if(isserchY == 0){
       serchY +=2;
    }else{
       serchY -=2;
    }
    if(y + dy < ballRadius) {
      dy = -dy;
    } else if(y + dy > $('canvas')[0].height-ballRadius-paddleHeight+10) {
      if(x > paddleX && x < paddleX + paddleWidth) {
        enatlation = 0;
        dy = -dy;
      }else {
        nlife1--;
        start = 0;
        enatlation = 0;
        x = paddleX + paddleWidth/2 ;
        y = $('canvas')[0].height-107;
      }
    }
    if(start ==1){
    lastx=x;
    lasty=y;
    x += dx;
    y += dy;
    }
    drawFrontImage();
    drawBricks();
    collisionDetection();

    if(x + dx +50 > $('canvas')[0].width-ballRadius || x + dx -50 < ballRadius) {
        if( y > 200 && y < 400 ){
          enatlation = 1;
        }
        dx = -dx;
    }

    if(rightPressed && paddleX < 600) {
        paddleX += 7;
        if(start ==0){
          x = paddleX + paddleWidth/2;
          serch = x;
        }
    }
    else if(leftPressed && paddleX > 50) {
        paddleX -= 7;
        if(start ==0){
          x = paddleX + paddleWidth/2;
          serch = x;
        }
    }

}

var interval = setInterval(draw, 20);

[endscript]

*fcheckn1
[if exp=" tf.nlose1 < 5 "]
[else]
@jump target=*ccanvasn1
[endif]

[if exp=" tf.nflag1 < 5 "]
@jump target=*fcheckn1
[else]
@jump target=*ccanvasn1
[endif]

[s]

*ccanvasn1

[if exp=" tf.nlose1 < 5 "]
[else]
@jump target=*nlose1
[endif]

[bg  storage="st2.png"  time="10"  ]
[iscript]
//キャンバスの全削除
$('canvas').remove();
[endscript]
;------------------------------------


[clearvar exp=tf.nflag1 ]
[clearstack]

@wait time=500
[image layer=2 storage=bgwin.png visible=true x = 0 y = 0 time = 500 ]
[playse storage=power.m4a loop=false ]
[image layer=2 storage=clear11.png visible=true x = 75 y = 455 time = 500 ]
@wait time=1500

@layopt layer=0 visible=false
@layopt layer=1 visible=false
@layopt layer=2 visible=false

@freeimage layer=0 time=100
@freeimage layer=1 time=100
@freeimage layer=2 time=100

@layopt layer=0 visible=true
@layopt layer=1 visible=true
@layopt layer=2 visible=true

[jump  storage="bst2.ks"  target="normal1-2"  ]

[s]

*nlose1

[iscript]
//キャンバスの全削除
$('canvas').remove();
[endscript]
;------------------------------------

[clearvar  exp=tf.nlose1 ]
[clearstack]

@fadeoutbgm time=500
@wait time=500
[image layer=2 storage=bglose.png visible=true x = 0 y = 0 time = 500 ]
[playse storage=lose.m4a loop=false ]
[image layer=2 storage=lose.png visible=true x = 75 y = 455 time = 500 ]
@wait time=3000

@image storage=retry.png  visible=true x=195 y=200 time=350 layer=2 page=fore 

[glink text='再挑戦' size=28 width=300 x=150 y=390 color=red target=*gb3]
[glink text='諦める' size=28 width=300 x=150 y=550 color=blue target=*gb4]

[s]

*gb3

@image storage=stage6.png  visible=true x=0 y=0 time=200 layer=2 page=fore 

[bg  storage="stage6.png"  time="500"  ]
@wait time=700

@layopt layer=0 visible=false
@layopt layer=1 visible=false
@layopt layer=2 visible=false

@freeimage layer=0 time=100
@freeimage layer=1 time=100
@freeimage layer=2 time=100

@layopt layer=0 visible=true
@layopt layer=1 visible=true
@layopt layer=2 visible=true


@wait time=500
[title name="connecting"]
[image layer=1 storage=w12.gif visible=true top = 420 left = 311 time = 200 ]
@wait time=1000
[freeimage layer=1 time=100]
[title name="normal"]

[bg  storage="st11.png"  time="500"  ]
[playbgm storage=bgm5.m4a click=true ]
@wait time=500

@jump target=*normal

[s]

*gb4

[title name="faild"]
@image storage=stage6.png  visible=true x=0 y=0 time=200 layer=2 page=fore 
[bg  storage="stage6.png"  time="500"  ]
@wait time=500

@layopt layer=0 visible=false
@layopt layer=1 visible=false
@layopt layer=2 visible=false

@freeimage layer=0 time=100
@freeimage layer=1 time=100
@freeimage layer=2 time=100

@layopt layer=0 visible=true
@layopt layer=1 visible=true
@layopt layer=2 visible=true

[jump  storage="title1.ks"  target=""  ]

[s]


*hard
[title name="hard"]
@wait time=300
[cm]
[clearfix]
[freeimage layer=1 time=500]
[l]

@eval exp="tf.hlose1=0"
@eval exp="tf.hflag1=0"
@bg storage=st1.png time=200
@image layer=1 storage=game.png visible=true top = 0 left = 0 time = 10
@wait time=200

[layopt layer=0 visible=true]
[iscript]
//前景レイヤ0に、キャンバスを追加します
$('.0_fore').prepend('<canvas id="canvas" style="position:absolute;"></canvas>');
//メッセージより前に表示する場合は、以下を使用ください
//$('.message0_fore').prepend('<canvas id="canvas" style="position:absolute;z-index:1002"></canvas>');
var debug=1;
//2はブロック枠、1はブロック数描画、0はどっちも無し
//-----------------------------------------------------キャンバスの初期設定
$('canvas').attr('width', $('#tyrano_base').width());
$('canvas').attr('height', $('#tyrano_base').height());
var ctx = $('canvas')[0].getContext('2d');
var hlife1 = 15;
var hflag1 = 0;
var hlose1 = 0;
//-----------------------------------------------------キャンバスの初期設定:end

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
var ballRadius = 14;
var x = $('canvas')[0].width/2;
var y = $('canvas')[0].height-107;
var dx = +7;
var dy = -7;
var lastx = 0;
var lasty = 0;
var enatlation = 0;
var waitBall = 0;
var start = 0;
var serch = 0;
var serchX = 0;
var serchY = 0;
var isserchX = 0;
var isserchY = 0;
//----------------------------ボールの初期設定:end


//---------------------------パドル(バー)の初期設定
//@type paddleHeight バーの高さ
//@type paddleWidth バーの長さ
//@type paddleX バーのX座標
//@type rightPressed →key押下時の判定用
//@type leftPressed ←key押下時の判定用
var paddleHeight = 100;
var paddleWidth = 100;
var paddleX = ($('canvas')[0].width-paddleWidth)/2;
var rightPressed = false;
var leftPressed = false;
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
var brickRowCount =35;
var brickColumnCount = 26;
var brickWidth = 25;
var brickHeight = 25;
var brickPadding = 0;
var brickOffsetTop = 0;
var brickOffsetLeft = 50;
var bricks = [];　//ブロック生成ループ
//ブロック生成
for(var c=0; c<brickColumnCount; c++) {
    bricks[c] = [];
    for(var r=0; r<brickRowCount; r++) {
        if(r>3&&r<8 && c >12 && c<19){
          bricks[c][r] = { x: 0, y: 0, status: 1 };
        }else if(r>21 && r<31 && c < 14){
          bricks[c][r] = { x: 0, y: 0, status: 1 };
        }
        else{
          bricks[c][r] = { x: 0, y: 0, status: 0 };
        }
    }
}

//----------------------------ブロックの初期設定:end


//--------------------------------------------------ボール・パドル・ブロック：初期設定:end

//--------------------------------------------------------key＆mouseAction

document.addEventListener("keydown", keyDownHandler, false); //key押下時
document.addEventListener("keyup", keyUpHandler, false); //key押下時
document.addEventListener("mousemove", mouseMoveHandler, false); //マウス操作
document.addEventListener("click", mouseClickHandler, false); //マウスクリック
document.addEventListener("touchmove", sumartMoveHandler, false); //スマホ操作


function keyDownHandler(e) {
    if(e.keyCode == 32){
      if(waitBall > 0){
        start = 1;
      }
      waitBall++;
    }

    if(e.keyCode == 39) {
        rightPressed = true;
    }
    else if(e.keyCode == 37) {
        leftPressed = true;
    }
}
function keyUpHandler(e) {
    if(e.keyCode == 39) {
        rightPressed = false;
    }
    else if(e.keyCode == 37) {
        leftPressed = false;
    }
}


function mouseMoveHandler(e) {
    var canvas_ob = document.getElementById("canvas");
    var windowRatio = window.innerWidth/canvas_ob.width;
    if(window.innerWidth<=canvas_ob.width){
      var leftMargin = 0;
      var relativeX = (e.clientX - leftMargin)/windowRatio;
    }else{
      var leftMargin = window.innerWidth /2 - canvas_ob.width/2;
      var relativeX = e.clientX - leftMargin;
    }
    console.log(relativeX);
    if(debug==1){
      //console.log("windowsize:"+window.innerWidth+" leftMargin: "+leftMargin+" relativeX:"+relativeX + "canvassize:" + canvas_ob.width);
    }
    if(relativeX > canvas_ob.width*0.06+paddleWidth/2 && relativeX < canvas_ob.width*0.94-paddleWidth/2) {
        paddleX = relativeX - paddleWidth/2;
        if(start == 0){
          x = relativeX ;
        }
        serch = relativeX;
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
  if(waitBall > 0){
    start = 1;
  }
  waitBall++;
}
//--------------------------------------------------------key＆mouseAction:end


//--------------------------------------------------------ボールの描画
function drawBall() {
    ctx.beginPath();
    ctx.moveTo(x,y);
    if(start!=1){
    ctx.lineTo(serch+serchX,$('canvas')[0].height/2+300+serchY);
    //console.log((x-(serch+serchX))/10+" "+(($('canvas')[0].height/2+300+serchY)-y)/10);
    dx=-(x-(serch+serchX))/10;
    //dy=(($('canvas')[0].height/2+300+serchY)-y)/10);
    }
    ctx.closePath();
    ctx.stroke();
    ctx.beginPath();
    //ctx.clearRect(0, 0, $('canvas')[0].width, $('canvas')[0].height);キャンパスのくり抜き※こいつが悪い
    ctx.arc(x, y, ballRadius, 0, Math.PI*2 , false);
    if(enatlation == 0){
      ctx.fillStyle = 'rgb(30, 255, 255)';
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
  "data/bgimage/st1.png",
  "data/bgimage/st2.png"
];
var imgs = new Array(imgs_url.length);
for(var i =0 ;i < imgs.length;i++){
  imgs[i] = new Image();
  imgs[i].src = imgs_url[i];
  imgs[i].onload = function(){
    var img = document.createElement('img');
    img.src = imgs_url[i];
    console.log("ok");
  }
}

//---------------------------プリロード終了

//--------------------------------------------------------パドル(バー)の描画
function drawPaddle() {
    //var paddleImg = new Image();
    //paddleImg.src = "data/bgimage/paddle.png";
    //paddleImg.onload = function(){
      ctx.drawImage(imgs[0],paddleX,$('canvas')[0].height-paddleHeight,paddleWidth, paddleHeight);
      ctx.font = '24pt Arial';
      ctx.fillStyle = 'rgb(255, 255, 255)';
      ctx.fillText(hlife1, 4, 94);
      if(hlife1 == 0){
      hlose1 += 10;
      tf.hlose1 = hlose1;
        //alert("GAME OVER");
      //}
    }
}
//--------------------------------------------------------パドル(バー)の描画:end

//--------------------------------------------------------ブロックの描画
function drawBricks() {
    brickCum = 0;
    //var imgblock = new Image();
    //imgblock.src = "data/bgimage/st1.png";
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
    ctx.fillStyle = 'rgb(255, 255, 255)';
    ctx.fillText(brickCum, 705, 94);
    //alert("a");
    //}
    }
}
//--------------------------------------------------------ブロックの描画:end

//--------------------------------------------------------画像描画
function drawFrontImage(){
  //var imgblock = new Image();
   //imgblock.src = "data/bgimage/bg21d.png";
   //imgblock.src = "data/bgimage/st2.png";
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
		  var sound = new Audio('data/sound/brk.m4a');
                  sound.play();
                  if(enatlation == 0){
                  if((b.x < lastx) && ((b.x + brickWidth) > lastx)){
                    //alert("X判定\n "+"lastx:"+lastx + " , BlockW:" + b.x +" , X: "+ x +"\nlasty:" + lasty +" , blockY:" + b.y + " , Y:"+y);
                    dy = -dy;
                      return;
                  }
                  if((b.y < lasty) && ((b.y + brickHeight) > lasty)){
                    //alert("y判定\n "+"lastx:"+lastx + " , BlockW:" + b.x +" , X: "+ x +"\nlasty:" + lasty +" , blockY:" + b.y+ " , Y:"+y);
                    dx = -dx;
                    return;
                  }
                  var lostX = b.x-lastx;
                  if(lostX<0){
                    lostX = -lostX;
                  }
                  var lostY = b.y-lasty;
                  if(lostY<0){
                    lostY = -lostY;
                  }
                  if(dy>0){
                      if(lostX<lostY){
                        dy = -dy;
                        return;
                      }
                      if(lostX>lostY){
                        dx = -dx;
                        return;
                      }
                  }
                  var anderY = b.y+brickHeight-lasty;
                  if(anderY<0){
                    anderY = -anderY;
                  }
                  if(dy<0){
                      if(lostX>anderY){
                        dy = -dy;
                        return;
                      }
                      if(lostX>anderY){
                        dx = -dx;
                        return;
                      }
                  }
                  //斜めから侵入時処理：デバッグ用
                  dx = -dx;
                  dy = -dy;

                  }
                }
            }
        }
    }
    if(clear == 0){
      hflag1 += 10;
      tf.hflag1 = hflag1;
      //alert("clear");
    }
}

function draw() {
    if(isserchX == 0){
       serchX+=3;
    }else{
       serchX-=3;
    }
    if(serchX > 100){
      isserchX =1;
      isserchY =1;
    }else if(serchX<-100){
     isserchX = 0;
     isserchY = 1;
    }else if(serchX==0){
     isserchY = 0;
    }
    if(isserchY == 0){
       serchY +=2;
    }else{
       serchY -=2;
    }
    if(y + dy < ballRadius) {
      dy = -dy;
    } else if(y + dy > $('canvas')[0].height-ballRadius-paddleHeight+10) {
      if(x > paddleX && x < paddleX + paddleWidth) {
        enatlation = 0;
        dy = -dy;
      }else {
        hlife1--;
        start = 0;
        enatlation = 0;
        x = paddleX + paddleWidth/2 ;
        y = $('canvas')[0].height-107;
      }
    }
    if(start ==1){
    lastx=x;
    lasty=y;
    x += dx;
    y += dy;
    }
    drawFrontImage();
    drawBricks();
    collisionDetection();

    if(x + dx +50 > $('canvas')[0].width-ballRadius || x + dx -50 < ballRadius) {
        if( y > 200 && y < 400 ){
          enatlation = 1;
        }
        dx = -dx;
    }

    if(rightPressed && paddleX < 600) {
        paddleX += 7;
        if(start ==0){
          x = paddleX + paddleWidth/2;
          serch = x;
        }
    }
    else if(leftPressed && paddleX > 50) {
        paddleX -= 7;
        if(start ==0){
          x = paddleX + paddleWidth/2;
          serch = x;
        }
    }

}

var interval = setInterval(draw, 20);

[endscript]

*fcheckh1
[if exp=" tf.hlose1 < 5 "]
[else]
@jump target=*ccanvash1
[endif]

[if exp=" tf.hflag1 < 5 "]
@jump target=*fcheckh1
[else]
@jump target=*ccanvash1
[endif]

[s]

*ccanvash1

[if exp=" tf.hlose1 < 5 "]
[else]
@jump target=*hlose1
[endif]

[bg  storage="st2.png"  time="10"  ]
[iscript]
//キャンバスの全削除
$('canvas').remove();
[endscript]
;------------------------------------


[clearvar exp=tf.hflag1 ]
[clearstack]

@wait time=500
[image layer=2 storage=bgwin.png visible=true x = 0 y = 0 time = 500 ]
[playse storage=power.m4a loop=false ]
[image layer=2 storage=clear11.png visible=true x = 75 y = 455 time = 500 ]
@wait time=1500

@layopt layer=0 visible=false
@layopt layer=1 visible=false
@layopt layer=2 visible=false

@freeimage layer=0 time=100
@freeimage layer=1 time=100
@freeimage layer=2 time=100

@layopt layer=0 visible=true
@layopt layer=1 visible=true
@layopt layer=2 visible=true

[jump  storage="bst2.ks"  target="hard1-2"  ]

[s]

*hlose1

[iscript]
//キャンバスの全削除
$('canvas').remove();
[endscript]
;------------------------------------

[clearvar  exp=tf.hlose1 ]
[clearstack]

@fadeoutbgm time=500
@wait time=500
[image layer=2 storage=bglose.png visible=true x = 0 y = 0 time = 500 ]
[playse storage=lose.m4a loop=false ]
[image layer=2 storage=lose.png visible=true x = 75 y = 455 time = 500 ]
@wait time=3000

@image storage=retry.png  visible=true x=195 y=200 time=350 layer=2 page=fore 

[glink text='再挑戦' size=28 width=300 x=150 y=390 color=red target=*gb5]
[glink text='諦める' size=28 width=300 x=150 y=550 color=blue target=*gb6]

[s]

*gb5

@image storage=stage6.png  visible=true x=0 y=0 time=200 layer=2 page=fore 

[bg  storage="stage6.png"  time="500"  ]
@wait time=700

@layopt layer=0 visible=false
@layopt layer=1 visible=false
@layopt layer=2 visible=false

@freeimage layer=0 time=100
@freeimage layer=1 time=100
@freeimage layer=2 time=100

@layopt layer=0 visible=true
@layopt layer=1 visible=true
@layopt layer=2 visible=true


@wait time=500
[title name="connecting"]
[image layer=1 storage=w12.gif visible=true top = 420 left = 311 time = 200 ]
@wait time=1000
[freeimage layer=1 time=100]
[title name="hard"]

[bg  storage="st11.png"  time="500"  ]
[playbgm storage=bgm5.m4a click=true ]
@wait time=500

@jump target=*restart1

[s]

*gb6

[title name="faild"]
@image storage=stage6.png  visible=true x=0 y=0 time=200 layer=2 page=fore 
[bg  storage="stage6.png"  time="500"  ]
@wait time=500

@layopt layer=0 visible=false
@layopt layer=1 visible=false
@layopt layer=2 visible=false

@freeimage layer=0 time=100
@freeimage layer=1 time=100
@freeimage layer=2 time=100

@layopt layer=0 visible=true
@layopt layer=1 visible=true
@layopt layer=2 visible=true

[jump  storage="title1.ks"  target=""  ]

[s]

*vhard
[title name="vhard"]
@wait time=300
[cm]
[clearfix]
[freeimage layer=1 time=500]
[l]

@eval exp="tf.vlose1=0"
@eval exp="tf.vflag1=0"
@bg storage=st1.png time=200
@wait time=200

[layopt layer=0 visible=true]
[iscript]
//前景レイヤ0に、キャンバスを追加します
$('.0_fore').prepend('<canvas id="canvas" style="position:absolute;"></canvas>');
//メッセージより前に表示する場合は、以下を使用ください
//$('.message0_fore').prepend('<canvas id="canvas" style="position:absolute;z-index:1002"></canvas>');
var debug=0;
//2はブロック枠、1はブロック数描画、0はどっちも無し
//-----------------------------------------------------キャンバスの初期設定
$('canvas').attr('width', $('#tyrano_base').width());
$('canvas').attr('height', $('#tyrano_base').height());
var ctx = $('canvas')[0].getContext('2d');
var vlife1 = 10;
var vflag1 = 0;
var vlose1 = 0;
//-----------------------------------------------------キャンバスの初期設定:end

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
var ballRadius = 14;
var x = $('canvas')[0].width/2;
var y = $('canvas')[0].height-107;
var dx = +7;
var dy = -7;
var lastx = 0;
var lasty = 0;
var enatlation = 0;
var waitBall = 0;
var start = 0;
var serch = 0;
var serchX = 0;
var serchY = 0;
var isserchX = 0;
var isserchY = 0;
//----------------------------ボールの初期設定:end


//---------------------------パドル(バー)の初期設定
//@type paddleHeight バーの高さ
//@type paddleWidth バーの長さ
//@type paddleX バーのX座標
//@type rightPressed →key押下時の判定用
//@type leftPressed ←key押下時の判定用
var paddleHeight = 100;
var paddleWidth = 100;
var paddleX = ($('canvas')[0].width-paddleWidth)/2;
var rightPressed = false;
var leftPressed = false;
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
var brickRowCount =35;
var brickColumnCount = 26;
var brickWidth = 25;
var brickHeight = 25;
var brickPadding = 0;
var brickOffsetTop = 0;
var brickOffsetLeft = 50;
var bricks = [];　//ブロック生成ループ
//ブロック生成
for(var c=0; c<brickColumnCount; c++) {
    bricks[c] = [];
    for(var r=0; r<brickRowCount; r++) {
        if(r>3&&r<8 && c >12 && c<19){
          bricks[c][r] = { x: 0, y: 0, status: 1 };
        }else if(r>21 && r<31 && c < 14){
          bricks[c][r] = { x: 0, y: 0, status: 1 };
        }
        else{
          bricks[c][r] = { x: 0, y: 0, status: 0 };
        }
    }
}

//----------------------------ブロックの初期設定:end


//--------------------------------------------------ボール・パドル・ブロック：初期設定:end

//--------------------------------------------------------key＆mouseAction

document.addEventListener("keydown", keyDownHandler, false); //key押下時
document.addEventListener("keyup", keyUpHandler, false); //key押下時
document.addEventListener("mousemove", mouseMoveHandler, false); //マウス操作
document.addEventListener("click", mouseClickHandler, false); //マウスクリック
document.addEventListener("touchmove", sumartMoveHandler, false); //スマホ操作


function keyDownHandler(e) {
    if(e.keyCode == 32){
      if(waitBall > 0){
        start = 1;
      }
      waitBall++;
    }

    if(e.keyCode == 39) {
        rightPressed = true;
    }
    else if(e.keyCode == 37) {
        leftPressed = true;
    }
}
function keyUpHandler(e) {
    if(e.keyCode == 39) {
        rightPressed = false;
    }
    else if(e.keyCode == 37) {
        leftPressed = false;
    }
}

function mouseMoveHandler(e) {
    var canvas_ob = document.getElementById("canvas");
    var windowRatio = window.innerWidth/canvas_ob.width;
    if(window.innerWidth<=canvas_ob.width){
      var leftMargin = 0;
      var relativeX = (e.clientX - leftMargin)/windowRatio;
    }else{
      var leftMargin = window.innerWidth /2 - canvas_ob.width/2;
      var relativeX = e.clientX - leftMargin;
    }
    console.log(relativeX);
    if(debug==1){
      //console.log("windowsize:"+window.innerWidth+" leftMargin: "+leftMargin+" relativeX:"+relativeX + "canvassize:" + canvas_ob.width);
    }
    if(relativeX > canvas_ob.width*0.06+paddleWidth/2 && relativeX < canvas_ob.width*0.94-paddleWidth/2) {
        paddleX = relativeX - paddleWidth/2;
        if(start == 0){
          x = relativeX ;
        }
        serch = relativeX;
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
  if(waitBall > 0){
    start = 1;
  }
  waitBall++;
}
//--------------------------------------------------------key＆mouseAction:end


//--------------------------------------------------------ボールの描画
function drawBall() {
    ctx.beginPath();
    ctx.moveTo(x,y);
    if(start!=1){
    ctx.lineTo(serch+serchX,$('canvas')[0].height/2+300+serchY);
    //console.log((x-(serch+serchX))/10+" "+(($('canvas')[0].height/2+300+serchY)-y)/10);
    dx=-(x-(serch+serchX))/10;
    //dy=(($('canvas')[0].height/2+300+serchY)-y)/10);
    }
    ctx.closePath();
    ctx.stroke();
    ctx.beginPath();
    //ctx.clearRect(0, 0, $('canvas')[0].width, $('canvas')[0].height);キャンパスのくり抜き※こいつが悪い
    ctx.arc(x, y, ballRadius, 0, Math.PI*2 , false);
    if(enatlation == 0){
      ctx.fillStyle = 'rgb(30, 255, 255)';
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
  "data/bgimage/st1.png",
  "data/bgimage/st2.png"
];
var imgs = new Array(imgs_url.length);
for(var i =0 ;i < imgs.length;i++){
  imgs[i] = new Image();
  imgs[i].src = imgs_url[i];
  imgs[i].onload = function(){
    var img = document.createElement('img');
    img.src = imgs_url[i];
    console.log("ok");
  }
}

//---------------------------プリロード終了

//--------------------------------------------------------パドル(バー)の描画
function drawPaddle() {
    //var paddleImg = new Image();
    //paddleImg.src = "data/bgimage/paddle.png";
    //paddleImg.onload = function(){
      ctx.drawImage(imgs[0],paddleX,$('canvas')[0].height-paddleHeight,paddleWidth, paddleHeight);
      ctx.font = '24pt Arial';
      ctx.fillStyle = 'rgb(255, 255, 255)';
      ctx.fillText(vlife1, 4, 94);
      if(vlife1 == 0){
      vlose1 += 10;
      tf.vlose1 = vlose1;
        //alert("GAME OVER");
      //}
    }
}
//--------------------------------------------------------パドル(バー)の描画:end

//--------------------------------------------------------ブロックの描画
function drawBricks() {
    brickCum = 0;
    //var imgblock = new Image();
    //imgblock.src = "data/bgimage/st1.png";
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
    ctx.fillStyle = 'rgb(255, 255, 255)';
    ctx.fillText(brickCum, 705, 94);
    //alert("a");
    //}
    }
}
//--------------------------------------------------------ブロックの描画:end

//--------------------------------------------------------画像描画
function drawFrontImage(){
  var imgblock = new Image();
   //imgblock.src = "data/bgimage/bg21d.png";
   //imgblock.src = "data/bgimage/st2.png";
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
		  var sound = new Audio('data/sound/brk.m4a');
                  sound.play();
                  if(enatlation == 0){
                  if((b.x < lastx) && ((b.x + brickWidth) > lastx)){
                    //alert("X判定\n "+"lastx:"+lastx + " , BlockW:" + b.x +" , X: "+ x +"\nlasty:" + lasty +" , blockY:" + b.y + " , Y:"+y);
                    dy = -dy;
                      return;
                  }
                  if((b.y < lasty) && ((b.y + brickHeight) > lasty)){
                    //alert("y判定\n "+"lastx:"+lastx + " , BlockW:" + b.x +" , X: "+ x +"\nlasty:" + lasty +" , blockY:" + b.y+ " , Y:"+y);
                    dx = -dx;
                    return;
                  }
                  var lostX = b.x-lastx;
                  if(lostX<0){
                    lostX = -lostX;
                  }
                  var lostY = b.y-lasty;
                  if(lostY<0){
                    lostY = -lostY;
                  }
                  if(dy>0){
                      if(lostX<lostY){
                        dy = -dy;
                        return;
                      }
                      if(lostX>lostY){
                        dx = -dx;
                        return;
                      }
                  }
                  var anderY = b.y+brickHeight-lasty;
                  if(anderY<0){
                    anderY = -anderY;
                  }
                  if(dy<0){
                      if(lostX>anderY){
                        dy = -dy;
                        return;
                      }
                      if(lostX>anderY){
                        dx = -dx;
                        return;
                      }
                  }
                  //斜めから侵入時処理：デバッグ用
                  dx = -dx;
                  dy = -dy;

                  }
                }
            }
        }
    }
    if(clear == 0){
      vflag1 += 10;
      tf.vflag1 = vflag1;
      //alert("clear");
    }
}

function draw() {
    if(isserchX == 0){
       serchX+=3;
    }else{
       serchX-=3;
    }
    if(serchX > 100){
      isserchX =1;
      isserchY =1;
    }else if(serchX<-100){
     isserchX = 0;
     isserchY = 1;
    }else if(serchX==0){
     isserchY = 0;
    }
    if(isserchY == 0){
       serchY +=2;
    }else{
       serchY -=2;
    }
    if(y + dy < ballRadius) {
      dy = -dy;
    } else if(y + dy > $('canvas')[0].height-ballRadius-paddleHeight+10) {
      if(x > paddleX && x < paddleX + paddleWidth) {
        enatlation = 0;
        dy = -dy;
      }else {
        vlife1--;
        start = 0;
        enatlation = 0;
        x = paddleX + paddleWidth/2 ;
        y = $('canvas')[0].height-107;
      }
    }
    if(start ==1){
    lastx=x;
    lasty=y;
    x += dx;
    y += dy;
    }
    drawFrontImage();
    drawBricks();
    collisionDetection();

    if(x + dx +50 > $('canvas')[0].width-ballRadius || x + dx -50 < ballRadius) {
        if( y > 200 && y < 400 ){
          enatlation = 1;
        }
        dx = -dx;
    }

    if(rightPressed && paddleX < 600) {
        paddleX += 7;
        if(start ==0){
          x = paddleX + paddleWidth/2;
          serch = x;
        }
    }
    else if(leftPressed && paddleX > 50) {
        paddleX -= 7;
        if(start ==0){
          x = paddleX + paddleWidth/2;
          serch = x;
        }
    }

}

var interval = setInterval(draw, 20);

[endscript]

*fcheckv1
[if exp=" tf.vlose1 < 5 "]
[else]
@jump target=*ccanvasv1
[endif]

[if exp=" tf.vflag1 < 5 "]
@jump target=*fcheckv1
[else]
@jump target=*ccanvasv1
[endif]

[s]

*ccanvasv1

[if exp=" tf.vlose1 < 5 "]
[else]
@jump target=*vlose1
[endif]

[bg  storage="st2.png"  time="10"  ]
[iscript]
//キャンバスの全削除
$('canvas').remove();
[endscript]
;------------------------------------


[clearvar exp=tf.vflag1 ]
[clearstack]

@wait time=500
[image layer=2 storage=bgwin.png visible=true x = 0 y = 0 time = 500 ]
[playse storage=power.m4a loop=false ]
[image layer=2 storage=clear11.png visible=true x = 75 y = 455 time = 500 ]
@wait time=1500

@layopt layer=0 visible=false
@layopt layer=1 visible=false
@layopt layer=2 visible=false

@freeimage layer=0 time=100
@freeimage layer=1 time=100
@freeimage layer=2 time=100

@layopt layer=0 visible=true
@layopt layer=1 visible=true
@layopt layer=2 visible=true

[jump  storage="bst2.ks"  target="vhard1-2"  ]

[s]

*vlose1

[iscript]
//キャンバスの全削除
$('canvas').remove();
[endscript]
;------------------------------------

[clearvar  exp=tf.vlose1 ]
[clearstack]

@fadeoutbgm time=500
@wait time=500
[image layer=2 storage=bglose.png visible=true x = 0 y = 0 time = 500 ]
[playse storage=lose.m4a loop=false ]
[image layer=2 storage=lose.png visible=true x = 75 y = 455 time = 500 ]
@wait time=3000

@image storage=retry.png  visible=true x=195 y=200 time=350 layer=2 page=fore 

[glink text='再挑戦' size=28 width=300 x=150 y=390 color=red target=*gb7]
[glink text='諦める' size=28 width=300 x=150 y=550 color=blue target=*gb8]

[s]

*gb7

@image storage=stage6.png  visible=true x=0 y=0 time=200 layer=2 page=fore 

[bg  storage="stage6.png"  time="500"  ]
@wait time=700

@layopt layer=0 visible=false
@layopt layer=1 visible=false
@layopt layer=2 visible=false

@freeimage layer=0 time=100
@freeimage layer=1 time=100
@freeimage layer=2 time=100

@layopt layer=0 visible=true
@layopt layer=1 visible=true
@layopt layer=2 visible=true


@wait time=500
[title name="connecting"]
[image layer=1 storage=w12.gif visible=true top = 420 left = 311 time = 200 ]
@wait time=1000
[freeimage layer=1 time=100]
[title name="vhard"]

[bg  storage="st11.png"  time="500"  ]
[playbgm storage=bgm5.m4a click=true ]
@wait time=500

@jump target=*restart1

[s]

*gb8

[title name="faild"]
@image storage=stage6.png  visible=true x=0 y=0 time=200 layer=2 page=fore 
[bg  storage="stage6.png"  time="500"  ]
@wait time=500

@layopt layer=0 visible=false
@layopt layer=1 visible=false
@layopt layer=2 visible=false

@freeimage layer=0 time=100
@freeimage layer=1 time=100
@freeimage layer=2 time=100

@layopt layer=0 visible=true
@layopt layer=1 visible=true
@layopt layer=2 visible=true

[jump  storage="title1.ks"  target=""  ]

[s]