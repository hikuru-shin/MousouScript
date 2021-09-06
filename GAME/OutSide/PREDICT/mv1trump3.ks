[bg  storage="redrule.png"  time="300"  ]

@playbgm storage=Cat_jazz.ogg time=10 volume=50
@wait time=1000
[l]

[bg  storage="stage.png"  time="300"  ]


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
var split = 0;
var isSplit = false;
var isResultCalc = false;

var bet = sf.getcoin;//これが持ちメダル,外からの変数を代入してね
var fightbet = 1;
var redCoin = [32,8.89,5.95,4.46,3.58,2.98,2.55,2.23,1.99,1.79,1.63,1.49,1.38,1.23];//レッドコインのWidth
var redCoinH = 7.1;//レッドコインのHeight
var text = "引き分け";

var time = 0 ;

//-----------------------------------------------------カードシステム
var isCard = false;
var leftCard = 0;
var rightCard = 0;
var leftNum = 0;
var rightNum = 0;
var centerCard = 0;
var centerNum = 0;

//-----------------------------------------------------ボタン設定
var buttonWidth = 250;
var buttonHeight = 150;
var startButton = 3;
var startButtonX = 5;
var startButtonY = 2.2;
var titleButton = 5;
var titleButtonX = 1.7;
var titleButtonY = 2.2;
var returnButton = 12;
var returnButtonX = 1.3;
var returnButtonY = 1.3;
var isButtonOnMouse = false;
var betButton = 1;

//初期化
function init(){
  ori = 0;
  isResultFirst = false;
  isResultCalc = false;
  resultTime =0;
  isCard = false ;
  isSplit = false;
  startGame = 1;
  resultTime = 0;
  returnButton =12;
  text = "負け";
  bet--;
  fightbet=1;
  sss=200;
  ssss= 200;
  sssss= 200;
  isloseSound = false;
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
    startButton = buttonOnMouse( 4 , 3 , startButtonX , startButtonY , e ,buttonWidth , buttonHeight);
    titleButton = buttonOnMouse( 6 , 5 , titleButtonX , titleButtonY , e ,buttonWidth , buttonHeight);
  }
  if(startGame == 1){
    var sin = 1 ;
    sin = buttonOnMouse( 7 , sin , 5.95 , 1.28 , e ,buttonWidth/2 , buttonHeight);
    sin = buttonOnMouse( 8 , sin , 3.76 , 1.28 , e ,buttonWidth/2 , buttonHeight);
    sin = buttonOnMouse( 9 , sin , 2.48 , 1.28 , e ,buttonWidth , buttonHeight);
    sin = buttonOnMouse( 10 , sin , 1.56 , 1.28 , e ,buttonWidth , buttonHeight);
    betButton = sin;
    titleButton = buttonOnMouse( 6 , 5 , 1.11 , 20 , e ,buttonWidth/2 , buttonHeight/2);
  }
  if(startGame == 2){
    if(next){
      returnButton = buttonOnMouse( 13 , 12 , returnButtonX , returnButtonY , e ,buttonWidth , buttonHeight);
      next = false;
    }
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
    bet = 30;//外からもう一度変数を入れてね:GameOver
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
    bet--;
  }
  if(startGame == 1){
    switch(betButton){
      case 7 :
      if(fightbet<10){
        if(bet==0){
          return;
        }
        fightbet++;
        bet--;
        var sound = new Audio('data/sound/gcoin.ogg');
        sound.play();
      }
      break;
      case 8 :
      if(fightbet>1){
        fightbet--;
        bet++;
        var sound = new Audio('data/sound/ggain.ogg');
        sound.play();
      }
      break;
      case 9 :
      startGame = 2;
      betButton = 1;
        var sound = new Audio('data/sound/pr.ogg');
        sound.play();
      break;
      case 10 :
      isCard = false ;
      isSplit = false;
      break;
    }
  }
  if(returnButton == 13 && startGame == 2 && !islose){
    init();
  }
}
//--------------------------------------------------------key＆mouseAction:end

//--------------------------------------------------------画像をプリロード

//画像保存場所
var imgs_url= [
  "data/bgimage/stage.png",
  "data/bgimage/bgdog1.png",
  "data/bgimage/coin.png",
  "data/bgimage/gplay1.png",
  "data/bgimage/gplay2.png",
  "data/bgimage/gback1.png",
  "data/bgimage/gback2.png",
  "data/bgimage/bgdog2.png",
  "data/bgimage/bgdog3.png",
  "data/bgimage/bgdog4.png",
  "data/bgimage/bgdog5.png",
  "data/bgimage/redCoin.png",
  "data/bgimage/greturn1.png",
  "data/bgimage/greturn2.png",
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
  placeImage(imgs , 0 , canvasWidth-1 , canvasHeight-1 , canvasWidth , canvasHeight);
  //ctx.drawImage(imgs[0],0,0,$('canvas')[0].width,$('canvas')[0].height);
}

function drawRect( style , x , y , width , height ){
  ctx.beginPath();
  ctx.fillStyle = style;
  ctx.fillRect(x, y, width, height );
  ctx.fill();
  ctx.closePath();
}

//--------------------------------------------------------画像描画:end

//-------------------------------------------------------ゲームシステム

//スタート描画
function drawStart(){
  drawFrontImage();
  placeImage(imgs , startButton , startButtonX , startButtonY , buttonWidth , buttonHeight);
  placeImage(imgs , titleButton , titleButtonX , titleButtonY , buttonWidth , buttonHeight);
}
var sss = 200;
var ssss = 200;
//賭け描画
function drawBet(){
  placeImage(imgs , betButton , canvasWidth-1 , canvasHeight-1 , canvasWidth , canvasHeight);
  placeImage(imgs , titleButton , 1.11 , 20 , buttonWidth/2 , buttonHeight/2);
  detectiveCard();
  splitCalc();
  placeImage(cards , leftCard , 5.27 , 3 , 200 , 300);
  if(sss>0){
    ctx.drawImage(cards[0],0,0,409,600,canvasWidth/5.27,canvasHeight/3,sss,300);
    sss-=3;
  }
  placeImage(cards , rightCard , 1.52 , 3 , 200 , 300);
  if(ssss>0){
    ctx.drawImage(cards[0],0,0,409,600,canvasWidth/1.52,canvasHeight/3,ssss,300);
    ssss-=3;
  }
  placeImage(cards , getRandom(1 , 52) , 2.36 , 3 , 200 , 300);
  placeImage(cards , 0 , 2.36 , 3 , 200 , 300);
  for(var i = 0; i < fightbet ; i++){
    var h = 1.6 + i *0.05;
    placeImage(imgs , 2 , 32 , h , 129 , 70 );
  }
  placeImage(imgs , 11 , redCoin[split] , redCoinH , 65 , 35 );
  //placeImage(imgs , 11 , 32 , 7.5 , 65 , 35 );
  ctx.font = '36pt Arial';
  ctx.fillStyle = "rgb(255,255,255)";
  ctx.fillText(fightbet + "枚", canvasWidth/20, canvasHeight/1.27);
  ctx.font = '20pt Arial';
  ctx.fillText("所持コイン", canvasWidth/1.18, canvasHeight/1.1);
  placeImage(imgs , 2 , 1.14 , 1.07 , 65 , 35 );
  ctx.fillText("X "+ bet, canvasWidth/1.07, canvasHeight/1.03);
}
//スプリット確認
function splitCalc(){
  if(!isSplit){
    isSplit = true;
    var reRightNum = (rightNum == 1 ? 14 : rightNum) ;
    split = reRightNum - leftNum -1;
  }
  switch(split){
    case -1 :
      split = 13;
      break;
    case 0  :
      split = 12;
      break;
    default:
  }
}

//カード決定
function detectiveCard(){
  if(!isCard){
    isCard = true;
    leftCard = getRandom(1 , 52);
    rightCard = isMatchCard(leftCard);
    leftNum = leftCard % 13 ;
    rightNum = rightCard % 13;
    leftNum = (leftNum == 0 ? 13 : leftNum) ;
    rightNum = (rightNum == 0 ? 13 : rightNum) ;
    if(leftNum > rightNum){
      var s = rightNum ;
      rightNum = leftNum;
      leftNum = s;
      var sCard = rightCard;
      rightCard = leftCard;
      leftCard = sCard;
    }
    if(leftNum == 1){
      var s = rightNum ;
      rightNum = leftNum;
      leftNum = s;
      var sCard = rightCard;
      rightCard = leftCard;
      leftCard = sCard;
    }
    centerCard = isMatchCardDouble(leftCard , rightCard);
    centerNum = centerCard % 13 ;
    centerNum = (centerNum == 0 ? 13 : centerNum) ;
  }
}

//ダブり防止
function isMatchCard(cardnum1){
  var cardnum2 = getRandom(1 , 52);
  var result = (cardnum1 == cardnum2);
  return (result ? isMatchCard(cardnum1) : cardnum2);
}

//ダブり防止CenterCard用
function isMatchCardDouble(cardnum1 , cardnum2){
  var cardnum3 = getRandom(1 , 52);
  var result = (cardnum1 == cardnum3) || (cardnum2 == cardnum3);
  return (result ? isMatchCard(cardnum1 , cardnum2) : cardnum3);
}
var ori = 0;
var isResultFirst = false;
var resultTime =0;
var sssss = 200;
var next = false;

function drawResult(){
  resultTime++;
  if(!isResultFirst){
    ori = bet ;
    isResultFirst = true;
  }
  drawFrontImage();
  placeImage(cards , leftCard , 5.27 , 3 , 200 , 300);
  placeImage(cards , rightCard , 1.52 , 3 , 200 , 300);
  placeImage(cards , centerCard , 2.36 , 3 , 200 , 300);
  if(sssss>0){
    ctx.drawImage(cards[0],0,0,409,600,canvasWidth/2.36,canvasHeight/3,sssss,300);
    sssss-=3;
  }
  placeImage(imgs , 11 , redCoin[split] , redCoinH , 65 , 35 );
  placeImage(imgs , returnButton , returnButtonX , returnButtonY , buttonWidth , buttonHeight);
  if(resultTime <75)
    return;
  resultCalc();
  ctx.font = '64pt Arial';
  ctx.fillText(text + " : ", canvasWidth/20, canvasHeight/1.1);
  var oribet = ori-bet;
  if(oribet<0){
    oribet = "+" + (oribet*-1);
  }else if(oribet>0){
    oribet = "-" + oribet;
  }
  ctx.fillText(oribet + " → ", canvasWidth/2.8, canvasHeight/1.1);
  ctx.font = '36pt Arial';
  ctx.fillText("持ちコイン", canvasWidth/2, canvasHeight/1.2);
  placeImage(imgs , 2 , 1.8 , 1.15 , 65 , 35 );
  ctx.fillText("X "+ ori, canvasWidth/1.63, canvasHeight/1.09);
  if(resultTime < 150)
    return;
  if(resultTime %5 != 0)
    return;
  if(!(ori == bet)){
    if(ori<bet){
      ori ++;
        var sound = new Audio('data/sound/gcoin.ogg');
        sound.play();
    }else if(ori>bet){
      ori--;
        var sound = new Audio('data/sound/ggain.ogg');
        sound.play();
    }
  }else{
    next = true;
    if(bet == 0)
      islose = true;
  }
}

function resultCalc(){
  if(isResultCalc)
    return;
  isResultCalc = true;
  leftNum = (leftNum == 1 ? 14 : leftNum) ;
  rightNum = (rightNum == 1 ? 14 : rightNum) ;
  centerNum = (centerNum == 1 ? 14 : centerNum) ;
  if(leftNum < centerNum && rightNum > centerNum){
    text = "勝ち";
    var sound = new Audio('data/sound/gmaru.ogg');
    sound.play();
    switch(split){
      case 1 :
        bet = bet + fightbet * 6 ;
        break;
      case 2 :
        bet = bet + fightbet * 5 ;
        break;
      case 3 :
        bet = bet + fightbet * 3 ;
        break;
      default :
        bet = bet + fightbet * 2 ;
    }
  }else if( leftNum == centerNum && centerNum == rightNum){
    text = "RedDog";
    bet = bet + fightbet * 12; ;
  }else if(leftNum == rightNum){
    text = "引き分け";
    bet = bet + fightbet;
    var sound = new Audio('data/sound/gdraw.ogg');
    sound.play();
  }else if(rightNum - leftNum == 1){
    text = "引き分け";
    bet = bet + fightbet;
    var sound = new Audio('data/sound/gdraw.ogg');
    sound.play();
  }else{
    text = "負け";
    ori = bet + fightbet;
    var sound = new Audio('data/sound/gbatu.ogg');
    sound.play();
  }
}

//-------------------------------------------------------ゲームシステム:end

//var sound = new Audio('data/sound/brk.ogg');
//sound.play();

var islose =false;
var isloseSound = false;
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

function debugText(b , text){
}


function stopTimer(){
 clearInterval(testTimer);
}


var interval = setInterval(draw, 20);
[endscript]

[s]
