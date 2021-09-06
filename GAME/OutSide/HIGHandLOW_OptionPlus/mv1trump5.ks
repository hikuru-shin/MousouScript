[bg  storage="stage6.png"  time="300"  ]

@playbgm storage=trump4.ogg time=10 volume=50


[layopt layer=0 visible=true]
[iscript]
//前景レイヤ0に、キャンバスを追加します
$('.0_fore').prepend('<canvas id="canvas" style="position:absolute;"></canvas>');
//メッセージより前に表示する場合は、以下を使用ください
//$('.message0_fore').prepend('<canvas id="canvas" style="position:absolute;z-index:1002"></canvas>');
var debug=2;
//-----------------------------------------------------キャンバスの初期設定
$('canvas').attr('width', $('#tyrano_base').width());
$('canvas').attr('height', $('#tyrano_base').height());
var ctx = $('canvas')[0].getContext('2d');
var canvasWidth = $('canvas')[0].width;
var canvasHeight = $('canvas')[0].height;
//-----------------------------------------------------end
//1280*720 勝負 515 560 降りる　820*560 ± 215 560 width 250,150
//-----------------------------------------------------ゲームシステム
var startGame = 0;

var bet = sf.getcoin ;//これが持ちメダル,外からの変数を代入してね
var fightbet = 1;

var time = 0 ;

var getCoin = 1;

//-----------------------------------------------------カードシステム
var endCard = [0,0,0,0,0,0];
var decCard = 0;
var disc = 19;
var eventBet = 0;
var gCoin = 0;
var eCoin = 0;
var pCoin = 1000;

var xx = 3;

//-----------------------------------------------------ボタン設定
var buttonWidth = 250;
var buttonHeight = 150;
var startButton = 3;
var startButtonX = 1.5;
var startButtonY = 36;
var titleButton = 5;
var titleButtonX = 1.2;
var titleButtonY = 36;
var returnButton = 12;
var returnButtonX = 1.3;
var returnButtonY = 1.3;
var betButton = 7;
var pBetButtonX = 30;
var pBetButtonY = 1.2;
var mBetButtonX = 12;
var mBetButtonY = 1.2;
var endButton = 17;
var endButtonX = 1.2;
var endButtonY = 1.5;
var isButtonOnMouse = false;
var betCase = 1;

var highButton = 13;
var highButtonX = 3.5;
var highButtonY = 2.35;
var lowButton = 15;
var lowButtonX = 1.95;
var lowButtonY = 2.35;
var mv = 25;
var mvX = 1.28;
var mvY = 4.5;

var boolIS1 = 255;
var boolIS2 = 255;

var sliderB = 170;
var sliderC = 170;
var isC = false;
var sliderD = 170;
var isD = false;

var isCheck = 0;

//初期化
function init(){
xx = 3;
fightbet = 1;
pCoin = 1000;
//-----------------------------------------------------ボタン設定
buttonWidth = 250;
buttonHeight = 150;
startButton = 3;
startButtonX = 1.5;
startButtonY = 36;
titleButton = 5;
titleButtonX = 1.2;
titleButtonY = 36;
returnButton = 12;
returnButtonX = 1.3;
returnButtonY = 1.3;
betButton = 7;
pBetButtonX = 30;
pBetButtonY = 1.2;
mBetButtonX = 12;
mBetButtonY = 1.2;
endButton = 17;
endButtonX = 1.2;
endButtonY = 1.5;
isButtonOnMouse = false;
betCase = 1;

highButton = 13;
highButtonX = 3.5;
highButtonY = 2.35;
lowButton = 15;
lowButtonX = 1.95;
lowButtonY = 2.35;

boolIS1 = 255;
boolIS2 = 255;

sliderB = 170;
sliderC = 170;
isC = false;
sliderD = 170;
isD = false;

isCheck = 0;

for(var i = 0; i < endCard.length; i++){
  endCard[i] = 0;
}

for(var i = 0; i < endCard.length; i++){
  endCard[i] = isEndCard();
}
for(var i = 0; i < endCard.length; i++){
  if(endCard[i] > 10){
    endCard[i] += 3;
  }
}
if(bet != 0){
  bet--;
}else{
  fightbet=0;
}

}
//--------------------------------------------------------key＆mouseAction

document.addEventListener("keydown", keyDownHandler, false); //key押下時
document.addEventListener("keyup", keyUpHandler, false); //key押下時
document.addEventListener("mousemove", mouseMoveHandler, false); //マウス操作
document.addEventListener("click", mouseClickHandler, false); //マウスクリック
document.addEventListener("touchmove", sumartMoveHandler, false); //スマホ操作


function keyDownHandler(e) {
    console.log(e.keyCode);
}
function keyUpHandler(e) {
}

function mouseMoveHandler(e) {
  isButtonOnMouse = false;
  if(startGame == 0){
    startButton = buttonOnMouse( 4 , 3 , startButtonX , startButtonY , e ,150 , 90);
    titleButton = buttonOnMouse( 6 , 5 , titleButtonX , titleButtonY , e ,150 , 90);
  }
  if(startGame == 1){
    betButton = buttonOnMouse( 8 , 7 , 64 , 1.71  , e ,buttonWidth/2 , buttonHeight);
    betButton = buttonOnMouse( 9 , betButton , 9.14 , 1.71  , e ,buttonWidth/2 , buttonHeight);
    titleButton = buttonOnMouse( 6 , 5 , 1.25 , 60 , e ,buttonWidth , buttonHeight);
    endButton = buttonOnMouse( 18 , 17 , endButtonX , endButtonY , e ,buttonWidth , buttonHeight);
    highButton = buttonOnMouse( 14 , 13 , highButtonX , highButtonY , e ,buttonWidth , buttonHeight/1.5);
    lowButton = buttonOnMouse( 16 , 15 , lowButtonX , lowButtonY , e ,buttonWidth , buttonHeight/1.5);

    boolIS1 = buttonOnMouse( 275 , 255 , 2.3 , 16 , e ,170 , 255);
    boolIS2 = buttonOnMouse( 275 , 255 , 1.7 , 16 , e ,170 , 255);
  }
  if(startGame == 2){

  }
}

function buttonOnMouse( a , b , x , y , e , bWidth , bHeight){
  if(isButtonOnMouse) return b;
  if(e.offsetX > canvasWidth/x && e.offsetX < canvasWidth/x+bWidth && e.offsetY > canvasHeight/y && e.offsetY < canvasHeight/y+bHeight){
    isButtonOnMouse =true;
    return a;
  }else
    return b;
}

function sumartMoveHandler(e) {
}


function mouseClickHandler(e){
  console.log("x "+ e.offsetX + " , y " +e.offsetY );
  if(islose){
    bet = 1;//外からもう一度変数を入れてね:GameOver
    init();
    bet++;
    startGame = 0;
    islose =false;
    islose = false;
    //ティラノBGM再開
  }
  if(titleButton == 6){
    titleButton = 5;
    clearInterval(interval);
    tyrano.plugin.kag.variable.sf.getcoin = bet;
    //タイトルに戻るところ、変数betを外の変数に入れてね:Title
    const TG = tyrano.plugin.kag;
    const tmp = TG.stat.is_strong_stop;
    TG.stat.is_strong_stop = true;
    tyrano.plugin.kag.ftag.startTag('jump', {
      storage: "returns.ks",
      });
    if (!tmp) TG.stat.is_strong_stop = false;
  }
  if(startButton == 4 && startGame == 0){
    startGame = 1;
    startButton = 3;
    for(var i = 0; i < endCard.length; i++){
      endCard[i] = isEndCard();
    }
    for(var i = 0; i < endCard.length; i++){
      if(endCard[i] > 10){
        endCard[i] += 3;
      }
    }
    eCoin = bet;
    bet--;
  }
  if(startGame == 1){
    switch(betButton){
      case 8 :
      if(fightbet<30){
        if(bet==0){
          return;
        }
        fightbet++;
        getCoin++;
        bet--;
        var sound = new Audio('data/sound/gcoin.ogg');
        sound.play();
      }
      break;
      case 9 :
      if(fightbet>0){
        fightbet--;
        getCoin--;
        bet++;
        var sound = new Audio('data/sound/ggain.ogg');
        sound.play();
      }
      break;
    }
    if(highButton == 14 || lowButton == 16){
      startGame = 2;
      if(isC || isD){
       xx = 2;
      }
      var im = 0;
      var buts = 0;
      for(var i =3 ; i < 6 ; i++){
        var pulas = endCard[i];
        if(pulas > 10){
          pulas -= 13;
        }
        im += pulas;
      }
      for(var i =0 ; i < 3 ; i++){
        var pulas = endCard[i];
        if(pulas > 10){
          pulas -= 13;
        }
        buts += pulas;
      }
      if(highButton == 14){
         if(im < buts){
          isCheck = 19;
          pCoin = bet;
          bet += fightbet *xx;
         }else if(im > buts){
          isCheck = 20;
         }else{
          isCheck = 23;
          bet += fightbet;
         }
      }
      if(lowButton == 16){
      if(im > buts){
       isCheck = 19;
       pCoin = bet;
       bet += fightbet *xx;
      }else if(im < buts){
       isCheck = 20;
      }else{
       isCheck = 23;
       bet += fightbet;
      }
      }
      isC = true;
      isD = true;
    }
    if(boolIS1 == 275){
      if(!isD){
        isC = true;
      }
    }
    if(boolIS2 == 275){
     if(!isC){
       isD = true;
     }
    }
    //
    if(endButton == 18){
      init();
    }
  }else if(startGame == 2){
     startGame = 1;
     init();
  }
}
//--------------------------------------------------------key＆mouseAction:end

function isEndCard(){
  var bool = false;
  var isEnd = getRandom(1 , 20);
  for(var i = 0; i < endCard.length; i++){
    if(isEnd == endCard[i]){
      bool = true;
    }
  }
  if(bool){
    return isEndCard();
  }else{
    return isEnd;
  }
}

//--------------------------------------------------------画像をプリロード

//画像保存場所
var imgs_url= [
  "data/bgimage/gb1.png",
  "data/bgimage/bgdog1.png",
  "data/bgimage/coin.png",
  "data/bgimage/gplay1.png",
  "data/bgimage/gplay2.png",
  "data/bgimage/gback1.png",
  "data/bgimage/gback2.png",
  "data/bgimage/plmn1.png",
  "data/bgimage/plmn2.png",
  "data/bgimage/plmn3.png",
  "data/bgimage/bgdog5.png",
  "data/bgimage/redCoin.png",
  "data/bgimage/greturn1.png",
  "data/bgimage/high1.png",
  "data/bgimage/high2.png",
  "data/bgimage/low1.png",
  "data/bgimage/low2.png",
  "data/bgimage/end1.png",
  "data/bgimage/end2.png",
  "data/bgimage/hit.png",
  "data/bgimage/out.png",
  "data/bgimage/ex_high_low_rule.png",
  "data/bgimage/ex high low.png",
  "data/bgimage/draw.png",
  "data/bgimage/mvlose.png",
  "data/bgimage/mvnormal.png",
  "data/bgimage/mvwin.png",
  "data/bgimage/mvak1.png",//変更点その1
];

//カード画像保存場所
var card_url = [];
var cardlist = 53;
card_url.push("data/bgimage/card/trump_back.png");
for(var i = 1; i < cardlist ; i++){
  card_url.push("data/bgimage/card/trump" + i +".png");
}

//画像リスト(呼び出し用)
var imgs = new Array(imgs_url.length);
for(var i =0 ;i < imgs.length;i++){
  imgs[i] = new Image();
  imgs[i].src = imgs_url[i];
  prelord(imgs , imgs_url , i);
}

//カードリスト(呼び出し用)
var cards = new Array(card_url.length);
for(var i =0 ;i < cards.length;i++){
  cards[i] = new Image();
  cards[i].src = card_url[i];
  prelord(cards , card_url , i);
}

//プリロード用関数(処理速度の関係で分割)
//array : 呼び出し用関数
//list  : 画像URL格納関数
//num   : 画像URL番号
function prelord(array , list , num){
  array[num].onload = function(){
  var img = document.createElement('img');
  img.src = list[num];
  }
}


//--------------------------------------------------------プリロード終了

//--------------------------------------------------------画像描画

function placeImage(array , num , x , y ,width , height){
  ctx.drawImage(array[num],canvasWidth/x,canvasHeight/y,width,height);
}

function drawFrontImage(){
  ctx.drawImage(imgs[0],0,0,$('canvas')[0].width,$('canvas')[0].height);
}

//--------------------------------------------------------画像描画:end

//-------------------------------------------------------ゲームシステム

//スタート描画
function drawStart(){
//drawFrontImage();
ctx.drawImage(imgs[21],0,0,$('canvas')[0].width,$('canvas')[0].height);
placeImage(imgs , startButton , startButtonX , startButtonY , 150 , 90);
placeImage(imgs , titleButton , titleButtonX , titleButtonY , 150 , 90);
var tex = "";
if(gCoin != 0 && time%10 == 0){
  if(gCoin < 0){
   gCoin++;
   eCoin--;
   var sound = new Audio('data/sound/ggain.ogg');
   sound.play();
  }else{
   gCoin--;
   eCoin++;
   var sound = new Audio('data/sound/gcoin.ogg');
   sound.play();
  }
}
//GETコイン
ctx.fillStyle = "rgb(255,255,255)";
ctx.font = '20pt Arial';
ctx.fillText("GETコイン", canvasWidth/1.14, canvasHeight/1.35);
placeImage(imgs , 2 , 1.14 , 1.3 , 65 , 35 );
ctx.fillText("X "+tex+ gCoin, canvasWidth/1.07, canvasHeight/1.23);
//所持コイン
ctx.fillStyle = "rgb(255,255,255)";
ctx.font = '20pt Arial';
ctx.fillText("所持コイン", canvasWidth/1.14, canvasHeight/1.1);
placeImage(imgs , 2 , 1.14 , 1.07 , 65 , 35 );
ctx.fillText("X "+eCoin, canvasWidth/1.07, canvasHeight/1.03);
}


//賭け描画　ハイロー押す前に出る画像
function drawBet(){
  //drawFrontImage();
  mv=25;
  ctx.drawImage(imgs[22],0,0,$('canvas')[0].width,$('canvas')[0].height);
  placeImage(imgs , titleButton , 1.25 , 60 , buttonWidth , buttonHeight);//変更点その2　1280/1.25の場所にx座標
  placeImage(imgs , betButton , 64 , 1.71 , buttonWidth , buttonHeight);
  placeImage(imgs , highButton , highButtonX , highButtonY , buttonWidth , buttonHeight/1.5);
  placeImage(imgs , lowButton , lowButtonX , lowButtonY , buttonWidth , buttonHeight/1.5);
  placeImage(cards , endCard[0] , 3.6 , 16 , 170 , 255);
  placeImage(cards , endCard[1] , 2.3 , 16 , 170 , 255);
  placeImage(cards , endCard[2] , 1.7 , 16 , 170 , 255);
  placeImage(cards , endCard[3] , 3.6 , 1.75 , 170 , 255);
  placeImage(cards , endCard[4] , 2.3 , 1.75 , 170 , 255);
  placeImage(cards , endCard[5] , 1.7 , 1.75 , 170 , 255);
  placeImage(imgs , mv , mvX , mvY , 280 , 560);
  //placeImage(imgs , 27 , mvX , mvY , 415 , 120);//変更点その3 もじ

  if(sliderB>0){
    ctx.drawImage(cards[0],0,0,409,600,canvasWidth/3.6,canvasHeight/1.75,sliderB,255);
    ctx.drawImage(cards[0],0,0,409,600,canvasWidth/2.3,canvasHeight/1.75,sliderB,255);
    ctx.drawImage(cards[0],0,0,409,600,canvasWidth/1.7,canvasHeight/1.75,sliderB,255);
    ctx.drawImage(cards[0],0,0,409,600,canvasWidth/3.6,canvasHeight/16,sliderB,255);
    sliderB -= 3;
  }

  if(isC){
    ctx.drawImage(cards[0],0,0,409,600,canvasWidth/2.3,canvasHeight/16,sliderC,255);
    if(sliderC>0){
      sliderC -= 3;
    }
  }else{
    ctx.drawImage(cards[0],0,0,409,600,canvasWidth/2.3,canvasHeight/16,sliderC,boolIS1);
  }

  if(isD){
    ctx.drawImage(cards[0],0,0,409,600,canvasWidth/1.7,canvasHeight/16,sliderD,255);
    if(sliderD>0){
      sliderD -= 3;
    }
  }else{
    ctx.drawImage(cards[0],0,0,409,600,canvasWidth/1.7,canvasHeight/16,sliderD,boolIS2);
  }

  //コイン
  for(var i = 0; i < fightbet ; i++){
    var h = 2.11 + i *0.05;
    placeImage(imgs , 2 , 16 , h , 129 , 70 );
  }

  //枚数
  ctx.font = '36pt Arial';
  ctx.fillStyle = "rgb(0,0,0)";
  ctx.fillText(fightbet + "枚", canvasWidth/12, canvasHeight/6);
  //所持コイン
  ctx.font = '24pt Arial';
  ctx.fillText("X "+ bet, canvasWidth/7, canvasHeight/1.12);
}

//ハイローを押した後
var slider = 170;
function drawResult(){
//drawFrontImage();
ctx.drawImage(imgs[22],0,0,$('canvas')[0].width,$('canvas')[0].height);
placeImage(imgs , titleButton , 1.25 , 60 , buttonWidth , buttonHeight);
placeImage(imgs , betButton , 64 , 1.71 , buttonWidth , buttonHeight);
placeImage(imgs , highButton , highButtonX , highButtonY , buttonWidth , buttonHeight/1.5);
placeImage(imgs , lowButton , lowButtonX , lowButtonY , buttonWidth , buttonHeight/1.5);
placeImage(cards , endCard[0] , 3.6 , 16 , 170 , 255);
placeImage(cards , endCard[1] , 2.3 , 16 , 170 , 255);
placeImage(cards , endCard[2] , 1.7 , 16 , 170 , 255);
placeImage(cards , endCard[3] , 3.6 , 1.75 , 170 , 255);
placeImage(cards , endCard[4] , 2.3 , 1.75 , 170 , 255);
placeImage(cards , endCard[5] , 1.7 , 1.75 , 170 , 255);
placeImage(imgs , mv , mvX , mvY , 280 , 560);

if(isC){
  ctx.drawImage(cards[0],0,0,409,600,canvasWidth/2.3,canvasHeight/16,sliderC,255);
  if(sliderC>0){
    sliderC -= 3;
    if(sliderC<0){
    if(isCheck == 19){
    var sound = new Audio('data/sound/maru.ogg');
    sound.play();
    }
    if(isCheck == 20){
    var sound = new Audio('data/sound/batu.ogg');
     sound.play();
     }
     if(isCheck == 23){
     var sound = new Audio('data/sound/gdraw.ogg');
      sound.play();
      }
    }
  }
}else{
  ctx.drawImage(cards[0],0,0,409,600,canvasWidth/2.3,canvasHeight/16,sliderC,boolIS1);
}

if(isD){
  ctx.drawImage(cards[0],0,0,409,600,canvasWidth/1.7,canvasHeight/16,sliderD,255);
  if(sliderD>0){
    sliderD -= 3;
    if(sliderD<0){
    if(isCheck == 19){
    var sound = new Audio('data/sound/maru.ogg');
    sound.play();
    mv= 26;
    }
    if(isCheck == 20){
    var sound = new Audio('data/sound/batu.ogg');
     sound.play();
     mv =24;
     }
     if(isCheck == 23){
     var sound = new Audio('data/sound/gdraw.ogg');
      sound.play();
      }
    }
  }
}else{
  ctx.drawImage(cards[0],0,0,409,600,canvasWidth/1.7,canvasHeight/16,sliderD,boolIS2);
}




//変更点その4 19が勝ち　20が
if(sliderC<0 && sliderD <0){
  placeImage(imgs , isCheck , 2.9 , 3.5 , 400 , 400);
    if(isCheck == 19){
  placeImage(imgs , 27 , mvX , mvY , 415 , 120);//変更点その5　勝ち文字
    }
    if(isCheck == 20){
  //placeImage(imgs , 27 , mvX , mvY , 415 , 120);//変更点その6 負け文字
     }
     if(isCheck == 23){
  //placeImage(imgs , 27 , mvX , mvY , 415 , 120);//変更点その7 引き分け文字
      }

}







//コイン
for(var i = 0; i < fightbet ; i++){
  var h = 2.11 + i *0.05;
  placeImage(imgs , 2 , 16 , h , 129 , 70 );
}


//枚数
ctx.font = '36pt Arial';
ctx.fillStyle = "rgb(0,0,0)";
ctx.fillText(fightbet + "枚", canvasWidth/12, canvasHeight/6);
//所持コイン
ctx.font = '24pt Arial';
if(pCoin == 1000){
  ctx.fillText("X "+ bet, canvasWidth/7, canvasHeight/1.12);
}else{
  if(pCoin < bet){
    pCoin++;
    var sound = new Audio('data/sound/gCoin.ogg');
    sound.play();
  }
  ctx.fillText("X "+ pCoin, canvasWidth/7, canvasHeight/1.12);
}
}

//カード決定

//-------------------------------------------------------ゲームシステム:end


var islose =false;
var isloseSound = false;
eCoin = bet;
function draw() {
  if(islose){
    if(!isloseSound){
      var sound = new Audio('data/sound/glose.ogg');
      sound.play();
      isloseSound = true;
    }
    ctx.beginPath();
    ctx.font = '36pt Arial';
    ctx.fillStyle = 'rgb(255, 255, 255)';
    ctx.fillText('GAME OVER', $('canvas')[0].width/2 - canvasWidth/10,$('canvas')[0].height/2);
    ctx.fillStyle = 'rgba(0, 0, 0,0.007)';
    ctx.fillRect(0, 0, $('canvas')[0].width,$('canvas')[0].height);
    ctx.fill();
    ctx.closePath();
    //持ちメダルが0の時:ティラノBGM_STOP
    return;
  }
  switch(startGame){
    case 0 :
      drawStart();
      break;
    case 1 :
      drawBet();
      break;
    case 2 :
      drawResult();
      break;
  }
  if(debug == 3){
    ctx.font = '64pt Arial';
    ctx.fillText(bet, canvasWidth/1.2, canvasHeight/8);
  }
  time++;
}

function getRandom(n , m){
  return Math.floor(Math.random() * (m + 1 -n)) + n;
}


function stopTimer(){
 clearInterval(testTimer);
}


var interval = setInterval(draw, 20);
[endscript]

[s]
