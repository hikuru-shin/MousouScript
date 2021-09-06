[bg  storage="stage6.png"  time="300"  ]

@playbgm storage=trump2.ogg time=10 volume=50



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

//jsファイルの読み込み
var el = document.createElement("script");
el.src = "./data/others/js/test.js";
document.body.appendChild(el);


var ctx = $('canvas')[0].getContext('2d');
var canvasWidth = $('canvas')[0].width;
var canvasHeight = $('canvas')[0].height;
var bet = sf.getcoin;//これが持ちメダル,外からの変数を代入してね
var gCoin = 0;
var eCoin = 0;
var fightbet = 0;

var getCoin = 1;

//-----------------------------------------------------end
//-----------------------------------------------------ゲームシステム
var startGame = 0;
var score = 40;//これば持ちメダル,外からの変数を代入してね
var mouseFirst = true;
var time = 0 ;
var isYazirusi = false;
var isShuffule = false;
var isScardOnMouse = false;
var isButtonOnMouse = false;
var isMcardOnMouse = false;
var isResult = false;
//-----------------------------------------------------カードシステム
var mCard = { x: getWidth(1083) , y: getHeight(230) , padding : 0};
var hcard = [];
hcard[0] = { x : 3.02 , y : 1.375 , num : 0 , padding : 0};
hcard[1] = { x : 2.27 , y : 1.375 , num : 0 , padding : 0};
hcard[2] = { x : 1.8 , y : 1.375 , num : 0 , padding : 0};
hcard[3] = { x : 1.505 , y : 1.375 , num : 0 , padding : 0};
var hcardWidth = 120;
var hcardHeight = 180;
var ex = {x:1.725 , y : 48 , num : 0 };
var exWidth = 126;
var exHeight = 178;
var checkCard = { x : getWidth(645) , y : getHeight(275) , num :0 };
var checkCardWidth = 117;
var checkCardHeight = 170;
var dcard = [];
var dhfirst = 72;
var dhsecond = 3.891;
var dhthrd =  2;
var dhforth = 1.345;
var dxfirst = 64;
var dxsecond = 8.53;
var dxthrd = 4.57;
dcard[0] = {x:dxfirst ,y : dhfirst , num : 0, padding : 0};
dcard[1] = {x:dxsecond ,y : dhfirst , num : 0, padding : 0};
dcard[2] = {x:dxthrd ,y : dhfirst , num : 0, padding : 0};
dcard[3] = {x:dxfirst ,y : dhsecond , num : 0, padding : 0};
dcard[4] = {x:dxsecond ,y : dhsecond , num : 0, padding : 0};
dcard[5] = {x:dxthrd ,y : dhsecond , num : 0, padding : 0};
dcard[6] = {x:dxfirst ,y : dhthrd , num : 0, padding : 0};
dcard[7] = {x:dxsecond ,y : dhthrd , num : 0, padding : 0};
dcard[8] = {x:dxthrd ,y : dhthrd , num : 0, padding : 0};
dcard[9] = {x:dxfirst ,y : dhforth , num : 0, padding : 0};
dcard[10] = {x:dxsecond ,y : dhforth , num : 0, padding : 0};
dcard[11] = {x:dxthrd ,y : dhforth , num : 0, padding : 0};
var dcardWidth = 110;
var dcardHeight = 165;

var dcardnum = 0;
var cardSystem = [1,2,3,4,5,6,7,8,9,10,11,12,13];

var selectCard = 99;
var selectCardNum = [];
var selectCardX = 538;
var selectCardY = 13;

var resultNum = 0;
//-----------------------------------------------------ボタン設定
var hitButton = 5;
var hitButtonX = 975;
var hitButtonY = 35;
var hitButtonWidth = 240;
var hitbuttonHeight = 150;
var betButton = 12;
var pBetButtonX = 30;
var pBetButtonY = 1.2;
var mBetButtonX = 12;
var mBetButtonY = 1.2;
var buttonWidth = 250;
var buttonHeight = 150;
//-----------------------------------------------------テキストエリア

var stylerect = "rgb(200,255,10)";
var leftRectX = 3;
var leftRectY = 3;
var rightRectX = 1.59;
var rightRectY = 3;
var rectWidth = 200;
var rectHeight = 240;
var textStyle = "rgb(255,0,0)";
var leftTextX = 2.93;
var leftTextY = 2.64;
var fontsize = 32;
//----------------------------------------------------
var yWidth = 0;
var sss = exWidth;
var isHcardOnMouse = false;
var hnum = 0;
var mainus = 0;
var textTime = 0;
var gback = 3 ;

var fScore = 0;
var resultMax = 0;
startButton = 1;
startButtonX = 4;
startButtonY = 2;

//初期化
function init(){
  fightbet = 0;
  startButton = 1;
  startGame = 0;
  score = 40;//これば持ちメダル,外からの変数を代入してね
  time = 0 ;
  isYazirusi = false;
  isShuffule = false;
  isScardOnMouse = false;
  isButtonOnMouse = false;
  isMcardOnMouse = false;
  isResult = false;
  hcard = [];
  hcard[0] = { x : 3.02 , y : 1.375 , num : 0 , padding : 0};
  hcard[1] = { x : 2.27 , y : 1.375 , num : 0 , padding : 0};
  hcard[2] = { x : 1.8 , y : 1.375 , num : 0 , padding : 0};
  hcard[3] = { x : 1.505 , y : 1.375 , num : 0 , padding : 0};
  ex = {x:1.725 , y : 48 , num : 0 };
  checkCard = { x : getWidth(645) , y : getHeight(275) , num :0 };
  dcard = [];
  dcard[0] = {x:dxfirst ,y : dhfirst , num : 0, padding : 0};
  dcard[1] = {x:dxsecond ,y : dhfirst , num : 0, padding : 0};
  dcard[2] = {x:dxthrd ,y : dhfirst , num : 0, padding : 0};
  dcard[3] = {x:dxfirst ,y : dhsecond , num : 0, padding : 0};
  dcard[4] = {x:dxsecond ,y : dhsecond , num : 0, padding : 0};
  dcard[5] = {x:dxthrd ,y : dhsecond , num : 0, padding : 0};
  dcard[6] = {x:dxfirst ,y : dhthrd , num : 0, padding : 0};
  dcard[7] = {x:dxsecond ,y : dhthrd , num : 0, padding : 0};
  dcard[8] = {x:dxthrd ,y : dhthrd , num : 0, padding : 0};
  dcard[9] = {x:dxfirst ,y : dhforth , num : 0, padding : 0};
  dcard[10] = {x:dxsecond ,y : dhforth , num : 0, padding : 0};
  dcard[11] = {x:dxthrd ,y : dhforth , num : 0, padding : 0};
  dcardnum = 0;
  cardSystem = [1,2,3,4,5,6,7,8,9,10,11,12,13];

  selectCard = 99;
  selectCardNum = [];

  resultNum = 0;
  stylerect = "rgb(200,255,10)";
  textStyle = "rgb(255,0,0)";
  fontsize = 32;
  yWidth = 0;
  sss = exWidth;
  isHcardOnMouse = false;
  hnum = 0;
  mainus = 0;
  textTime = 0;
  gback = 3;
}
//--------------------------------------------------------key＆mouseAction

document.addEventListener("keydown", keyDownHandler, false); //key押下時
document.addEventListener("keyup", keyUpHandler, false); //key押下時
document.addEventListener("mousemove", mouseMoveHandler, false); //マウス操作
document.addEventListener("click", mouseClickHandler, false); //マウスクリック


function keyDownHandler(e) {
    console.log(e.keyCode);
    app();
}
function keyUpHandler(e) {
}
function mouseMoveHandler(e) {
  if(startGame == 0){
    isButtonOnMouse = false;
    gback = buttonOnMouse(4 , 3 , getWidth(700) , getHeight(360) ,e,250,150);
    betButton = buttonOnMouse( 13 , 12 , pBetButtonX , pBetButtonY , e ,buttonWidth/4 , buttonHeight/2);
    betButton = buttonOnMouse( 14 , betButton , mBetButtonX , mBetButtonY , e ,buttonWidth/4 , buttonHeight/2);
    startButton = buttonOnMouse( 2 , 1 , startButtonX , startButtonY , e , buttonWidth , buttonHeight);
  }
  if(startGame==1 && !isYazirusi){
    isButtonOnMouse = false;
    isHcardOnMouse = false;
    isMcardOnMouse = false;
    hnum = 0;
    for(var h of hcard){
      h.padding = hcardOnMouse(h.x , h.y , e , hcardWidth , hcardHeight);
      if(h.padding==20) hnum = h.num;
      if(h.num==0) h.padding = 0;
    }
    for(var d of dcard){
      d.padding = hcardOnMouse(d.x , d.y , e , dcardWidth , dcardHeight);
      if(d.padding==20) hnum = d.num;
    }
    mCard.padding = mcardOnMouse(mCard.x , mCard.y , e, 170 ,250);
    hitButton = buttonOnMouse(6,5,getWidth(hitButtonX),getHeight(hitButtonY),e,hitButtonWidth,hitbuttonHeight);
  }
  if(startGame==2){
    for(var i = 1; i< cards.length; i++){
      cards[i].padding =  ScardOnMouse( getWidth(i*80),2,e ,hcardWidth , hcardHeight);
    }
  }
}

function mcardOnMouse( x , y , e , bWidth , bHeight){
  if(isMcardOnMouse) return 0;
  if(e.offsetX > canvasWidth/x && e.offsetX < canvasWidth/x+bWidth && e.offsetY > canvasHeight/y && e.offsetY < canvasHeight/y+bHeight){
    isMcardOnMouse =true;
    return 20;
  }else
    return 0;
}

function hcardOnMouse( x , y , e , bWidth , bHeight){
  if(isHcardOnMouse) return 0;
  if(e.offsetX > canvasWidth/x && e.offsetX < canvasWidth/x+bWidth && e.offsetY > canvasHeight/y && e.offsetY < canvasHeight/y+bHeight){
    isHcardOnMouse =true;
    return 20;
  }else
    return 0;
}


function ScardOnMouse( x , y , e , bWidth , bHeight){
  if(isScardOnMouse) return false;
  if(e.offsetX > canvasWidth/x && e.offsetX < canvasWidth/x+bWidth && e.offsetY > canvasHeight/y && e.offsetY < canvasHeight/y+bHeight){
    isScardOnMouse =false;
    return true;
  }else
    return false;
}

function buttonOnMouse( a , b , x , y , e , bWidth , bHeight){
  if(isButtonOnMouse) return b;
  if(e.offsetX > canvasWidth/x && e.offsetX < canvasWidth/x+bWidth && e.offsetY > canvasHeight/y && e.offsetY < canvasHeight/y+bHeight){
    isButtonOnMouse =true;
    return a;
  }else
    return b;
}

function mouseClickHandler(e){
  if(mouseFirst) {
    mouseFirst = false;
    return;
  }
  var gamecount = startGame;
  switch(gamecount){
    case 0 :
      if(gback==4){
        clearInterval(interval);
        tyrano.plugin.kag.variable.sf.getcoin = bet;
        //タイトルに戻るところ、変数resultMaxを外の変数に入れてね:Title
        const TG = tyrano.plugin.kag;
        const tmp = TG.stat.is_strong_stop;
        TG.stat.is_strong_stop = true;
        tyrano.plugin.kag.ftag.startTag('jump', {
          storage: "returns.ks",
          });
        if (!tmp) TG.stat.is_strong_stop = false;
      }
      if(startButton ==2){
      startGame = 1;
      shuffle();
      fScore = 0;
      }
      switch(betButton){
        case 13 :
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
        case 14 :
        if(fightbet>0){
          fightbet--;
          getCoin--;
          bet++;
          var sound = new Audio('data/sound/ggain.ogg');
          sound.play();
        }
        break;
      }
    break;
    case 1 :
      var i = 0;
      for(var h of hcard){
        if(h.padding == 20){
          h.padding=0;
          checkCard.num = h.num;
          isYazirusi = true;
          resultNum = 0;
          cardSystem.splice(i+1,1);
          }
          i++;
      }
      if(hitButton%2==0){
        startGame =2;
        hitButton = hitButton -1;
      }
    break;
    case 2 :
      if(selectCard!=99){
        startGame = 1;
        selectCardNum.push(selectCard);
        check(selectCard);
        selectCard == 99;
      }else{
        startGame = 1;
      }
    break;
    case 3 :
      var xx = 0;
      if(fScore<41){
        xx = 0;
      }else if(fScore < 60){
        xx = 1;
      }else if(fScore < 81){
        xx = 2;
      }else if(fScore < 101){
        xx = 3;
      }else{
        xx = 4;
      }
      gCoin = xx*fightbet;
      bet += gCoin;
      init();
    break;
  }
}
//--------------------------------------------------------key＆mouseAction:end

function check(num){
  if(selectCardNum.length<4){
    if(cardSystem[0]!=num){
      var sound = new Audio('data/sound/gbatu.ogg');
      sound.play();
      score -= 20;
    }else{
      isResult = true;
      startGame = 4;
    }
  }else if(selectCardNum.length == 4){
    if(cardSystem[0]!=num){
      var sound = new Audio('data/sound/gbatu.ogg');
      sound.play();
      score -= 20;
    }else{
      isResult = true;
    }
    startGame =4;
  }
}

//--------------------------------------------------------画像をプリロード

//画像保存場所
var imgs_url= [
  "data/bgimage/prestage.png",
  "data/bgimage/gplay1.png",
  "data/bgimage/gplay2.png",
  "data/bgimage/gback1.png",
  "data/bgimage/gback2.png",
  "data/bgimage/gpre1.png",
  "data/bgimage/gpre2.png",
  "data/bgimage/yazirusi.png",
  "data/bgimage/greturn1.png",
  "data/bgimage/greturn2.png",
  "data/bgimage/pretitle.png",
  "data/bgimage/coin.png",
  "data/bgimage/plmn1.png",
  "data/bgimage/plmn2.png",
  "data/bgimage/plmn3.png",
];

//カード画像保存場所
var card_url = [];
var cardlist = 14;
card_url.push("data/bgimage/card/trump_back.png");
for(var i = 1; i < cardlist ; i++){
  card_url.push("data/bgimage/card/tr" + i +".png");
}

//カードエフェクト保存場所
var cardEffect_url = [];
var cardEffectlist = 14;
cardEffect_url.push("data/bgimage/card/trump_back.png");
for(var i = 1; i < cardEffectlist ; i++){
  cardEffect_url.push("data/bgimage/cardEffect/num" + i +".png");
}

//リザルト保存場所
var result_url = [];
var resultlist = 27;
result_url.push("data/bgimage/card/trump_back.png");
for(var i = 1; i < resultlist ; i++){
  result_url.push("data/bgimage/cardResult/add" + i +".png");
}
result_url.push("data/bgimage/cardResult/cbatu.png");
result_url.push("data/bgimage/cardResult/cmaru.png");


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
  cards[i].padding = false;
  prelord(cards , card_url , i);
}

//カードエフェクト(呼び出し用)
var effects = new Array(cardEffect_url.length);
for(var i =0 ;i < effects.length;i++){
  effects[i] = new Image();
  effects[i].src = cardEffect_url[i];
  effects[i].padding = false;
  prelord(effects , cardEffect_url , i);
}

//リザルト(呼び出し用)
var results = new Array(result_url.length);
for(var i =0 ;i < results.length;i++){
  results[i] = new Image();
  results[i].src = result_url[i];
  results[i].padding = false;
  prelord(results , result_url , i);
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
}

function drawRect( style , x , y , width , height ){
  ctx.beginPath();
  ctx.fillStyle = style;
  ctx.fillRect(canvasWidth/x, canvasHeight/y, width, height );
  ctx.fill();
  ctx.closePath();
}

function drawText(x , y , fontsize , style , text){
  ctx.font = fontsize + 'pt Arial';
  ctx.fillStyle = style;
  ctx.fillText(text , canvasWidth/x, canvasHeight/y);
}

//--------------------------------------------------------画像描画:end
//----------------------------------------------------
function setHcard(){
  for(var i = 0; i<hcard.length; i++){
    if(cardSystem.length-1>i){
      hcard[i].num=cardSystem[i+1];
    }else{
      hcard[i].num=0;
    }
  }
}


function shuffle(){
  if(isShuffule) return;
  for(var i = 0 ; i < cardSystem.length-1 ; i++){
    var num = cardSystem[i];
    var ran = getRandom(1,12);
    cardSystem[i] = cardSystem[ran];
    cardSystem[ran] = num;
  }
  isShuffule = true;
  //console.log(cardSystem);
}

function startDraw(){
  placeImage(imgs , 10, canvasWidth-1 , canvasHeight -1 , canvasWidth , canvasHeight);
  placeImage(imgs , gback , getWidth(700) , getHeight(360) , 250 , 150);
  drawRect("rgba(0,0,0,0.5)" , getWidth(970) , getHeight(560) , 300 , 150);
  placeImage(imgs , startButton , startButtonX , startButtonY , buttonWidth , buttonHeight);
  //drawText(getWidth(980), getHeight(610) , 24 , "rgb(255,255,255)", "最高RESULT : " + resultMax );
  //drawText(getWidth(980), getHeight(680) , 24 , "rgb(255,255,255)", "前回RESULT : " + fScore );
  placeImage(imgs , betButton , 30 , 1.2 , buttonWidth/2 , buttonHeight/2);
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
  ctx.fillText("GETコイン", canvasWidth/1.3, canvasHeight/1.2);
  placeImage(imgs , 11 , 1.14 , 1.25 , 65 , 35 );
  ctx.fillText("X "+tex+ gCoin, canvasWidth/1.07, canvasHeight/1.2);
  //所持コイン
  ctx.fillStyle = "rgb(255,255,255)";
  ctx.font = '20pt Arial';
  ctx.fillText("所持コイン", canvasWidth/1.14, canvasHeight/1.1);
  placeImage(imgs , 11 , 1.14 , 1.07 , 65 , 35 );
  ctx.fillText("X "+bet, canvasWidth/1.07, canvasHeight/1.03);
  //コイン
  for(var i = 0; i < fightbet ; i++){
    var h = 1.6 + i *0.05;
    placeImage(imgs , 11 , 32 , h , 129 , 70 );
  }

  //枚数
  ctx.font = '36pt Arial';
  ctx.fillStyle = "rgb(255,255,255)";
  ctx.fillText(fightbet + "枚", canvasWidth/20, canvasHeight/1.27);
}

function selectDraw(){
  setHcard();
  placeImage(imgs , 0, canvasWidth-1 , canvasHeight -1 , canvasWidth , canvasHeight);
  if(cardSystem.length>5)
    placeImage(cards , 0 , mCard.x, mCard.y , 170 -mCard.padding , 250 - mCard.padding);//山札
  placeImage(cards , 0 , ex.x, ex.y , exWidth , exHeight);//あたりカード
  if(checkCard.num != 0)
    placeImage(cards , checkCard.num , checkCard.x, checkCard.y , checkCardWidth , checkCardHeight);//チェックカード
  for(var h of hcard){
    if(h.num!=0)
      placeImage(cards , h.num , h.x , h.y , hcardWidth-h.padding , hcardHeight - h.padding);
  }
  for(var d of dcard){
    if(d.num!=0)
      placeImage(cards , d.num , d.x , d.y , dcardWidth - d.padding , dcardHeight - d.padding);
  }
  if(hnum!=0){
    placeImage(effects , hnum , getWidth(415) , getHeight(220), 210 , 270);
  }
  if(resultNum!=0){
    placeImage(results , resultNum , getWidth(782) , getHeight(220), 210 , 270);
  }
  ctx.drawImage(imgs[7],0,0,yWidth,30,631,229,yWidth,30);
  for(var i = 0 ; i < selectCardNum.length; i++){
    placeImage(cards , selectCardNum[i] , getWidth(selectCardX+i*20) ,getHeight(selectCardY) , exWidth,exHeight );
  }
  placeImage(imgs , hitButton , getWidth(hitButtonX),getHeight(hitButtonY),hitButtonWidth,hitbuttonHeight);
  if(isYazirusi)
    yazirusi();
  mainus = 0;
  for(var d of dcard)
    mainus += d.num;
  drawText(getWidth(1125) , getHeight(655) , 64 , "rgba(252,252,0,0.8)" , score-mainus);
  if(mCard.padding==20){
    var lastCard = 0;
    if(cardSystem.length -5 > 0) lastCard = cardSystem.length -5 ;
    drawText(getWidth(425) , getHeight(350) , 32 ,"rgba(252,252,0,0.8)" , "山札残："+lastCard);
  }
}

function yazirusi(){
  //矢印システム
  if(yWidth<147){
    yWidth+=2;
  }else if(yWidth == 148){
    if(checkCard.num != 0){
    cardEffect(checkCard.num);
    dcard[dcardnum].num = checkCard.num;
    checkCard.num = 0;
    if(dcardnum<13)
      dcardnum++;
    }
    yWidth=0;
    isYazirusi = false;
  }
}

function cardEffect(num){
  switch(num){
    case 1 :
    case 2 :
    case 3 :
    resultNum = 0 ;
    break;
    case 4 :
      if(dcard[0].num!=0){
        var max = 0 ;
        for(var i = 0 ; i < dcard.length; i++){
          if(max<dcard[i].num)
            max = dcard[i].num;
        }
        resultNum = max ;
        score += max;
      }
    break;
    case 5 :
      if(cardSystem[0] % 2 ==0)
        resultNum = 28;//sound
      else
        resultNum = 27;//sound
    break;
    case 6 :
      if(cardSystem.length>5){
        dcard[dcardnum].num = cardSystem[5];
        dcardnum++;
        cardSystem.splice(5,1);
      }
      resultNum = 0;
    break;
    case 7 :
      if(cardSystem[0]>6)
        resultNum = 28;//sound
      else
        resultNum = 27;//sound
    break;
    case 8 :
      if(dcard[0].num!=0){
        var max = 0 ;
        var min = 13;
        for(var i = 0 ; i < dcard.length; i++){
          if(max<dcard[i].num)
            max = dcard[i].num;
          if(dcard[i].num != 0){
          if(min>dcard[i].num)
            min = dcard[i].num;
          }
        }
        resultNum = max + min;
        score += (max + min);
        }
    break;
    case 9 :
      if(cardSystem[0]%3 == 0)
        resultNum = 28;//sound
      else
        resultNum = 27;//sound
    break;
    case 10 :
      if(dcard[0].num!=0){
        cardEffect(dcard[dcardnum-1].num);
      }
    break;
    case 11 :
      if(cardSystem[0]==2 || cardSystem[0]==3 || cardSystem[0]==5 || cardSystem[0]==7 || cardSystem[0] == 13)
        resultNum = 28; //sound
      else
        resultNum = 27; //sound
    break;
    case 12 :
      if(dcard[0].num!=0){
        var max = 0 ;
        for(var i = 0 ; i < dcard.length; i++){
          if(max<dcard[i].num)
            max = dcard[i].num;
        }
        resultNum = max*2 ;
        score += (max *2);
      }
    break;
    case 13 :
      resultNum = 20;
      score += 20;
    break;
  }
}

function predictDraw(){
  selectDraw();
  drawRect(alpaStyle , 25.6,3,1180,430);
  selectCard = 99;
  for(var i = 1; i< cards.length; i++){
    placeImage(cards , i , getWidth(i*80) , 2 , hcardWidth , hcardHeight);
    if(cards[i].padding){
      selectCard = i;
    }
  }
  if(selectCard != 99){
    placeImage(cards , selectCard , getWidth(selectCard*80) , 2 , hcardWidth + 20 , hcardHeight + 20);
  }
}

//-------------------------------------------------------ゲームシステム:end

function getWidth(x){
  return canvasWidth/x;
}
function getHeight(y){
  return canvasHeight/y;
}

var alpaStyle = "rgba(0,0,0,0.8)";

function draw() {
  switch(startGame){
    case 0 :
      startDraw();
    break;
    case 1 :
      selectDraw();
      if(score - mainus<0)
        startGame = 4;
    break;
    case 2 :
      predictDraw();
    break;
    case 3 :
      selectDraw();
      placeImage(cards , cardSystem[0] , ex.x, ex.y , exWidth , exHeight);//あたりカード
      if(isResult){
        drawRect("rgba(255,255,255,0.5)" , getWidth(10),getHeight(360), 1260 , 350);
        var deckbonus = (cardSystem.length -5)*10;
        if(deckbonus<0) deckbonus = 0;
        if(textTime>20)
          drawText(getWidth(425) , getHeight(465) , 64 , "rgb(0,0,0)" , "GAME CLEAR");
        if(textTime>40)
          drawText(getWidth(525) , getHeight(515) , 32 , "rgb(0,0,0)" , "GAME SCORE :  " + (score - mainus)   );
        if(textTime>55)
          drawText(getWidth(525) , getHeight(565) , 24 , "rgb(0,0,0)" , "PREDICT BONUS :+" + (40 - selectCardNum.length *10) );
        if(textTime>65){
          drawText(getWidth(525) , getHeight(615) , 24 , "rgb(0,0,0)" , "DECK       BONUS :+" + deckbonus );
        }
        if(textTime>80)
          drawText(getWidth(425) , getHeight(685) , 64 , "rgb(0,0,0)" , "RESULT : " + (score - mainus + (40 - selectCardNum.length *10) + deckbonus ));
        if(textTime<100)
          textTime++;
        fScore = score - mainus + (40 - selectCardNum.length *10) + deckbonus;
        if(resultMax<fScore) resultMax = fScore;
      }else{
        drawRect("rgba(0,0,0,0.5)" , getWidth(10),getHeight(360), 1260 , 350);
        drawText(getWidth(425) , getHeight(465) , 64 , "rgb(255,255,255)" , "GAME OVER");
        fScore = 0;
      }
    break;
    case 4 :
      selectDraw();
      placeImage(cards , cardSystem[0] , ex.x, ex.y , exWidth , exHeight);//あたりカード
      if(sss>0){
        ctx.drawImage(cards[0],0,0,exWidth,exHeight,canvasWidth/ex.x,canvasHeight/ex.y,sss,exHeight);
        sss-=3;
      }else{
        startGame = 3;
      }
    break;
  }
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
