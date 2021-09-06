*start
;-----------------------------------------------------書き換え用
[title name="ステージ1：難易度HARD"]

[bg  storage="wv.gif" time="10"  ]
@eval exp="tf.elose1=sf.reset"
@eval exp="tf.eflag1=sf.reset"

;-----------------------------------------------------書き換え用
@fadeinbgm storage=abgm9.ogg time=7000 volume=50
;abgm11
[layopt layer=0 visible=true]

;-------------------------------js
[iscript]

//-----------------------------------------------------------------Canvas
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
//----------------------------------------------------------------END

//-
var elife1 = 15;

var eflag1 = 0;

//クリア時の外的要因の追加
var spclear1 = false;
var spclear2 = false;
var spnclear1 = false;
var spnclear2 = false;

var elose1 = 0;

//-----------------------------------------------------------------------------

//-
var debugMode = false;

/////デバッグモード管理者用
 // [debugModeCommand description]
 // @type {Boolean}
 ///
var debugModeCommand = false;

//--------------------------------------------------------------


/////画面停止判定
 // [pause 画面停止用変数]
 // @type {Boolean}
 ///
var pause = false;

/////画面停止時パターン
 // [pauseCase 画面停止パターン変数]
 // @type {Number}
 ///
var pauseCase = 0;

/////総時間
 // [time 総時間変数]
 // @type {Number}
 ///
var time = 0;

/////スコア
 // [score スコア保管用変数]
 // @type {Number}
 ///
var score = 100000;

/////秒間あたりの減少数
 // [scoreDegTime 減少変数]
 // @type {Number}
 ///
var scoreDegTime = 10;
//----------------------------------------------------------------ボール初期設定
/////ボールの大きさ
 // [ballRadius description]
 // @type {Number}
 ///
var ballRadius = 7;

/////ボールのx座標
 // [x description]
 // @type {Number}
 ///
var x = 110;

/////ボールのy座標
 // [y description]
 // @type {[type]}
 ///
//var y = $('canvas')[0].height-107;
var y = 60;

/////ボールのx座標加速度
 // [dx description]
 // @type {Number}
 ///
var dx = +5;

/////ボールのy座標加速度
 // [dy description]
 // @type {Number}
 ///
var dy = -5;

/////ひとつ前のボールのx座標
 // [lastx description]
 // @type {Number}
 ///
var lastx = 0;

/////ひとつ前のボールのy座標
 // [lasty description]
 // @type {Number}
 ///
var lasty = 0;

/////ボールの貫通モード判定
 // [enatlation description]
 // @type {Number}
 ///
var enatlation = 0;

/////ボールの発射判定
 // [waitBall description]
 // @type {Number}
 ///
var waitBall = 0;

/////ボールの発射しているか判定
 // [start description]
 // @type {Number}
 ///
var start = 0;

/////スタート角度決定用
 // [startalfanum description]
 // @type {Number}
 ///
var startalfanum = 0;

/////
 // スタート角度可否判定
 // @type {Boolean}
 ///
var isStartalfa = true;

/////スタート角度可否判定
 // [isStartalfanum description]
 // @type {Number}
 ///
var isStartalfanum = 0;

/////スタート角度数格納用
 // [startalfa description]
 // @type {Array}
 ///
var startalfa = [];
startalfa[0] = {x:30,y:70};
startalfa[1] = {x:60,y:40};
startalfa[2] = {x:100,y:0};
startalfa[3] = {x:60,y:-40};
startalfa[4] = {x:30,y:-70};
/////パドル画像の高さ
 // [paddleHeight description]
 // @type {Number}
 ///
var paddleHeight = 100;

/////パドル画像の横幅
 // [paddleWidth description]
 // @type {Number}
 ///
var paddleWidth = 100;

/////パドルのx座標
 // [paddleX description]
 // @type {Number}
 ///
var paddleX = 0;

/////パドルのy座標
 // [paddleY description]
 // @type {Number}
 ///
var paddleY = 1000;

/////パドルのキーボード操作用
 // [UpPressed description]
 // @type {Boolean}
 ///
var UpPressed = false;

/////パドルのキーボード操作用
 // [DownPressed description]
 // @type {Boolean}
 ///
var DownPressed = false;
//------------------------------------------------------------ブロックの初期設定
/////ブロックの個数
 // [brickCum description]
 // @type {Number}
 ///
var brickCum = 0;

/////ブロックの列数
 // [brickRowCount description]
 // @type {Number}
 ///
var brickRowCount =36;

/////ブロックの行数
 // [brickColumnCount description]
 // @type {Number}
 ///
var brickColumnCount = 53;

/////ブロックの横幅
 // [brickWidth description]
 // @type {Number}
 ///
var brickWidth = 20;

/////ブロックの高さ
 // [brickHeight description]
 // @type {Number}
 ///
var brickHeight = 20;

/////ブロック間の余白
 // [brickPadding description]
 // @type {Number}
 ///
var brickPadding = 0;

/////ブロック間の上余白
 // [brickOffsetTop description]
 // @type {Number}
 ///
var brickOffsetTop = 0;

/////ブロック間の左余白
 // [brickOffsetLeft description]
 // @type {Number}
 ///
var brickOffsetLeft = 80;

/////生成ブロック管理用
 // [bricks description]
 // @type {Array}
 ///
var bricks = [];

/////ブロックの初期設定(statusをすべて0)
 // [for description]
 // @param  {[type]} var [description]
 // @return {[type]}     [description]
 ///
for(var c=0; c<brickColumnCount; c++) {
    bricks[c] = [];
    for(var r=0; r<brickRowCount; r++) {
      bricks[c][r] = { x: 0, y: 0, status: 0 };
    }
}
//----------------------------スキルゲージ設定
/////
 // スキルの稼働時間
 // @type {Number}
 ///
var skillTime = 0;

/////
 // 貫通モードの持続時間
 // @type {Number}
 ///
var skillTimeEnalation = 0;

/////
 // 貫通モードのゲージ時間
 // @type {Number}
 ///
var skillgageEliminate = 0;

/////
 // レーザーのゲージ時間
 // @type {Number}
 ///
var skillgageLaser = 0;

/////
 // 自爆機能のゲージ時間
 // @type {Number}
 ///
var skillgageGback = 0;

/////
 // 自爆の機能
 // @type {Number}
 ///
var backGX = 0;
var backGXX = 0;
var backGXY = 0;

/////
 // 自爆機能稼働可否
 // @type {Boolean}
 ///
var isBackGXX = false;

/////
 // 貫通機能稼働可否
 // @type {Boolean}
 ///
var isEnatlation = true;

/////レーザーskill停止時間
 // [laserWaitTime description]
 // @type {Number}
 ///
var laserWaitTime = 90;

/////貫通skill停止時間オリジナル
 // [skillTimeEnalationOrigin description]
 // @type {Number}
 ///
var skillTimeEnalationOrigin = 0;

/////貫通skill停止時間
 // [enatlationWaitTime description]
 // @type {Number}
 ///
var enatlationWaitTime  = 250;

/////自爆skill停止時間
 // [gbackWaitTime description]
 // @type {Number}
 ///
var gbackWaitTime = 50;

//------------------------------------------
var imgs_url= [
  "data/bgimage/paddle.png",

  //上に描画する画像
  "data/bgimage/ast1.png",

  //下に描画する画像
  "data/bgimage/ast4.png",

  "data/bgimage/block/pause.png",
  "data/bgimage/block/Rlaser1.png",
  "data/bgimage/block/Rlaser2.png",
  "data/bgimage/block/Rlaser3.png",
  "data/bgimage/block/bakuhatu.png",
  "data/bgimage/block/skill3.png",
  "data/bgimage/block/skill2.png",
  "data/bgimage/block/skill1.png",
  "data/bgimage/block/fan1.png",
  "data/bgimage/block/fan2.png",
  "data/bgimage/block/fan3.png",
  "data/bgimage/block/fan4.png",
  "data/bgimage/block/fog1.png",
  "data/bgimage/block/fog2.png",
  "data/bgimage/block/fog3.png",
  "data/bgimage/block/eyes1.png",
  "data/bgimage/block/eyes2.png",
  "data/bgimage/block/eyes1_ori.png",
  "data/bgimage/block/eyes2_ori.png",
  "data/bgimage/block/fan11.png",
  "data/bgimage/block/fan21.png",
  "data/bgimage/block/fan31.png",
  "data/bgimage/block/fan41.png",
  "data/bgimage/block/laser1.png",
  "data/bgimage/block/laser2.png",
  "data/bgimage/block/laser3.png"
];
var imgs = new Array(imgs_url.length);
for(var i =0 ;i < imgs.length;i++){
  imgs[i] = new Image();
  imgs[i].src = imgs_url[i];
  prelord(imgs , imgs_url , i);
}

function prelord(array , list , num){
  array[num].onload = function(){
  var img = document.createElement('img');
  img.src = list[num];
  }
}
//@Add 外的要因の追加
//三か所への画像追加
var isDrawOuter = [];
isDrawOuter[3] = {isDraw:true , num:11 , x:1040 , y:250 , attrCount:0 , isAttr:false , life:3};
isDrawOuter[4] = {isDraw:true , num:11 , x:1040 , y:500 , attrCount:0 , isAttr:false , life:3};
isDrawOuter[0] = {isDraw:true , num:18 , x:340 , y:0 , attrCount:0 , isAttr:false , life:3};
isDrawOuter[1] = {isDraw:false , num:18 , x:740 , y:0 , attrCount:0 , isAttr:false , life:3};
isDrawOuter[2] = {isDraw:false , num:20 , x:540 , y:670 , attrCount:0 , isAttr:false , life:3};
//上の[0][1][2]の3つの順番を入れ替えると場所を変えられる

var isBallBakuha = [];
isBallBakuha[0] = {isBaku : false , x :0 , y : 0 , time:0};

var lazerTime = 100;
var fanTime = 100;

//レーザー頻度
var frequence = 100;

var isLaserCount = 1;

var isBrockHerf = false;
/////生成ブロック格納用
 // [brickChange description]
 // @type {Array}
 ///
var brickChange = [];

/////生成ブロック数
 // [brickChangeNum description]
 // @type {Number}
 ///
var brickChangeNum = 0;

//座標を指定して生成するブロックを追加していく
brickChange[brickChangeNum] = { r:4 , cMin:39 , cMax:43 };
brickChange[++brickChangeNum] = { r:5 , cMin:39 , cMax:45 };
brickChange[++brickChangeNum] = { r:6 , cMin:39 , cMax:44 };
brickChange[++brickChangeNum] = { r:6 , cMin:44 , cMax:48 };
brickChange[++brickChangeNum] = { r:7 , cMin:23 , cMax:28 };
brickChange[++brickChangeNum] = { r:7 , cMin:39 , cMax:43 };
brickChange[++brickChangeNum] = { r:7 , cMin:44 , cMax:49 };
brickChange[++brickChangeNum] = { r:7 , cMin:44 , cMax:49 };
brickChange[++brickChangeNum] = { r:8 , cMin:23 , cMax:28 };
brickChange[++brickChangeNum] = { r:8 , cMin:44 , cMax:48 };
brickChange[++brickChangeNum] = { r:9 , cMin:22 , cMax:28 };
brickChange[++brickChangeNum] = { r:9 , cMin:39 , cMax:44 };
brickChange[++brickChangeNum] = { r:9 , cMin:44 , cMax:49 };
brickChange[++brickChangeNum] = { r:10 , cMin:22 , cMax:31 };
brickChange[++brickChangeNum] = { r:10 , cMin:39 , cMax:44 };
brickChange[++brickChangeNum] = { r:11 , cMin:22 , cMax:31 };
brickChange[++brickChangeNum] = { r:11 , cMin:37 , cMax:44 };
brickChange[++brickChangeNum] = { r:12 , cMin:22 , cMax:31 };
brickChange[++brickChangeNum] = { r:12 , cMin:37 , cMax:44 };
brickChange[++brickChangeNum] = { r:13 , cMin:24 , cMax:31 };
brickChange[++brickChangeNum] = { r:13 , cMin:33 , cMax:45 };
brickChange[++brickChangeNum] = { r:14 , cMin:20 , cMax:24 };
brickChange[++brickChangeNum] = { r:14 , cMin:25 , cMax:31 };
brickChange[++brickChangeNum] = { r:14 , cMin:32 , cMax:45 };
brickChange[++brickChangeNum] = { r:15 , cMin:20 , cMax:26 };
brickChange[++brickChangeNum] = { r:15 , cMin:26 , cMax:29 };
brickChange[++brickChangeNum] = { r:15 , cMin:31 , cMax:41 };
brickChange[++brickChangeNum] = { r:16 , cMin:21 , cMax:26 };
brickChange[++brickChangeNum] = { r:16 , cMin:27 , cMax:31 };
brickChange[++brickChangeNum] = { r:16 , cMin:31 , cMax:40 };
brickChange[++brickChangeNum] = { r:17 , cMin:21 , cMax:23 };
brickChange[++brickChangeNum] = { r:17 , cMin:25 , cMax:33 };
brickChange[++brickChangeNum] = { r:17 , cMin:34 , cMax:39 };
brickChange[++brickChangeNum] = { r:18 , cMin:16 , cMax:19 };
brickChange[++brickChangeNum] = { r:18 , cMin:19 , cMax:39 };
brickChange[++brickChangeNum] = { r:19 , cMin:15 , cMax:39 };
brickChange[++brickChangeNum] = { r:19 , cMin:40 , cMax:44 };
brickChange[++brickChangeNum] = { r:20 , cMin:15 , cMax:28 };
brickChange[++brickChangeNum] = { r:20 , cMin:29 , cMax:39 };
brickChange[++brickChangeNum] = { r:20 , cMin:40 , cMax:47 };
brickChange[++brickChangeNum] = { r:21 , cMin:14 , cMax:18 };
brickChange[++brickChangeNum] = { r:21 , cMin:18 , cMax:24 };
brickChange[++brickChangeNum] = { r:21 , cMin:30 , cMax:38 };
brickChange[++brickChangeNum] = { r:21 , cMin:40 , cMax:47 };
brickChange[++brickChangeNum] = { r:22 , cMin:13 , cMax:17 };
brickChange[++brickChangeNum] = { r:22 , cMin:18 , cMax:25 };
brickChange[++brickChangeNum] = { r:22 , cMin:26 , cMax:29 };
brickChange[++brickChangeNum] = { r:22 , cMin:30 , cMax:37 };
brickChange[++brickChangeNum] = { r:22 , cMin:41 , cMax:46 };
brickChange[++brickChangeNum] = { r:23 , cMin:12 , cMax:17 };
brickChange[++brickChangeNum] = { r:23 , cMin:18 , cMax:25 };
brickChange[++brickChangeNum] = { r:23 , cMin:26 , cMax:30 };
brickChange[++brickChangeNum] = { r:23 , cMin:30 , cMax:37 };
brickChange[++brickChangeNum] = { r:23 , cMin:38 , cMax:41 };
brickChange[++brickChangeNum] = { r:23 , cMin:41 , cMax:45 };
brickChange[++brickChangeNum] = { r:24 , cMin:11 , cMax:17 };
brickChange[++brickChangeNum] = { r:24 , cMin:18 , cMax:26 };
brickChange[++brickChangeNum] = { r:24 , cMin:27 , cMax:30 };
brickChange[++brickChangeNum] = { r:24 , cMin:38 , cMax:41 };
brickChange[++brickChangeNum] = { r:24 , cMin:41 , cMax:44 };
brickChange[++brickChangeNum] = { r:25 , cMin:10 , cMax:28 };
brickChange[++brickChangeNum] = { r:25 , cMin:36 , cMax:41 };
brickChange[++brickChangeNum] = { r:26 , cMin:8 , cMax:29 };
brickChange[++brickChangeNum] = { r:26 , cMin:36 , cMax:41 };
brickChange[++brickChangeNum] = { r:27 , cMin:5 , cMax:30 };
brickChange[++brickChangeNum] = { r:27 , cMin:36 , cMax:40 };
brickChange[++brickChangeNum] = { r:28 , cMin:3 , cMax:30 };
brickChange[++brickChangeNum] = { r:28 , cMin:38 , cMax:42 };
brickChange[++brickChangeNum] = { r:29 , cMin:3 , cMax:29 };
brickChange[++brickChangeNum] = { r:29 , cMin:39 , cMax:43 };
brickChange[++brickChangeNum] = { r:30 , cMin:3 , cMax:18 };
brickChange[++brickChangeNum] = { r:30 , cMin:19 , cMax:26 };
brickChange[++brickChangeNum] = { r:30 , cMin:40 , cMax:43 };
brickChange[++brickChangeNum] = { r:31 , cMin:8 , cMax:17 };
brickChange[++brickChangeNum] = { r:31 , cMin:21 , cMax:26 };
brickChange[++brickChangeNum] = { r:31 , cMin:40 , cMax:43 };
brickChange[++brickChangeNum] = { r:32 , cMin:7 , cMax:17 };
brickChange[++brickChangeNum] = { r:32 , cMin:21 , cMax:25 };
brickChange[++brickChangeNum] = { r:32 , cMin:40 , cMax:43 };
brickChange[++brickChangeNum] = { r:33 , cMin:7 , cMax:16 };
brickChange[++brickChangeNum] = { r:33 , cMin:21 , cMax:25 };
brickChange[++brickChangeNum] = { r:34 , cMin:7 , cMax:16 };
brickChange[++brickChangeNum] = { r:34 , cMin:17 , cMax:20 };
brickChange[++brickChangeNum] = { r:34 , cMin:21 , cMax:24 };
brickChange[++brickChangeNum] = { r:35 , cMin:7 , cMax:14 };
brickChange[++brickChangeNum] = { r:35 , cMin:17 , cMax:24 };

/////ブロック生成用変数を元にブロックのstatusを1に変更
 // [for description]
 // @param  {[type]} var [description]
 // @return {[type]}     [description]
 ///
var brockSuu = 0;
for(var c=0; c<brickColumnCount; c++) {
  for(var r=0; r<brickRowCount; r++) {
    for(var i = 0; i <brickChangeNum+1 ; i++){
      if((r==brickChange[i].r) && c < brickChange[i].cMax && c > brickChange[i].cMin){
        bricks[c][r] = { x: 0, y: 0, status: 1 };
        brockSuu++;
      }
    }
  }
}
var brockherf = brockSuu / 2;


/////
 // 押下時の処理を追加
 // @type {[type]}
 ///
document.addEventListener("keydown", keyDownHandler, false);

/////
 // key押下時の機能
 // @param  {[type]} e [description]
 // @return {[type]}   [description]
 ///
function keyDownHandler(e) {
    //console.log(e.keyCode);
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
    //デバッグ用-----------------
    if(debugModeCommand){
      //デバッグモード切り替え
      if(e.keyCode == 84){
        if(debugMode){
          debugMode = false;
        }else{
          debugMode = true;
        }
      }
      //スキルゲージをMaxに
      if(e.keyCode == 89){
        skillgageGback = 90;
        skillgageLaser = 90;
        skillgageEliminate = 90;
      }
    }

}

/////
 // key押上時の機能追加
 ///
document.addEventListener("keyup", keyUpHandler, false);

/////
 // key押上時の機能
 // @param  {[type]} e [description]
 // @return {[type]}   [description]
 ///
function keyUpHandler(e) {
    if(e.keyCode == 80){
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
      skillTime = time + laserWaitTime;
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
      if(skillTimeEnalation>2000){
        //skillTimeEnalation -=2000;
      }
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

/////
 // マウス操作時機能の追加
 ///
document.addEventListener("mousemove", mouseMoveHandler, false);

/////
 // マウス操作時の機能
 ///
 function mouseMoveHandler(e) {
     if(pause) return;
     if(e.clientY < 720 -paddleHeight/2 && e.clientY > paddleHeight/2){
         paddleY = e.clientY - paddleHeight/2;
     }
     if(start == 0){
       y = paddleY+50;
     }
 }
 /////
  // マウスクリック時の機能追加
  ///
 document.addEventListener("click", mouseClickHandler, false);

 /////
  // マウスクリック時の機能
  ///
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
  /////
   // スマホ操作時機能追加
   ///
  document.addEventListener("touchmove", sumartMoveHandler, false);
  /////
   //スマホ操作時機能
   ///
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
       }
   }
   /////
    // 反射時のボールの座標及び結果
    // @param  {[type]} b    [description]
    // @param  {[type]} text [description]
    // @return {[type]}      [description]
    ///
   function debugText(b , text){
         if(debugMode){
         alert("ボールの座標:( " +x+ " , "+ y + " )\n"+
         "前ボール座標:( " +lastx+ " , "+ lasty + " )\n"+
         "ブロクの座標:( " +b.x+" , "+ b.y + " )\n"+
         "ボール加速度:( " +dx +" , "+ dy + " )\n"+
         "結果:"+text);
         }
   }
   /////
    // ボールの描画
    // @return {[type]} [description]
    ///
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
         ctx.fillStyle = 'rgb(0, 255, 0)';
       }else{
         ctx.fillStyle = 'rgb(0, 0, 255)';
       }
       ctx.fill();
       ctx.closePath();
   }
   /////
    // パドルの描画
    // @return {[type]} [description]
    ///
   function drawPaddle() {
         ctx.drawImage(imgs[0],paddleX,paddleY,paddleWidth, paddleHeight);
         ctx.font = '24pt Arial';
         ctx.fillStyle = 'rgb(255, 255, 255)';
         ctx.fillText(elife1, 1225, 90);
         if(elife1 == 0){
         elose1 += 10;
         tyrano.plugin.kag.variable.tf.elose1 = elose1;
         clearInterval(interval);
       }
   }
   /////
    // ブロック描画
    // @return {[type]} [description]
    ///
   function drawBricks() {
       brickCum = 0;
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
                   ctx.strokeStyle = "rgb(255, 0, 0)";
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
       ctx.fillText(brickCum, 1215, 170);
       }
   }
   /////
    // 画像描画
    // @return {[type]} [description]
    ///
   function drawFrontImage(){
        ctx.drawImage(imgs[2],0,0,$('canvas')[0].width,$('canvas')[0].height);
        drawBall();
        drawPaddle();
   }
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
         eflag1 += 10;
         tyrano.plugin.kag.variable.tf.score = score;
         tyrano.plugin.kag.variable.tf.eflag1 = eflag1;
         for(var i = 0; i < 3 ; i ++ ){
           if(isDrawOuter[i].isDraw){
             //spclear1 = true;
             //spclear2 = true;
             spnclear1 = true;
             //spnclear2 = true;
           }
         }
         tyrano.plugin.kag.variable.sf.spclear1 = spclear1;
         //tyrano.plugin.kag.variable.sf.spclear2 = spclear2;
         tyrano.plugin.kag.variable.sf.spnclear1 = spnclear1;
         //tyrano.plugin.kag.variable.sf.spnclear2 = spnclear2;
         //spclear系がtrueならレーザーを壊してない
         clearInterval(interval);
       }
   }
   function ballStart(){
     lastx=x;
     lasty=y;
     x += dx;
     y += dy;
   }
   /////
    // ボール発射時の軌道
    // @return {[type]} [description]
    ///
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
   function systemGback(c , r){
     for(var i = 0; i<11; i++){
       for(var ii = 0 ; ii < 3 ; ii++){
         //alert("c:"+c + " r:"+r + " i:"+i + " ii:"+ii + "   a");
         if(!isBackGXX){
           if(!(r+i-3<0) && !(r+i-3 > brickRowCount-1)){
             var b = bricks[c+ii][r+i-3];
             b.status = 0;
           }
         }
         //alert("c:"+c + " r:"+r + " i:"+i + " ii:"+ii + "   b");
         if(i<5){
           if(!(r-ii<0) && c-i >= 0){
             var b = bricks[c-i][r-ii];
             b.status = 0;
           }
           if(!(r+ii+5>brickRowCount-1) && c-i >=0){
             var b = bricks[c-i][r+ii+5];
             b.status = 0;
           }
         }
       }
       //b.status = 0;
     }
   }
   function memori(){
     ctx.font = '6pt Arial';
     ctx.fillStyle = 'rgb(0, 255, 0)';
     for(var i = 100; i<1160;i+=20){
       for(var ii = 0; ii < 720 ; ii += 20)
         ctx.fillText(i/20-5, i+10, 18 +ii);
         //ctx.fillText(i/20-5, i+8, 720);
     }
     ctx.fillStyle = 'rgb(0, 0, 255)';
     for(var i = 0; i<720;i+=20){
       for(var ii = 0; ii<1060; ii += 20)
       ctx.fillText(i/20-1, 100 +ii, i-10);
       //ctx.fillText(i/20-1, 1140, i-10);
     }
   }
   function eliminateFN(){
     if(enatlation == 1){
       if(skillgageEliminate==0){
         enatlation = 0;
       }
       if(skillgageEliminate>0 && time%2 == 0){
       skillgageEliminate--;
       }
     }
     skillTimeEnalationOrigin++;
     //console.log(skillTimeEnalation + " " + skillTimeEnalationOrigin);
     if(skillTimeEnalation == skillTimeEnalationOrigin){
       //enatlation =0;
       isEnatlation = true;
     }
   }
   function wallDetection(){
     if(y + dy < ballRadius) {
       dy = -dy;
       if(dx ==0){
         dx = 3;
       }
     } else if(y + dy > $('canvas')[0].height - ballRadius) {
       dy = -dy;
     }

     if(x + dx  > $('canvas')[0].width-ballRadius-140) {
         dx = -dx;
     }else if(x + dx -100 < ballRadius){
       if(y > paddleY && y< paddleY + paddleHeight){
         dx = -dx;
         if( dx >10 ){
           dx = 5;
         }
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
       x = 110;
       y = paddleY+50;
       dx = -dx;
       elife1 --;
       }
     }
   }
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
   function stop(){
     ctx.beginPath();
     ctx.font = '24pt Arial';
     ctx.fillStyle = 'rgb(0, 0, 0)';
     ctx.fillText('PAUSE', $('canvas')[0].width/2-100,$('canvas')[0].height/2);
     ctx.font = '18pt Arial';
     ctx.fillText('back to press P key', $('canvas')[0].width/2-150,$('canvas')[0].height/2+30);
     ctx.fillStyle = 'rgba(0, 200, 200,0.005)';
     ctx.fillRect(0, 0, $('canvas')[0].width,$('canvas')[0].height);
     ctx.fill();
     ctx.closePath();
   }
   function stopLaser(){
     drawFrontImage();
     drawBricks();
     var timeasist = skillTime -time;
     ctx.beginPath();
     ctx.fillStyle = 'rgba(0, 0, 0,0.5)';
     ctx.fillRect(100, 0, 1050, 720);
     ctx.fill();
     ctx.closePath();
     if(isBrockHerf){
     if(timeasist > 50){
     for(var i = 0; i < isDrawOuter.length ; i++){
       if(isDrawOuter[i].isDraw){
         //レーザー削除処理
         //上
         if(isDrawOuter[i].num == 18){
           //描画
           ctx.drawImage(imgs[18] , isDrawOuter[i].x , isDrawOuter[i].y , 100 , 50);
           if(isDrawOuter[i].isAttr){
             //描画
             ctx.drawImage(imgs[19] , isDrawOuter[i].x , isDrawOuter[i].y , 100 , 50);
           }
         }
         //下
         if(isDrawOuter[i].num == 20){
           //描画
           ctx.drawImage(imgs[20] , isDrawOuter[i].x , isDrawOuter[i].y , 100 , 100);
           if(isDrawOuter[i].isAttr){
             //描画
             ctx.drawImage(imgs[21] , isDrawOuter[i].x , isDrawOuter[i].y , 100 , 100);
           }
         }
       }
     }
   }else{
     for(var i = 0; i < isDrawOuter.length ; i++){
       if(isDrawOuter[i].isDraw){
         //レーザー削除処理
         //上
         if(isDrawOuter[i].num == 18){
           //描画
           if(isDrawOuter[i].isAttr){
             //描画
             if(paddleY < 50){
               //isDrawOuter[i].isDraw = false;
               //爆破描画
               ctx.drawImage(imgs[7] , isDrawOuter[i].x , isDrawOuter[i].y , 100 , 50);
               if(timeasist == 5 ){
                 isDrawOuter[i].isDraw = false;
                 isLaserCount --;
               }
             }
           }else{
             ctx.drawImage(imgs[18] , isDrawOuter[i].x , isDrawOuter[i].y , 100 , 50);
           }
         }
         //下
         if(isDrawOuter[i].num == 20){
           //描画
           if(isDrawOuter[i].isAttr){
             //描画
             if(paddleY > 570 ){
               //isDrawOuter[i].isDraw = false;
               //爆破描画
               ctx.drawImage(imgs[7] , isDrawOuter[i].x , isDrawOuter[i].y , 100 , 100);
               if( timeasist == 5 ){
                 isDrawOuter[i].isDraw = false;
                 isLaserCount --;
               }
             }
           }
           else{
             ctx.drawImage(imgs[20] , isDrawOuter[i].x , isDrawOuter[i].y , 100 , 100);
           }
         }
       }
     }
   }
   }
     var paddleyyy = 25;
     if(timeasist>70){

     }else if(timeasist>60){
       ctx.drawImage(imgs[26],paddleX+100,paddleY+paddleyyy,$('canvas')[0].width-ballRadius-240, paddleHeight-50);
     }else if(timeasist>50){
       ctx.drawImage(imgs[27],paddleX+100,paddleY+paddleyyy,$('canvas')[0].width-ballRadius-240, paddleHeight-50);
     }else if(timeasist>40){
       ctx.drawImage(imgs[28],paddleX+100,paddleY+paddleyyy,$('canvas')[0].width-ballRadius-240, paddleHeight-50);
     }else if(timeasist>30){
       ctx.drawImage(imgs[27],paddleX+100,paddleY+paddleyyy,$('canvas')[0].width-ballRadius-240, paddleHeight-50);
     }else if(timeasist>20){
       ctx.drawImage(imgs[26],paddleX+100,paddleY+paddleyyy,$('canvas')[0].width-ballRadius-240, paddleHeight-50);
     }else{

     }
     if(skillTime == time){
       pause =false;
       skillTime = 0;
     }
     restart();
   }
   function stopGback(){
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
   function drawScore(){
     ctx.beginPath();
     ctx.font = '24pt Impact';
     ctx.fillStyle = 'rgb(255, 255, 255)';
     ctx.fillText(score, 1170,700);
     ctx.closePath();
     if(time%2==0){
       if(start != 0){
       score-=scoreDegTime;
       }
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
  ctx.fillStyle = 'rgba(0, 0, 255,0.5)';
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
  ctx.fillStyle = 'rgba(255, 0, 0,0.5)';
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
  ctx.fillStyle = 'rgba(255, 0, 0,0.5)';
  ctx.fillRect(1170, 575-skillgageGback, 90, 0 +skillgageGback);
  if(skillgageGback == 90 && !(time%20 == 0)){
    ctx.font = '12pt Impact';
    ctx.fillStyle = 'rgb(0, 0, 0)';
    ctx.fillText('press D', 1190,570);
  }
  ctx.fill();
  ctx.closePath();
}

   function draw() {
       //読み込み時不良時の処理
       try{
       //ポーズ画面(true時に画面を停止各要素を追加)
       if(pause) {
         pauseCases();
         return;
       }

       //貫通モード処理
       eliminateFN();

       //外的要因の移動
       if(isBrockHerf){
       if(time %frequence == 0 ){
       if(isLaserCount > 0 ){
         var bool = true;
         for(var i = 0 ; i < 3 ; i++){
           if(isDrawOuter[i].isAttr){
             bool = false;
           }
         }
         if(bool){
           isDrawOuter[0].isDraw = false;
           isDrawOuter[1].isDraw = false;
           isDrawOuter[2].isDraw = false;
           var num = Math.floor(Math.random() * Math.floor(2));//3か2か1にする
           isDrawOuter[num].isDraw = true;
           var sound = new Audio('data/sound/counts.ogg');
           sound.play();
         }
       }
       }

     }

       //発射後,ボールの位置を更新
       if(start ==1){
         ballStart();

         //@Add 外的要因の追加
         //外的要因の機能追加
         if(isBrockHerf){
         for(var i = 0; i < isDrawOuter.length ; i++){
           if(isDrawOuter[i].isDraw){
             //トップウ処理
             if(isDrawOuter[i].num == 11 || isDrawOuter[i].num == 22 ){
               //ボールがトップウ領域に入っていれば座標修正
               if(x >isDrawOuter[i].x -300 && y > isDrawOuter[i].y && y < isDrawOuter[i].y + 100 && enatlation != 1){
                 //if(dx > 0){
                   //dx = -dx;
                   dx -= 3;
                 //}
                 //dy = 0;
               }
               //ボールがfanに当たった時の判定
               if(x > isDrawOuter[i].x && y < isDrawOuter[i].y +100 && y > isDrawOuter[i].y && !isDrawOuter[i].isAttr){
                 isDrawOuter[i].num = 22;
                 isDrawOuter[i].isAttr = true;
                 isDrawOuter[i].life -= 1;
                 var sound = new Audio('data/sound/break.ogg');
                 sound.play();
                 if(isDrawOuter[i].life == 0){
                   var sound = new Audio('data/sound/bomb1.ogg');
                   sound.play();
                 }
               }
               //無敵時間
               if(isDrawOuter[i].isAttr && isDrawOuter[i].life > 0){
                 isDrawOuter[i].attrCount++;
                 if(isDrawOuter[i].attrCount == fanTime){
                   isDrawOuter[i].attrCount = 0;
                   isDrawOuter[i].isAttr = false;
                   isDrawOuter[i].num = 11;
                 }
               }
             }
             //レーザー削除処理
             //上
             if(isDrawOuter[i].num == 18 && isDrawOuter[i].isAttr){
               //ボールがビーム領域に入っていれば爆破
               if(x >isDrawOuter[i].x && x < isDrawOuter[i].x + 100 && y > isDrawOuter[i].y + 50 && enatlation != 1){
                 isBallBakuha[0].x = x;
                 isBallBakuha[0].y = y;
                 isBallBakuha[0].isBaku = true;
                 start = 0;
                 x = 110;
                 y = paddleY+50;
                 dx = -dx;
                 elife1 --;
               }
             }
             //下
             if(isDrawOuter[i].num == 20 && isDrawOuter[i].isAttr){
               //ボールがビーム領域に入っていれば爆破
               if(x >isDrawOuter[i].x && x < isDrawOuter[i].x + 100 && y < isDrawOuter[i].y - 50 && enatlation != 1){
                 isBallBakuha[0].x = x;
                 isBallBakuha[0].y = y;
                 isBallBakuha[0].isBaku = true;
                 start = 0;
                 x = 110;
                 y = paddleY+50;
                 dx = -dx;
                 elife1 --;
               }
             }
           }
         }
       }
       }
       //基盤画像描画
       drawFrontImage();

       //ブロック描画
       drawBricks();

       //@Add 外的要因の追加
       //三か所への画像追加
       if(isBrockHerf){
       for(var i = 0; i < isDrawOuter.length ; i++){
         if(isDrawOuter[i].isDraw){
           //トップウ処理
           if(isDrawOuter[i].num == 11 || isDrawOuter[i].num == 22){
             if(isDrawOuter[i].life > 0){
               ctx.drawImage(imgs[isDrawOuter[i].num + time%4] , isDrawOuter[i].x , isDrawOuter[i].y , 100 , 100);
               ctx.drawImage(imgs[15 + time%3] , isDrawOuter[i].x-300  ,  isDrawOuter[i].y , 300 , 100);
             }else{
               isDrawOuter[i].attrCount++;
               if(isDrawOuter[i].attrCount == fanTime){
                 isDrawOuter[i].isDraw = false;
               }else{
                 ctx.drawImage(imgs[7] , isDrawOuter[i].x , isDrawOuter[i].y , 100 , 100);
               }
             }
           }
           //レーザー削除処理
           if(isDrawOuter[i].num == 18){
             var imgs_num = isDrawOuter[i].num ;
             //レーザーの稼働時間調整
             if(time%200 == 0 || isDrawOuter[i].attrCount > 3){
               imgs_num +=1;
               isDrawOuter[i].attrCount ++;
               if(isDrawOuter[i].attrCount == 4 ){
                 isDrawOuter[i].isAttr = true;
                 var sound = new Audio('data/sound/laser1.ogg');
                 sound.play();
               }
               if(isDrawOuter[i].attrCount == lazerTime){
                 isDrawOuter[i].isAttr = false;
                 isDrawOuter[i].attrCount = 0;
               }
             }
             ctx.drawImage(imgs[imgs_num] , isDrawOuter[i].x , isDrawOuter[i].y , 100 , 50);
             if(isDrawOuter[i].isAttr){
               var num = 4;
               if(isDrawOuter[i].attrCount >10){
                 num++;
               }
               if(isDrawOuter[i].attrCount > 20){
                 num++;
               }
               ctx.save();
               ctx.translate(isDrawOuter[i].x,isDrawOuter[i].y);
               ctx.rotate(90 * Math.PI / 180);
               ctx.drawImage(imgs[num] , 50 , -80);
               ctx.restore();
               //ctx.drawImage(imgs[num] , isDrawOuter[i].x-300  ,  isDrawOuter[i].y , 300 , 100);
             }
           }
           //下
           if(isDrawOuter[i].num == 20){
             var imgs_num = isDrawOuter[i].num ;
             if(time%200 == 0 || isDrawOuter[i].attrCount > 3){
               imgs_num +=1;
               isDrawOuter[i].attrCount ++;
               if(isDrawOuter[i].attrCount == 4 ){
                 isDrawOuter[i].isAttr = true;
                 var sound = new Audio('data/sound/laser1.ogg');
                 sound.play();
               }
               if(isDrawOuter[i].attrCount == lazerTime){
                 isDrawOuter[i].isAttr = false;
                 isDrawOuter[i].attrCount = 0;
               }
             }
             ctx.drawImage(imgs[imgs_num] , isDrawOuter[i].x , isDrawOuter[i].y , 100 , 100);
             if(isDrawOuter[i].isAttr){
               var num = 4;
               if(isDrawOuter[i].attrCount >10){
                 num++;
               }
               if(isDrawOuter[i].attrCount > 20){
                 num++;
               }
               ctx.save();
               ctx.translate(isDrawOuter[i].x,isDrawOuter[i].y);
               ctx.rotate(270 * Math.PI / 180);
               ctx.drawImage(imgs[num] , 5 , 15);
               ctx.restore();
               //ctx.drawImage(imgs[num] , isDrawOuter[i].x-300  ,  isDrawOuter[i].y , 300 , 100);
             }
           }
         }
       }

       if(isBallBakuha[0].isBaku){
         if(isBallBakuha[0].time == 0){
           var sound = new Audio('data/sound/bomb1.ogg');
           sound.play();
         }
         ctx.drawImage(imgs[7] , isBallBakuha[0].x -50 ,  isBallBakuha[0].y - 50, 100 , 100);
         isBallBakuha[0].time ++;
         if(isBallBakuha[0].time == 100){
           isBallBakuha[0].time = 0;
           isBallBakuha[0].isBaku = false;
         }
       }
       }


       //スキルゲージ描画
       drawSkillGage();

       //衝突判定
       collisionDetection();

       //壁判定
       wallDetection();

       //key操作時のパドル変化
       keyMove();

       //時間とボール発射時の角度調整
       restart();

       //スコア描画
       drawScore();

       //目盛描画
       //memori();
       //緊急処置
       if(brockherf > brickCum){
         isBrockHerf = true;
       }
     }
     catch(e){
       //location.reload();//ここは戻すこと
           alert("すみません、読み込みに失敗しました。F5か更新ボタンを押して再起動してください。");
           alert(e);
       console.log(e);
       clearInterval(interval);
     }
   }
   var interval = setInterval(draw, 20);



[endscript]
;-------------------------------js終了

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



;---------------------------------負け処理
*elose1
@title name="ゲームオーバー"

;-----------------------------------------------------書き換え用
[bg  storage="ast1.png" time="10"  ]
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
;---------------------------------負け処理終了


[s]
;---------------------------------勝ち処理
*ewin1
@title name="ゲームクリア"
@eval exp="tf.eflag1=tf.eflag1==0"
;-----------------------------------------------------書き換え用
[bg  storage="ast4.png" time="10"  ]
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
@eval exp="sf.ak2stage1=true"
@eval exp="sf.ak2normal1=true"
@eval exp="sf.ak2hard1=true"
;@eval exp="sf.ak2vhard1=true"
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
*tweets
@wait time=300
;-----------------------------------------------------書き換え用
[tb_twitter_share tweet_str="&'『ステージ1』『難易度：HARD』のスコアは' + tf.score + 'です。貴方も挑戦してみませんか？'" url="https://chloe.animelife.info" hashtags="朱音の脱衣ブロック崩し"]
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

[jump  storage="akasurvay02.ks"  target=""  ]
[s]
;---------------------------------勝ち処理終了
