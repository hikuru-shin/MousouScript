[bg  storage="stage6.png"  time="300"  ]

@playbgm storage=trump1.ogg time=10 volume=50




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
var leftCard = 1;
var endCard = [0,0,0,0,0,0];
var endCardX = [3.8,2.9,2.35,1.97,1.7,1.5];
var decCard = 0;
var disc = 19;
var eventBet = 0;
var gCoin = 0;
var eCoin = 0;

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
var highButton = 13;
var highButtonX = 1.275;
var highButtonY = 2;
var lowButton = 15;
var lowButtonX = 1.125;
var lowButtonY = 2;
var endButton = 17;
var endButtonX = 1.2;
var endButtonY = 1.5;
var isButtonOnMouse = false;
var betCase = 1;
var face = 23;

//初期化
function init(){
  bet += getCoin;
  gCoin = bet - eCoin;
  getCoin = 1;
  fightbet = 1;
  for(var i = 0 ; i < endCard.length; i++){
    endCard[i] = 0;
  }
  startGame = 0;
  endButton = 17;
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
    startButton = buttonOnMouse( 4 , 3 , startButtonX , startButtonY , e , 150 , 90);
    titleButton = buttonOnMouse( 6 , 5 , titleButtonX , titleButtonY , e ,150 , 90);
  }
  if(startGame == 1){
    betButton = buttonOnMouse( 8 , 7 , pBetButtonX , pBetButtonY , e ,buttonWidth/4 , buttonHeight/2);
    betButton = buttonOnMouse( 9 , betButton , mBetButtonX , mBetButtonY , e ,buttonWidth/4 , buttonHeight/2);
    titleButton = buttonOnMouse( 6 , 5 , 1.12 , 60 , e ,buttonWidth/2 , buttonHeight/2);
    highButton = buttonOnMouse( 14 , 13 , highButtonX , highButtonY , e ,buttonWidth/2 , buttonHeight/2);
    lowButton = buttonOnMouse( 16 , 15 , lowButtonX , lowButtonY , e ,buttonWidth/2 , buttonHeight/2);
    endButton = buttonOnMouse( 18 , 17 , endButtonX , endButtonY , e ,buttonWidth/2 , buttonHeight/2);
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
    leftCard = getRandom(14 , 26);
    eCoin = bet;
    bet--;
  }
  if(startGame == 1){
    switch(betButton){
      case 8 :
      if(fightbet<10){
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
    //
    if(highButton == 14 || lowButton == 16){
      startGame = 2;
      if(highButton == 14){
        if(leftCard  < decCard){
         disc = 19;
         eventBet = getCoin;
         getCoin *= 2;
        }else{
         disc = 20;
         eventBet = getCoin;
         getCoin = 0;
        }
      }
      if(lowButton == 16){
       if(leftCard  > decCard){
        disc = 19;
        eventBet = getCoin;
        getCoin *= 2;
       }else{
        disc = 20;
        eventBet = getCoin;
        getCoin = 0;
       }
      }
    }
    //
    if(endButton == 18){
      init();
    }
  }else if(startGame == 2){
    startGame = 1;
    fightbet = 0;
    highButton = 13 ;
    lowButton = 15;
    lenDec();
    leftCard = decCard;
    slider = 200;
    sWidth = 180 ;
    sHeight = 300 ;
    cWidth = 350 ;
    cHeight = 300 ;
    size = 100;
    var isf = finlenDec();
    if(isf){
     init();
    }
  }
}
//--------------------------------------------------------key＆mouseAction:end

function lenDec(){
  for(var i = 0 ; i < endCard.length ; i++){
    if(endCard[i] == 0){
     endCard[i] = leftCard;
     return;
    }
  }
}

function finlenDec(){
  for(var i = 0 ; i < endCard.length ; i++){
    if(endCard[i] == 0){
     return false;
    }
  }
  return true;
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
  "data/bgimage/high_low_rule.png",
  "data/bgimage/mvllose.png",
  "data/bgimage/mvlnormal.png",
  "data/bgimage/mvlwin.png",
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

//賭け描画
function drawBet(){
  face = 23;
  decCard = notDouble();
  drawFrontImage();
  placeImage(imgs , titleButton , 1.12 , 60 , buttonWidth/2 , buttonHeight/2);
  placeImage(imgs , betButton , 30 , 1.2 , buttonWidth/2 , buttonHeight/2);
  placeImage(imgs , highButton , highButtonX , highButtonY , buttonWidth/2 , buttonHeight/2);
  placeImage(imgs , lowButton , lowButtonX , lowButtonY , buttonWidth/2 , buttonHeight/2);
  placeImage(imgs , endButton , endButtonX , endButtonY , buttonWidth/2 , buttonHeight/2);
  placeImage(cards , 0 , 1.8 , 3 , 200 , 300);
  placeImage(cards , leftCard , 3.5 , 3 , 200 , 300);
  placeImage(imgs , face , 32 , 18 , 200 , 200);

  //使い終わったカード
  for(var i = 0; i < endCard.length ; i++){
    placeImage(cards , endCard[i] , endCardX[i] , 8 , 80 , 120);
  }


  //コイン
  for(var i = 0; i < fightbet ; i++){
    var h = 1.6 + i *0.05;
    placeImage(imgs , 2 , 32 , h , 129 , 70 );
  }

  //枚数
  ctx.font = '36pt Arial';
  ctx.fillStyle = "rgb(0,0,0)";
  ctx.fillText(fightbet + "枚", canvasWidth/20, canvasHeight/1.27);
  //所持コイン
  ctx.font = '20pt Arial';
  ctx.fillText("所持コイン", canvasWidth/1.18, canvasHeight/1.1);
  placeImage(imgs , 2 , 1.14 , 1.07 , 65 , 35 );
  ctx.fillText("X "+ bet, canvasWidth/1.07, canvasHeight/1.03);
  //エンド時取得コイン
  ctx.font = '18pt Arial';
  ctx.fillText("END押下時取得コイン", canvasWidth/1.27, canvasHeight/5);
  //枚数
  ctx.font = '36pt Arial';
  ctx.fillText(getCoin + "枚", canvasWidth/1.15, canvasHeight/3);
}


var slider = 200;
var sWidth = 180 ;
var sHeight = 300 ;
var cWidth = 350 ;
var cHeight = 300 ;
var size = 100;
function drawResult(){
  drawFrontImage();
  placeImage(imgs , titleButton , 1.12 , 60 , buttonWidth/2 , buttonHeight/2);
  placeImage(imgs , betButton , 30 , 1.2 , buttonWidth/2 , buttonHeight/2);
  placeImage(imgs , highButton , highButtonX , highButtonY , buttonWidth/2 , buttonHeight/2);
  placeImage(imgs , lowButton , lowButtonX , lowButtonY , buttonWidth/2 , buttonHeight/2);
  placeImage(imgs , endButton , endButtonX , endButtonY , buttonWidth/2 , buttonHeight/2);
  placeImage(imgs , face , 32 , 18 , 200 , 200);

  //使い終わったカード
  for(var i = 0; i < endCard.length ; i++){
    placeImage(cards , endCard[i] , endCardX[i] , 8 , 80 , 120);
  }


  //コイン
  for(var i = 0; i < fightbet ; i++){
    var h = 1.6 + i *0.05;
    placeImage(imgs , 2 , 32 , h , 129 , 70 );
  }

  //枚数
  ctx.font = '36pt Arial';
  ctx.fillStyle = "rgb(0,0,0)";
  ctx.fillText(fightbet + "枚", canvasWidth/20, canvasHeight/1.27);
  //所持コイン
  ctx.font = '20pt Arial';
  ctx.fillText("所持コイン", canvasWidth/1.18, canvasHeight/1.1);
  placeImage(imgs , 2 , 1.14 , 1.07 , 65 , 35 );
  ctx.fillText("X "+ bet, canvasWidth/1.07, canvasHeight/1.03);
  //エンド時取得コイン
  ctx.font = '18pt Arial';
  ctx.fillText("END押下時取得コイン", canvasWidth/1.27, canvasHeight/5);
  //枚数
  ctx.font = '36pt Arial';
  ctx.fillText(eventBet + "枚", canvasWidth/1.15, canvasHeight/3);
  var ss = sWidth/100;
  var sh = sHeight/100;
  var cs = cWidth/100;
  var ch = cHeight/100;
  placeImage(cards , leftCard , cs , ch , 2 * size , 3 * size );
  placeImage(cards , decCard  , ss , sh , 200 , 300);

  var endWidth = fEndCard() * 100;

  if(slider>0){
    ctx.drawImage(cards[0],0,0,409,600,canvasWidth/1.8,canvasHeight/3,slider,300);
    slider -= 3;
    if(slider <= 0){
     if(disc == 19){
     var sound = new Audio('data/sound/maru.ogg');
     sound.play();
     face = 24;
     }else{
     var sound = new Audio('data/sound/batu.ogg');
      sound.play();
      face=22;
     }
    }
  }else if(size > 40){
   size--;
  }else if(350 > sWidth){
    sWidth++;
  }

  if(slider>0){

  }else if(endWidth > cWidth){
    cWidth++;
    if(cHeight < 800 ){
      cHeight+=2;
    }
  }else if(endWidth < cWidth){
    if(cHeight < 800 ){
      cHeight+=2;
    }
    cWidth--;
  }else if(cHeight < 800 ){
    cHeight+=2;
  }

  if(slider>0){

  }else{
    placeImage(imgs , disc , 2.9 , 4 , 400 , 400);
    if(size==40){
    if(time%20 == 0 && getCoin > eventBet){
     eventBet++;
     var sound = new Audio('data/sound/gcoin.ogg');
     sound.play();
    }else if(time%20 == 0 && getCoin == 0  && eventBet != 0){
     eventBet--;
     var sound = new Audio('data/sound/ggain.ogg');
     sound.play();
    }
    }
  }

}

function fEndCard(){
  for(var i = 0; i < endCard.length; i++){
    if(endCard[i] == 0){
      return endCardX[i];
    }
  }
  return 0;
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

function notDouble(){
  var n = getRandom(14 , 26);
  var isN = false;
  for(var i = 0; i < endCard.length ; i++){
    if(endCard[i] == n){
      isN = true;
    }
  }
  if(leftCard == n){
   isN = true;
  }
  if(isN){
   return notDouble();
  }else{
   return n;
  }
}


function stopTimer(){
 clearInterval(testTimer);
}


var interval = setInterval(draw, 20);
[endscript]

[s]
