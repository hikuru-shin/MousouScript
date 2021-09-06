[bg  storage="kaede_rule1.png" time="300"  ]
[p]
[bg  storage="kaede_rule2.png" time="300"  ]
[p]
[bg  storage="loading.png" time="300"  ]









[layopt layer=0 visible=true]
[iscript]
$('.0_fore').prepend('<canvas id="canvas" style="position:absolute;"></canvas>');

//-----------------------------------------------------キャンバスの初期設定
$('canvas').attr('width', $('#tyrano_base').width());
$('canvas').attr('height', $('#tyrano_base').height());
var ctx = $('canvas')[0].getContext('2d');
var canvasWidth = $('canvas')[0].width;
var canvasHeight = $('canvas')[0].height;
//-----------------------------------------------------end

//-----------------------------------------------------ゲームシステム
//スキル変数(thiranoから変数を引き継ぐ)
var skill = 1;
var stage = 0;
var score  = 0;
var time = 0;
var firstreloadbool = false;
var gameOver_reason = "";
var destraction_check = false;
var syanahakawaii = false;
var mountenbgm = new Audio('data/bgm/runs.ogg');
var citybgm = new Audio('data/bgm/gew.ogg');
var seebgm = new Audio('data/bgm/sea.ogg');
var universebgm = new Audio('data/bgm/space.ogg');
var lastbgm = new Audio('data/bgm/last.ogg');
var bgm = [mountenbgm,citybgm,seebgm,universebgm,lastbgm];
var gameBoolReturn = true;
//-----------------------------------------------------カエデ設定
var kaedeWidth = 192;
var kaedeHeight = 96;
var kaedeX = 200;
var kaedeY = 400;
var kaedeMove_count = 0;
var kaedeTime = 5;
var kaede_atack_bool = false;
var kaede_jump_bool = false;
var kaede_top_limits = 200;
var kaede_gravity = 0.5;
var kaede_first_v = 5;
var kaede_jump_time = 1;
var kaede_atack_count = 0;
var kaede_atack_time = 4;
var kaede_destroy = false;
var kaede_destroy_case = 0;
var kaedeMove_destroyCount = 0;
var kaede_effectTime = 10;
var pit_time = 0;
var wave_width = 300;
var table_bool = false;
var warp_time = 1;
var vaice_frequency = 50;
var double_jump = false;
var jump_siteruyo = false;
//-----------------------------------------------------背景設定
var background_start_place = 0;
var background_velocity = 12;
var background_mounten_noon_velocity = 12;
var background_mounten_afternoon_velocity = 14;
var background_mounten_night_velocity = 16;
var background_city_velocity = 10;
var background_universe_velocity = 12;
var background_see_velocity = 12;
var background_last_velocity = 16;
var background_num = 0;
var background_num_change = false;
var background_change_place = 1280;
var background_changeScore = 0;
var background_change_stage = 0;
var before_stage = 0;
//背景変更スコア
var mounten_morning_score = 5000;
var mounten_noon_score = 10000;
var mounten_night_score = 22000;
var city_score = 10000;
var see_score = 30000;
var universe_score = 30000;
var last_score = 160000;
//-----------------------------------------------------テキスト
var start_up = "Ready";
var start_down = "Press Enter or Click";
var score_text = "スコア:";
//-----------------------------------------------------END

//初期化
function init(){
  for(var i = 0; i < vaice_org.length; i++){
   vaice_org[i].bool = false;
   vaice_org[i].destroy = false;
   vaice_org[i].x = 1280;
  }
  score = 0;
  time = 0;
  kaedeX = 200;
  kaedeY = 400;
  background_start_place = 0;
  background_velocity = 12;
  background_num = 0;
  background_num_change = false;
  background_change_place = 1280;
  background_changeScore = 0;
  kaedeMove_count = 0;
  kaedeTime = 5;
  kaede_atack_bool = false;
  kaede_jump_bool = false;
  kaede_top_limits = 200;
  kaede_gravity = 0.5;
  kaede_first_v = 5;
  kaede_jump_time = 1;
  kaede_atack_count = 0;
  kaede_atack_time = 4;
  kaede_destroy = false;
  kaede_destroy_case = 0;
  kaedeMove_destroyCount = 0;
  kaede_effectTime = 10;
  pit_time = 0;
  stage = 0;
  gameOver_reason = "";
  background_change_stage = 0;
  vaice_frequency = 50;
  table_bool = false;
  for(var i = 0; i < bgm.length; i++){
    bgm[i].currentTime = 0;
  }
}
//--------------------------------------------------------key＆mouseAction

document.addEventListener("keydown", keyDownHandler, false); //key押下時
document.addEventListener("keyup", keyUpHandler, false); //key押下時
document.addEventListener("mousemove", mouseMoveHandler, false); //マウス操作
document.addEventListener("click", mouseClickHandler, false); //マウスクリック

for(var i = 0; i < bgm.length; i++){
  bgm[i].addEventListener("ended", function () {
  bgm[i].currentTime = 0;
  bgm[i].play();
}, false);
}

function keyDownHandler(e) {
  //console.log(e.keyCode);
  if(gameBoolReturn){
  if(stage == 0 && firstreloadbool && e.keyCode == 13){
    bgm[0].play();
    bgm[0].volume=0.3;
    bgm[0].loop=true;
    stage = 1;
  }
  if(stage == 2){
  	//クリア時にティラノ側で得る変数を記載
   	tyrano.plugin.kag.variable.tf.score = score;
   	//ここにスコアが5k,40k,90k,160k,180k,200k以上の時に変数取得を記載
     if(score>5000){
     tyrano.plugin.kag.variable.sf.scoreget1 = true;
     }
     if(score>40000){
     tyrano.plugin.kag.variable.sf.scoreget2 = true;
     }
     if(score>90000){
     tyrano.plugin.kag.variable.sf.scoreget3 = true;
     }
     if(score>160000){
     tyrano.plugin.kag.variable.sf.scoreget4 = true;
     }
     if(score>180000){
     tyrano.plugin.kag.variable.sf.scoreget5 = true;
     }
     if(score>200000){
     tyrano.plugin.kag.variable.sf.scoreget6 = true;
     }
     if(e.keyCode == 13){
      switch(detective){
        case 0 :
        TYRANO.kag.ftag.startTag("jump",{target:"*tweets"});
        break;
        case 1 :
        init();
        break;
        case 2 :
        gameBoolReturn = false;
        TYRANO.kag.ftag.startTag("jump",{target:"*backtitle"});
        break;
      }
     }
     else if(e.keyCode == 37){
     	if(detective != 0){
     		detective--;
     	}
     }
     else if(e.keyCode == 39){
     	if(detective != 2){
     		detective++;
     	}
     }
  }
  if(gameBoolReturn && !jump_siteruyo){
  if(e.keyCode == 32 ){
    if(!kaede_destroy){
      if(!kaede_jump_bool){
      var sound = new Audio('data/sound/jump.ogg');
      sound.play();
      }
      kaede_jump_bool = true;
      if(table_bool == true && double_jump){
        kaede_jump_time = 1;
        double_jump = false;
      }
      jump_siteruyo = true;
    }
  }
  }
  }
}

function keyUpHandler(e) {
  if(gameBoolReturn){
  if(e.keyCode == 32 ){
    if(!kaede_destroy){
      jump_siteruyo = false;
    }
  }
  }
}

function mouseMoveHandler(e) {
}

function mouseClickHandler(e){
  if(gameBoolReturn){
  if(stage == 0 && firstreloadbool){
    bgm[0].play();
    bgm[0].volume=0.3;
    bgm[0].loop=true;
    stage = 1;
  }else if(stage == 1){
   stage = 3 ;
  }else if(stage == 2){

  }else if(stage == 3){
   stage = 1;
  }
  }
}
//--------------------------------------------------------key＆mouseAction:end

//--------------------------------------------------------画像をプリロード

//背景画像保存場所
var bgimage_url= [
  "data/bgimage/run1.png",
  "data/bgimage/run2.png",
  "data/bgimage/run3.png",
  "data/bgimage/run4.png",
  "data/bgimage/run5.png",
  "data/bgimage/run6.png",
  "data/bgimage/run7.png",
  "data/fgimage/kaede/kaedetaiki.png",
];
//背景画像リスト(呼び出し用)
var bgimgs = new Array(bgimage_url.length);
for(var i =0 ;i < bgimgs.length;i++){
  bgimgs[i] = new Image();
  bgimgs[i].src = bgimage_url[i];
  prelord(bgimgs , bgimage_url , i);
}
bgimgs[0].addEventListener("load", firstreload, false);
function firstreload(){
  firstreloadbool = true;
}

//カエデ移動画像保存場所
var kaedeMove_url = [
  "data/fgimage/kaede/kaedeidou1_1.png",
  "data/fgimage/kaede/kaedeidou1_2.png",
  "data/fgimage/kaede/kaedeidou1_3.png",
  "data/fgimage/kaede/kaedeidou1_4.png",
  "data/fgimage/kaede/kaedeidou1_5.png",
  "data/fgimage/kaede/kaedeidou1_6.png",
];
//移動画像リスト(呼び出し用)
var moves = new Array(kaedeMove_url.length);
for(var i =0 ;i < moves.length;i++){
  moves[i] = new Image();
  moves[i].src = kaedeMove_url[i];
  moves[i].padding = false;
  prelord(moves , kaedeMove_url , i);
}

//カエデ攻撃画像保存場所
var kaedeAtack_url = [
  "data/fgimage/kaede/kaedekougeki1_1.png",
  "data/fgimage/kaede/kaedekougeki1_2.png",
  "data/fgimage/kaede/kaedekougeki1_3.png",
  "data/fgimage/kaede/kaedekougeki1_4.png",
  "data/fgimage/kaede/kaedekougeki1_5.png",
  "data/fgimage/kaede/kaedekougeki1_6.png",
  "data/fgimage/kaede/kaedekougeki1_7.png",
];
//攻撃画像リスト(呼び出し用)
var atacks = new Array(kaedeAtack_url.length);
for(var i =0 ;i < atacks.length;i++){
  atacks[i] = new Image();
  atacks[i].src = kaedeAtack_url[i];
  atacks[i].padding = false;
  prelord(atacks , kaedeAtack_url , i);
}

//カエデ攻撃エフェクト画像保存場所
var kaedeAtackEffect_url = [
  "data/fgimage/kaede/effect/slash1.png",
  "data/fgimage/kaede/effect/slash2.png",
  "data/fgimage/kaede/effect/slash3.png",
  "data/fgimage/kaede/effect/slash4.png",
  "data/fgimage/kaede/effect/slash5.png",
];
//カエデエフェクト(呼び出し用)
var effects = new Array(kaedeAtackEffect_url.length);
for(var i =0 ;i < effects.length;i++){
  effects[i] = new Image();
  effects[i].src = kaedeAtackEffect_url[i];
  effects[i].padding = false;
  prelord(effects , kaedeAtackEffect_url , i);
}

//エフェクト画像保存場所
var fEffect_url = [
  "data/fgimage/kaede/effect/bomb.png",
  "data/fgimage/kaede/effect/fallout.png",
  "data/fgimage/bg_gameover.png",
  "data/fgimage/button_return.png",
  "data/fgimage/button_title.png",
  "data/fgimage/button_tweet.png",
  "data/fgimage/kaede/effect/jump_ramp.png",
  "data/fgimage/bluescreen.png",
];
//カードエフェクト(呼び出し用)
var feffects = new Array(fEffect_url.length);
for(var i =0 ;i < feffects.length;i++){
  feffects[i] = new Image();
  feffects[i].src = fEffect_url[i];
  feffects[i].padding = false;
  prelord(feffects , fEffect_url , i);
}

//敵画像保存場所
var pit_url = [
  "data/fgimage/kaede/effect/pit.png",
];
//敵画像リスト(呼び出し用)
var pit = new Array(pit_url.length);
for(var i =0 ;i < pit.length;i++){
  pit[i] = new Image();
  pit[i].src = pit_url[i];
  pit[i].padding = false;
  prelord(pit , pit_url , i);
}
//敵画像保存場所
var warp_url = [
  "data/fgimage/kaede/effect/warphole.png",
];
//敵画像リスト(呼び出し用)
var warp = new Array(warp_url.length);
for(var i =0 ;i < warp.length;i++){
  warp[i] = new Image();
  warp[i].src = warp_url[i];
  warp[i].padding = false;
  prelord(warp , warp_url , i);
}
//敵画像保存場所
var wave_url = [
  "data/fgimage/kaede/effect/wave.png",
];
//敵画像リスト(呼び出し用)
var wave = new Array(wave_url.length);
for(var i =0 ;i < wave.length;i++){
  wave[i] = new Image();
  wave[i].src = wave_url[i];
  wave[i].padding = false;
  prelord(wave , wave_url , i);
}
var ca_url = [
  "data/fgimage/vaice/ca1.png",
  "data/fgimage/vaice/ca2.png",
  "data/fgimage/vaice/ca3.png",
  "data/fgimage/vaice/ca4.png",
  "data/fgimage/vaice/ca5.png",
  "data/fgimage/vaice/ca6.png",
  "data/fgimage/vaice/ca7.png",
];
//敵画像リスト(呼び出し用)
var ca = new Array(ca_url.length);
for(var i =0 ;i < ca.length;i++){
  ca[i] = new Image();
  ca[i].src = ca_url[i];
  ca[i].padding = false;
  prelord(ca , ca_url , i);
}
var ban_url = [
  "data/fgimage/vaice/ban1.png",
  "data/fgimage/vaice/ban2.png",
  "data/fgimage/vaice/ban3.png",
  "data/fgimage/vaice/ban4.png",
  "data/fgimage/vaice/ban5.png",
  "data/fgimage/vaice/ban6.png",
  "data/fgimage/vaice/ban7.png",
];
//敵画像リスト(呼び出し用)
var ban = new Array(ban_url.length);
for(var i =0 ;i < ban.length;i++){
  ban[i] = new Image();
  ban[i].src = ban_url[i];
  ban[i].padding = false;
  prelord(ban , ban_url , i);
}
var ce_url = [
  "data/fgimage/vaice/ce1.png",
  "data/fgimage/vaice/ce2.png",
  "data/fgimage/vaice/ce3.png",
  "data/fgimage/vaice/ce4.png",
  "data/fgimage/vaice/ce5.png",
  "data/fgimage/vaice/ce6.png",
  "data/fgimage/vaice/ce7.png",
];
//敵画像リスト(呼び出し用)
var ce = new Array(ce_url.length);
for(var i =0 ;i < ce.length;i++){
  ce[i] = new Image();
  ce[i].src = ce_url[i];
  ce[i].padding = false;
  prelord(ce , ce_url , i);
}
var falcon_url = [
  "data/fgimage/vaice/falcon1.png",
  "data/fgimage/vaice/falcon2.png",
  "data/fgimage/vaice/falcon3.png",
  "data/fgimage/vaice/falcon4.png",
  "data/fgimage/vaice/falcon5.png",
  "data/fgimage/vaice/falcon6.png",
  "data/fgimage/vaice/falcon7.png",
];
//敵画像リスト(呼び出し用)
var falcon = new Array(falcon_url.length);
for(var i =0 ;i < falcon.length;i++){
  falcon[i] = new Image();
  falcon[i].src = falcon_url[i];
  falcon[i].padding = false;
  prelord(falcon , falcon_url , i);
}
var fu_url = [
  "data/fgimage/vaice/fu1.png",
  "data/fgimage/vaice/fu2.png",
  "data/fgimage/vaice/fu3.png",
  "data/fgimage/vaice/fu4.png",
  "data/fgimage/vaice/fu5.png",
  "data/fgimage/vaice/fu6.png",
  "data/fgimage/vaice/fu7.png",
];
//敵画像リスト(呼び出し用)
var fu = new Array(fu_url.length);
for(var i =0 ;i < fu.length;i++){
  fu[i] = new Image();
  fu[i].src = fu_url[i];
  fu[i].padding = false;
  prelord(fu , fu_url , i);
}
var ke_url = [
  "data/fgimage/vaice/ke1.png",
  "data/fgimage/vaice/ke2.png",
  "data/fgimage/vaice/ke3.png",
  "data/fgimage/vaice/ke4.png",
  "data/fgimage/vaice/ke5.png",
  "data/fgimage/vaice/ke6.png",
  "data/fgimage/vaice/ke7.png",
];
//敵画像リスト(呼び出し用)
var ke = new Array(ke_url.length);
for(var i =0 ;i < ke.length;i++){
  ke[i] = new Image();
  ke[i].src = ke_url[i];
  ke[i].padding = false;
  prelord(ke , ke_url , i);
}
var li1_url = [
  "data/fgimage/vaice/li1_1.png",
  "data/fgimage/vaice/li1_2.png",
  "data/fgimage/vaice/li1_3.png",
  "data/fgimage/vaice/li1_4.png",
  "data/fgimage/vaice/li1_5.png",
  "data/fgimage/vaice/li1_6.png",
  "data/fgimage/vaice/li1_7.png",
];
//敵画像リスト(呼び出し用)
var li1 = new Array(li1_url.length);
for(var i =0 ;i < li1.length;i++){
  li1[i] = new Image();
  li1[i].src = li1_url[i];
  li1[i].padding = false;
  prelord(li1 , li1_url , i);
}
var li2_url = [
  "data/fgimage/vaice/li2_1.png",
  "data/fgimage/vaice/li2_2.png",
  "data/fgimage/vaice/li2_3.png",
  "data/fgimage/vaice/li2_4.png",
  "data/fgimage/vaice/li2_5.png",
  "data/fgimage/vaice/li2_6.png",
  "data/fgimage/vaice/li2_7.png",
];
//敵画像リスト(呼び出し用)
var li2 = new Array(li2_url.length);
for(var i =0 ;i < li2.length;i++){
  li2[i] = new Image();
  li2[i].src = li2_url[i];
  li2[i].padding = false;
  prelord(li2 , li2_url , i);
}
var li3_url = [
  "data/fgimage/vaice/li3_1.png",
  "data/fgimage/vaice/li3_2.png",
  "data/fgimage/vaice/li3_3.png",
  "data/fgimage/vaice/li3_4.png",
  "data/fgimage/vaice/li3_5.png",
  "data/fgimage/vaice/li3_6.png",
  "data/fgimage/vaice/li3_7.png",
];
//敵画像リスト(呼び出し用)
var li3 = new Array(li3_url.length);
for(var i =0 ;i < li3.length;i++){
  li3[i] = new Image();
  li3[i].src = li3_url[i];
  li3[i].padding = false;
  prelord(li3 , li3_url , i);
}
var ne_url = [
  "data/fgimage/vaice/ne1.png",
  "data/fgimage/vaice/ne2.png",
  "data/fgimage/vaice/ne3.png",
  "data/fgimage/vaice/ne4.png",
  "data/fgimage/vaice/ne5.png",
  "data/fgimage/vaice/ne6.png",
  "data/fgimage/vaice/ne7.png",
];
//敵画像リスト(呼び出し用)
var ne = new Array(ne_url.length);
for(var i =0 ;i < ne.length;i++){
  ne[i] = new Image();
  ne[i].src = ne_url[i];
  ne[i].padding = false;
  prelord(ne , ne_url , i);
}
var ne_url = [
  "data/fgimage/vaice/ne1.png",
  "data/fgimage/vaice/ne2.png",
  "data/fgimage/vaice/ne3.png",
  "data/fgimage/vaice/ne4.png",
  "data/fgimage/vaice/ne5.png",
  "data/fgimage/vaice/ne6.png",
  "data/fgimage/vaice/ne7.png",
];
//敵画像リスト(呼び出し用)
var ne = new Array(ne_url.length);
for(var i =0 ;i < ne.length;i++){
  ne[i] = new Image();
  ne[i].src = ne_url[i];
  ne[i].padding = false;
  prelord(ne , ne_url , i);
}
var ob_url = [
  "data/fgimage/vaice/ob1.png",
  "data/fgimage/vaice/ob2.png",
  "data/fgimage/vaice/ob3.png",
  "data/fgimage/vaice/ob4.png",
  "data/fgimage/vaice/ob5.png",
  "data/fgimage/vaice/ob6.png",
  "data/fgimage/vaice/ob7.png",
];
//敵画像リスト(呼び出し用)
var ob = new Array(ob_url.length);
for(var i =0 ;i < ob.length;i++){
  ob[i] = new Image();
  ob[i].src = ob_url[i];
  ob[i].padding = false;
  prelord(ob , ob_url , i);
}
var po_url = [
  "data/fgimage/vaice/po1.png",
  "data/fgimage/vaice/po2.png",
  "data/fgimage/vaice/po3.png",
  "data/fgimage/vaice/po4.png",
  "data/fgimage/vaice/po5.png",
  "data/fgimage/vaice/po6.png",
  "data/fgimage/vaice/po7.png",
];
//敵画像リスト(呼び出し用)
var po = new Array(po_url.length);
for(var i =0 ;i < po.length;i++){
  po[i] = new Image();
  po[i].src = po_url[i];
  po[i].padding = false;
  prelord(po , po_url , i);
}
var qu_url = [
  "data/fgimage/vaice/Qu1.png",
  "data/fgimage/vaice/Qu2.png",
  "data/fgimage/vaice/Qu3.png",
  "data/fgimage/vaice/Qu4.png",
  "data/fgimage/vaice/Qu5.png",
  "data/fgimage/vaice/Qu6.png",
  "data/fgimage/vaice/Qu7.png",
];
//敵画像リスト(呼び出し用)
var qu = new Array(qu_url.length);
for(var i =0 ;i < qu.length;i++){
  qu[i] = new Image();
  qu[i].src = qu_url[i];
  qu[i].padding = false;
  prelord(qu , qu_url , i);
}
var rentora_url = [
  "data/fgimage/vaice/rentora1.png",
  "data/fgimage/vaice/rentora2.png",
  "data/fgimage/vaice/rentora3.png",
  "data/fgimage/vaice/rentora4.png",
  "data/fgimage/vaice/rentora5.png",
  "data/fgimage/vaice/rentora6.png",
  "data/fgimage/vaice/rentora7.png",
];
//敵画像リスト(呼び出し用)
var rentora = new Array(rentora_url.length);
for(var i =0 ;i < rentora.length;i++){
  rentora[i] = new Image();
  rentora[i].src = rentora_url[i];
  rentora[i].padding = false;
  prelord(rentora , rentora_url , i);
}
var ri_url = [
  "data/fgimage/vaice/ri1.png",
  "data/fgimage/vaice/ri2.png",
  "data/fgimage/vaice/ri3.png",
  "data/fgimage/vaice/ri4.png",
  "data/fgimage/vaice/ri5.png",
  "data/fgimage/vaice/ri6.png",
  "data/fgimage/vaice/ri7.png",
];
//敵画像リスト(呼び出し用)
var ri = new Array(ri_url.length);
for(var i =0 ;i < ri.length;i++){
  ri[i] = new Image();
  ri[i].src = ri_url[i];
  ri[i].padding = false;
  prelord(ri , ri_url , i);
}
var sa_url = [
  "data/fgimage/vaice/sa1.png",
  "data/fgimage/vaice/sa2.png",
  "data/fgimage/vaice/sa3.png",
  "data/fgimage/vaice/sa4.png",
  "data/fgimage/vaice/sa5.png",
  "data/fgimage/vaice/sa6.png",
  "data/fgimage/vaice/sa7.png",
];
//敵画像リスト(呼び出し用)
var sa = new Array(sa_url.length);
for(var i =0 ;i < sa.length;i++){
  sa[i] = new Image();
  sa[i].src = sa_url[i];
  sa[i].padding = false;
  prelord(sa , sa_url , i);
}
var se_url = [
  "data/fgimage/vaice/se1.png",
  "data/fgimage/vaice/se2.png",
  "data/fgimage/vaice/se3.png",
  "data/fgimage/vaice/se4.png",
  "data/fgimage/vaice/se5.png",
  "data/fgimage/vaice/se6.png",
  "data/fgimage/vaice/se7.png",
];
//敵画像リスト(呼び出し用)
var se = new Array(se_url.length);
for(var i =0 ;i < se.length;i++){
  se[i] = new Image();
  se[i].src = se_url[i];
  se[i].padding = false;
  prelord(se , se_url , i);
}
var vw_url = [
  "data/fgimage/vaice/vw1.png",
  "data/fgimage/vaice/vw2.png",
  "data/fgimage/vaice/vw3.png",
  "data/fgimage/vaice/vw4.png",
  "data/fgimage/vaice/vw5.png",
  "data/fgimage/vaice/vw6.png",
  "data/fgimage/vaice/vw7.png",
];
//敵画像リスト(呼び出し用)
var vw = new Array(vw_url.length);
for(var i =0 ;i < vw.length;i++){
  vw[i] = new Image();
  vw[i].src = vw_url[i];
  vw[i].padding = false;
  prelord(vw , vw_url , i);
}
var we_url = [
  "data/fgimage/vaice/we1.png",
  "data/fgimage/vaice/we2.png",
  "data/fgimage/vaice/we3.png",
  "data/fgimage/vaice/we4.png",
  "data/fgimage/vaice/we5.png",
  "data/fgimage/vaice/we6.png",
  "data/fgimage/vaice/we7.png",
];
//敵画像リスト(呼び出し用)
var we = new Array(we_url.length);
for(var i =0 ;i < we.length;i++){
  we[i] = new Image();
  we[i].src = we_url[i];
  we[i].padding = false;
  prelord(we , we_url , i);
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
//-----------------------------------------------------敵設定
var vaice_org = [
  {name : ca , move_count: 0 , x :1280  , y : 400 , bool :true , destroy : false},
  {name : ca , move_count: 0 , x :1280  , y : 400 , bool :false, destroy : false},
  {name : ca , move_count: 0 , x :1280  , y : 400 , bool :false, destroy : false},
  {name : ca , move_count: 0 , x :1280  , y : 400 , bool :false, destroy : false},
  {name : ca , move_count: 0 , x :1280  , y : 400 , bool :false, destroy : false},
  {name : ca , move_count: 0 , x :1280  , y : 400 , bool :false, destroy : false},
  {name : ca , move_count: 0 , x :1280  , y : 400 , bool :false, destroy : false},
  {name : ca , move_count: 0 , x :1280  , y : 400 , bool :false, destroy : false},
  {name : ca , move_count: 0 , x :1280  , y : 400 , bool :false, destroy : false},
];
var vaice_width = 96;
var vaice_height = 96;
var pit_width = 96;
var pit_height = 24;

var vaice_List = [
  {name : pit , position : 0 , velocity : 4 , score : 0},
  {name : ban , position : 0 , velocity : 9, score : 2000},
  {name : ca , position : 0 , velocity : 6.5, score : 2000},
  {name : ce , position : 2 , velocity : 11, score : 5000},
  {name : falcon , position : 1 , velocity : 12, score : 5000},
  {name : fu , position : 2 , velocity : 11, score : 2000},
  {name : ke , position : 0 , velocity : 8, score : 2000},
  {name : li1 , position : 0 , velocity : 4, score : 0},
  {name : li2 , position : 0 , velocity : 4, score : 0},
  {name : li3 , position : 0 , velocity : 4, score : 0},
  {name : ne , position : 0 , velocity : 6, score : 7000},
  {name : ob , position : 0 , velocity : 6, score : 7000},
  {name : po , position : 1 , velocity : 7.5, score : 500},
  {name : qu , position : 2 , velocity : 10, score : 10000},
  {name : rentora , position : 1 , velocity : 6.5, score : 500},
  {name : ri , position : 0 , velocity : 8, score : 5000},
  {name : sa , position : 1 , velocity : 7, score : 500},
  {name : se , position : 0 , velocity : 8, score : 500},
  {name : vw , position : 0 , velocity : 7, score : 2000},
  {name : we , position : 0 , velocity : 10, score : 5000},
  {name : warp , position : 0 , velocity : 4, score : 0},
  {name : wave , position : 0 , velocity : 6, score : 0},
  {name : feffects[6] , position : 0 , velocity : 5, score : 0},
];

//昼敵
var vaice_List_noon = [
  {name : pit , position : 0 , velocity : 4},
  {name : li1 , position : 0 , velocity : 4},
  {name : po , position : 1 , velocity : 5},
  {name : rentora , position : 1 , velocity : 5},
  {name : sa , position : 1 , velocity : 4},
  {name : se , position : 0 , velocity : 5},
  {name : vw , position : 0 , velocity : 6},
];
//夕方敵
var vaice_List_afternoon = [
  {name : pit , position : 0 , velocity : 4},
  {name : ban , position : 0 , velocity : 7},
  {name : ca , position : 0 , velocity : 5},
  {name : falcon , position : 1 , velocity : 10},
  {name : fu , position : 2 , velocity : 8},
  {name : ke , position : 0 , velocity : 5},
  {name : li2 , position : 0 , velocity : 4},
];
//夜敵
var vaice_List_night = [
  {name : pit , position : 0 , velocity : 4},
  {name : ce , position : 2 , velocity : 11},
  {name : li3 , position : 0 , velocity : 4},
  {name : qu , position : 2 , velocity : 10},
  {name : ri , position : 0 , velocity : 8},
  {name : we , position : 0 , velocity : 10},
];

var vaice_velocity = 4;
//-------------------------------------------------------

//--------------------------------------------------------画像描画

function placeImage(array , num , x , y ,width , height){
  ctx.drawImage(array[num],canvasWidth/x,canvasHeight/y,width,height);
}

function drawBGImage(i_start){
  for(var i = 0; i <  canvasWidth ; i++ , i_start++){
    var ii_start = i_start;
    if(ii_start > 2560){
      ii_start -=2560;
    }
    if(background_num_change){
      var sub_num = background_num;
      if(i < background_change_place){
        sub_num = before_stage;
      }
      ctx.drawImage(bgimgs[sub_num],ii_start,0,1,720,i,0,1,720);
    }else{
      ctx.drawImage(bgimgs[background_num],ii_start,0,1,720,i,0,1,720);
    }
  }
}

function drawVaices(){
  for(var i = 0 ; i < vaice_org.length; i++){
    if(vaice_org[i].bool){
     if(vaice_org[i].name == pit || vaice_org[i].name == wave || vaice_org[i].name == warp ){
      if(vaice_org[i].name == wave){
        ctx.drawImage(vaice_org[i].name[0],vaice_org[i].x,vaice_org[i].y,wave_width,vaice_height);
        ctx.drawImage(feffects[6] , vaice_org[i].x , vaice_org[i].y -15 , wave_width , 10);
        if( (vaice_org[i].x < kaedeX && vaice_org[i].x + wave_width > kaedeX ) || (vaice_org[i].x < kaedeX + kaedeWidth/2 && vaice_org[i].x + wave_width > kaedeX + kaedeWidth/2)){
          table_bool = true;
        }else{
          //table_bool = false;
          double_jump = false;
        }
      }else{
        ctx.drawImage(vaice_org[i].name[0],vaice_org[i].x,vaice_org[i].y + 74,pit_width,pit_height);
      }
     }else if(vaice_org[i].name == feffects[6]){
      ctx.drawImage(feffects[6] , vaice_org[i].x , vaice_org[i].y -15 , wave_width , 10);
      if( (vaice_org[i].x < kaedeX && vaice_org[i].x + wave_width > kaedeX ) || (vaice_org[i].x < kaedeX + kaedeWidth/2 && vaice_org[i].x + wave_width > kaedeX + kaedeWidth/2)){
        table_bool = true;
      }else{
        //table_bool = false;
        double_jump = false;
      }
     }else{
      ctx.drawImage(vaice_org[i].name[vaice_org[i].move_count],vaice_org[i].x,vaice_org[i].y,vaice_width,vaice_height);
      if(vaice_org[i].destroy){
        ctx.drawImage(feffects[0] , vaice_org[i].x , vaice_org[i].y , vaice_width , vaice_height);
      }
     }
    }
  }
}

function drawText(x , y , fontsize , style , text){
  ctx.font = fontsize + 'pt Arial';
  ctx.fillStyle = style;
  ctx.fillText(start_up , canvasWidth/x, canvasHeight/y);
  ctx.fillText(start_down , canvasWidth/x, canvasHeight/y);
}

//--------------------------------------------------------画像描画:end
//--------------------------------------------------------
//-----------スタート画面
function start(){
  ctx.drawImage(bgimgs[0],0,0,canvasWidth*2,canvasHeight);
  ctx.drawImage(bgimgs[7],kaedeX,kaedeY,kaedeWidth,kaedeHeight);
  ctx.font = 24 + 'pt Arial';
  ctx.fillText(start_up , 600,450);
  ctx.font = 14 + 'pt Arial';
  ctx.fillText(start_down , 570, 480);
  scoreDraw();
}
//------------
//------------ゲーム画面
function game(){
  //画面描画
  drawBGImage(background_start_place);
  drawVaices();

  //カエデ描画
  if(kaede_atack_bool){
    ctx.drawImage(atacks[kaede_atack_count],kaedeX,kaedeY,kaedeWidth,kaedeHeight);
  }else{
    if(kaede_jump_bool && !table_bool){
      ctx.drawImage(moves[0],kaedeX,kaedeY,kaedeWidth,kaedeHeight);
    }else{
      if(kaede_destroy){
         switch(kaede_destroy_case){
           case 0 :
           if(pit_time > 110){
             ctx.drawImage(feffects[1] , kaedeX,kaedeY,kaedeWidth/2,kaedeHeight);
             stage = 2;
             var sound = new Audio('data/sound/gameover.ogg');
             sound.play();
             sound.volume=0.3;
           }else{
             ctx.drawImage(moves[kaedeMove_count],kaedeX,kaedeY,kaedeWidth,kaedeHeight);
           }
           background_velocity = 0;
           pit_time++;
           if(pit_time < 100){
             kaedeMove_count =0;
           }else if(pit_time == 100){
             kaedeTime -= 3;
           }
           break;
           case 1 :
           background_velocity = 0;
           ctx.drawImage(moves[kaedeMove_count],kaedeX,kaedeY,kaedeWidth,kaedeHeight);
           ctx.drawImage(effects[kaedeMove_destroyCount],kaedeX , kaedeY , kaedeWidth/2 , kaedeHeight);
           if(time%kaede_effectTime == 0){
              kaedeMove_destroyCount++;
              if(kaedeMove_destroyCount == 2){
              var sound = new Audio('data/sound/counter.ogg');
              sound.play();
              }
           }
           if(kaedeMove_destroyCount == 5){
              kaedeMove_destroyCount = 0;
              ctx.drawImage(feffects[0] , kaedeX , kaedeY , kaedeWidth/2 , kaedeHeight);
              stage = 2;
              var sound = new Audio('data/sound/gameover.ogg');
              sound.play();
              sound.volume=0.3;
           }
           break;
           case 2 :
           kaedeX -= background_velocity *2;
           ctx.drawImage(moves[kaedeMove_count],kaedeX,kaedeY,kaedeWidth,kaedeHeight);
           if(kaedeX + kaedeWidth < 0){
            stage = 2;
            var sound = new Audio('data/sound/gameover.ogg');
            sound.play();
            sound.volume=0.3;
           }
           break;
           case 3 :
           kaedeY += kaede_gravity*warp_time/2;
           ctx.drawImage(moves[kaedeMove_count],kaedeX,kaedeY,kaedeWidth,kaedeHeight);
           warp_time++;
           if(kaedeY > 400){
            kaede_destroy = false;
            kaede_destroy_case = 0;
            warp_time = 1;
            kaedeY = 400;
           }
           break;
         }
      }else{
       ctx.drawImage(moves[kaedeMove_count],kaedeX,kaedeY,kaedeWidth,kaedeHeight);
      }
    }
  }
  //カエデアタック描画
  if(time%kaede_atack_time == 0){
    kaede_atack_count++;
    if(kaede_atack_count == atacks.length){
      kaede_atack_count = 0;
      kaede_atack_bool = false;
    }
  }

  scoreDraw();
  //カエデ行動速度
  if(time%kaedeTime == 0){
    kaedeMove_count++;
    score+=10;
    background_changeScore += 10;
    for(var i = 0 ; i < vaice_org.length ; i++){
      if(vaice_org[i].bool){
        vaice_org[i].move_count++;
        if(vaice_org[i].move_count == 7){
          vaice_org[i].move_count = 0;
        }
      }
    }
  }
  //敵行動速度
  for(var i = 0 ; i < vaice_org.length ; i++){
    if(vaice_org[i].bool){
      if(vaice_org[i].name == pit){
        vaice_org[i].x -= background_velocity;
      }else if(vaice_org[i].name == li1 || vaice_org[i].name == li2 || vaice_org[i].name == li3){
        vaice_org[i].x -= background_velocity;
      }else{
        var velocity = 0;
        for(var ii = 0 ; ii < vaice_List.length ; ii++){
          if(vaice_List[ii].name == vaice_org[i].name){
            velocity = vaice_List[ii].velocity ;
          }
        }
        vaice_org[i].x -= velocity*2;
      }
    }
  }
  if(kaedeMove_count == moves.length){
    kaedeMove_count = 0;
  }
  //カエデジャンプ挙動
  if(kaede_jump_bool){
    var gravity_num = kaede_first_v*kaede_jump_time - (kaede_gravity * kaede_jump_time*kaede_jump_time)/2;
    var after_kaede_pozition = kaedeY - gravity_num;
    if(after_kaede_pozition >= 400){
      kaede_jump_bool = false;
      kaedeY = 400;
      kaede_jump_time = 1;
    }else if(table_bool && gravity_num < 0 && after_kaede_pozition >= 400 - vaice_height){
      kaedeY = 400 - vaice_width -10;
      double_jump = true;
    }else{
      kaedeY = after_kaede_pozition;
      kaede_jump_time += 1;
    }
  }
  //システム変数に追加
  time++;
  background_start_place += background_velocity;
  if(background_start_place > 2560 + background_velocity){
   background_start_place = 0;
  }
  //console.log(background_start_place);
  if(background_num_change){
    background_change_place -= background_velocity;
    if(background_change_place < 0 ){
      background_num_change = false;
      background_change_place = 1280;
    }
  }
  //当たり判定（未完成）
  for(var i = 0; i < vaice_org.length ; i++){
    if(vaice_org[i].bool){
      //落とし穴
      if(vaice_org[i].name == pit){
        if(vaice_org[i].x + vaice_width/2 > kaedeX && vaice_org[i].x + vaice_width < kaedeX + kaedeWidth/2 && !kaede_jump_bool && !kaede_destroy){
          if(!syanahakawaii){
            kaede_destroy = true;
            kaede_destroy_case = 0;
            background_velocity = 0;
          }
        }
      //ワープ
      }else if(vaice_org[i].name == warp){
        if(vaice_org[i].x + vaice_width/2 > kaedeX && vaice_org[i].x + vaice_width < kaedeX + kaedeWidth/2 && !kaede_jump_bool && !kaede_destroy){
          if(!syanahakawaii){
            kaede_destroy = true;
            kaede_destroy_case = 3;
            kaedeY = -kaedeHeight;
            //background_velocity = 0;
          }
        }
      //波
      }else if(vaice_org[i].name == wave){
      if(vaice_org[i].x < kaedeX + kaedeWidth/4  && vaice_org[i].x + wave_width > kaedeX + kaedeWidth/4  &&  vaice_org[i].y < kaedeY + kaedeHeight/2 && !kaede_destroy){
        if(!syanahakawaii){
          kaede_destroy = true;
          kaede_destroy_case = 2;
          //background_velocity = 0;
        }
      }
      //カニ(破壊不能オブジェクト)
      }else if(vaice_org[i].name == li1 || vaice_org[i].name == li2 || vaice_org[i].name == li3){
        if(vaice_org[i].x > kaedeX + kaedeWidth/2  && vaice_org[i].x < kaedeX + kaedeWidth/1.5  && vaice_org[i].y < kaedeY + kaedeHeight && vaice_org[i].y + vaice_height > kaedeY && !kaede_destroy){
          if(!syanahakawaii){
            kaedeMove_count = 0;
            kaede_atack_bool = true;
            kaede_destroy = true;
            kaede_destroy_case = 1;
            var sound = new Audio('data/sound/slash1.ogg');
            sound.play();
          }
        }
      //台
      }else if(vaice_org[i].name == feffects[6]){

      //敵
      }else{
        if(vaice_org[i].x > kaedeX + kaedeWidth/2  && vaice_org[i].x < kaedeX + kaedeWidth  && vaice_org[i].y < kaedeY + kaedeHeight && vaice_org[i].y + vaice_height > kaedeY){
          if(!vaice_org[i].destroy){
            var plusScore = 0;
            var sound = new Audio('data/sound/slash1.ogg');
            sound.play();
            for(var ii = 0; ii < vaice_List.length; ii++){
              if(vaice_org[i].name == vaice_List[ii].name){
                plusScore = vaice_List[ii].score;
              }
            }
            score += plusScore;
            background_changeScore += plusScore;
            vaice_org[i].destroy = true;
          }
          kaede_atack_bool = true;
          kaedeMove_count = 0;
        }
      }
      if(vaice_org[i].x < 0 && !(vaice_org[i].name == wave) && !(vaice_org[i].name == feffects[6])){
        vaice_org[i].bool = false;
        vaice_org[i].x = 1280;
        vaice_org[i].destroy = false;
      }else if(vaice_org[i].x < -wave_width + 200 && vaice_org[i].x > -wave_width){
        table_bool = false;
        double_jump = false;
      }else if(vaice_org[i].x < -wave_width){
        vaice_org[i].bool = false;
        if(vaice_org[i].name == wave || vaice_org[i].name == feffects[6]){
          //table_bool = false;
          //double_jump = false;
        }
        vaice_org[i].x = 1280;
        vaice_org[i].destroy = false;
      }
    }
  }
  //当たり判定確認
  if(destraction_check){
    ctx.beginPath();
    ctx.rect(kaedeX , kaedeY , kaedeWidth , kaedeHeight);
    ctx.rect(kaedeX , kaedeY , kaedeWidth/2 , kaedeHeight);
    ctx.strokeStyle = "purple";
    ctx.lineWidth = 2;
    ctx.stroke();
    ctx.closePath();
    ctx.beginPath();
    for(var i = 0; i < vaice_org.length; i++){
      if(vaice_org[i].bool){
        if(vaice_org[i].name == wave || vaice_org[i].name == feffects[6]){
          ctx.rect(vaice_org[i].x , vaice_org[i].y , wave_width , vaice_height);
        }else{
          ctx.rect(vaice_org[i].x , vaice_org[i].y , vaice_width , vaice_height);
        }
      }
    }
    ctx.strokeStyle = "red";
    ctx.stroke();
  }
  ctx.closePath();

  //背景切り替え
  //山1
  if(background_changeScore > mounten_morning_score && background_num == 0){
   background_num_change = true;
   before_stage = background_num;
   background_num = 1;
   background_changeScore = 0;
   background_velocity = background_mounten_afternoon_velocity;
  }
  //山2
  if(background_changeScore > mounten_noon_score && background_num == 1){
    background_num_change = true;
    before_stage = background_num;
    background_num = 2;
    background_changeScore = 0;
    background_velocity = background_mounten_night_velocity;
  }
  //山3
  if(background_changeScore > mounten_night_score && background_num == 2){
    background_num_change = true;
    background_changeScore = 0;
    if(background_change_stage == 0){
      before_stage = background_num;
      background_num = 3;
      bgm[0].pause();
      bgm[1].play();
      bgm[1].volume=0.3;
      bgm[1].loop=true;
      background_change_stage = 1;
      background_velocity = background_city_velocity;
    }else if(background_change_stage == 1){
      before_stage = background_num;
      background_num = 4;
      background_change_stage = 2;
      bgm[0].pause();
      bgm[2].play();
      bgm[2].volume=0.6;
      bgm[2].loop=true;
      background_velocity = background_see_velocity;
    }else if(background_change_stage == 2){
      before_stage = background_num;
      background_num = 3;
      background_change_stage = 3;
      bgm[0].pause();
      bgm[1].play();
      bgm[1].volume=0.3;
      bgm[1].loop=true;
      background_velocity = background_city_velocity;
    }
    //background_velocity = 8;
  }
  //街
  if(background_changeScore > city_score && background_num == 3){
    background_num_change = true;
    background_changeScore = 0;
    if(background_change_stage == 3){
      before_stage = background_num;
      background_num = 5;
      bgm[1].pause();
      bgm[3].play();
      bgm[3].volume=0.3;
      bgm[3].loop=true;
      background_velocity = background_universe_velocity;
    }else{
      before_stage = background_num;
      background_num = 0;
      bgm[1].pause();
      bgm[0].play();
      bgm[0].loop=true;
      background_velocity = background_mounten_noon_velocity;
    }
    //background_velocity = 8;
  }
  //海
  if(background_changeScore > see_score && background_num == 4){
    background_num_change = true;
    background_changeScore = 0;
    before_stage = background_num;
    background_num = 0;
    background_velocity = background_mounten_noon_velocity;
    bgm[2].pause();
    bgm[0].play();
    bgm[0].loop=true;
  }
  //宇宙
  if(background_changeScore > universe_score && background_num == 5){
    background_num_change = true;
    background_changeScore = 0;
    before_stage = background_num;
    background_num = 6;
    background_velocity = background_last_velocity;
    vaice_frequency = 25;
    bgm[3].pause();
    bgm[4].play();
    bgm[4].volume=0.3;
    bgm[4].loop=true;

  }
  //ラスト
  if(background_changeScore > last_score && background_num == 6){
    background_num_change = true;
    background_changeScore = 0;
    before_stage = background_num;
    background_num = 0;
    background_velocity = background_mounten_noon_velocity;
    background_change_stage = 0;
    vaice_frequency = 50;
    bgm[4].pause();
    bgm[0].play();
    bgm[0].loop=true;
  }
  //敵出現頻度
  if(time%vaice_frequency == 0){
    for(var i = 0 ; i < vaice_org.length ; i++ ){
      if(!vaice_org[i].bool){
        var vaice_detective = Math.floor(Math.random() * vaice_List.length);
        var random_y = getIntRandom(2);
        if(background_num == 0 || background_num == 3){
            var detecteve_big = getIntRandom(9);
            switch(detecteve_big){
              case 0 :
              vaice_detective = 17;
              break;
              case 1 :
              vaice_detective = 12;
              break;
              case 2 :
              vaice_detective = 14;
              break;
              case 3 :
              case 4 :
              if(background_num == 3){
                vaice_detective = 22;
                break;
              }
              case 5 :
              if(getIntRandom(1)){
               vaice_detective = 18;
              }else{
               vaice_detective = 16;
              }
              break;
              case 6 :
              case 7 :
              vaice_detective = 7 ;
              break;
              case 8 :
              case 9 :
              if(background_num == 3){
                vaice_detective = 7;
              }else{
                vaice_detective = 0;
              }
              break;
            }
          }else if(background_num == 1 || background_num == 4){
          var detecteve_big = getIntRandom(9);
          switch(detecteve_big){
            case 0 :
            vaice_detective = 1;
            break;
            case 1 :
            vaice_detective = 4;
            break;
            case 2 :
            vaice_detective = 5;
            break;
            case 3 :
            case 4 :
            case 5 :
            if(getIntRandom(1)){
             vaice_detective = 2;
            }else{
             vaice_detective = 6;
            }
            break;
            case 6 :
            case 7 :
            vaice_detective = 8;
            break;
            case 8 :
            case 9 :
            if(background_num == 4){
              vaice_detective = 21;
            }else{
              vaice_detective = 0;
            }
            break;
          }
          }else if(background_num == 2 || background_num == 5){
          var detecteve_big = getIntRandom(9);
          switch(detecteve_big){
            case 0 :
            vaice_detective = 19;
            break;
            case 1 :
            vaice_detective = 13;
            break;
            case 2 :
            case 3 :
            case 4 :
            if(getIntRandom(1)){
             vaice_detective = 15;
            }else{
             vaice_detective = 3;
            }
            break;
            case 5 :
            case 6 :
            case 7 :
            vaice_detective = 9;
            break;
            case 8 :
            case 9 :
            if(background_num == 5){
              vaice_detective = 20;
            }else{
              vaice_detective = 0;
            }
            break;
          }
        }
        vaice_org[i].bool = true;
        if(vaice_detective == 7 || vaice_detective == 8 || vaice_detective == 9){
          vaice_List[vaice_detective].position = random_y;
        }
        vaice_org[i].name = vaice_List[vaice_detective].name;
        switch(vaice_List[vaice_detective].position){
          case 0 :
            vaice_org[i].y = 400;
            break;
          case 1 :
            vaice_org[i].y = 250;
            break;
          case 2 :
            vaice_org[i].y = 100;
            break;
        }
        break;
      }
    }
  }
}
//------------

//-------------GameOver処理
function gameOver(){
  ctx.drawImage(feffects[2] , 0 , 0 , canvasWidth , canvasHeight);
  ctx.drawImage(feffects[3] , 540 , 550 , 200 , 80);
  ctx.drawImage(feffects[4] , 910 , 550 , 200 , 80);
  ctx.drawImage(feffects[5] , 170 , 550 , 200 , 80);
  ctx.font = 36 + 'pt Arial';
  ctx.fillStyle = 'rgba(255, 0, 0)';
  ctx.fillText(score , 640, 320);
}

function scoreDraw(){
  ctx.font = 18 + 'pt Arial';
  ctx.fillText(score_text , 1000, 30);
  ctx.fillText(score , 1100, 30);
  ctx.fillText("点" , 1240, 30);
  var next = 0;
  switch(background_num){
    case 0 :
    next = mounten_morning_score - background_changeScore;
    break;
    case 1 :
    next = mounten_noon_score - background_changeScore;
    break;
    case 2 :
    next = mounten_night_score - background_changeScore;
    break;
    case 3 :
    next = city_score - background_changeScore;
    break;
    case 4 :
    next = see_score - background_changeScore;
    break;
    case 5 :
    next = universe_score - background_changeScore;
    break;
    case 6 :
    next = last_score - background_changeScore;
    break;
  }
  ctx.fillText("next : " + next , 800, 30);
}


function draw() {
  switch(stage){
    case 0 :
    ctx.fillStyle = 'rgba(255, 0, 0)';
    start();
    break;
    case 1 :
    ctx.fillStyle = 'rgba(255, 0, 0)';
    game();
    break;
    case 2 :
    bgm[0].pause();
    bgm[1].pause();
    bgm[2].pause();
    bgm[3].pause();
    bgm[4].pause();
    ctx.fillStyle = 'rgba(255, 0, 0)';
    gameOver();
    testb();
    break;
    case 3 :
    ctx.font = 18 + 'pt Arial';
    ctx.fillStyle = 'rgba(0, 0, 255)';
    //ctx.fillText("マカハドマ" , 640, 360);
    ctx.drawImage(feffects[7] , 0 , 0 , canvasWidth , canvasHeight);
    break;
  }
}

function getRandom(n , m){
  return Math.floor(Math.random() * (m + 1 -n)) + n;
}
function getIntRandom(n){
  return Math.floor(Math.random() * n);
}

var detective = 1;
var detective_demention =[
	{x : 170 , y : 550},
	{x : 540 , y : 550},
	{x : 910 , y : 550}
];
function testb(){
   ctx.beginPath();
   ctx.fillText("Press Enter" , 520, 420);
   ctx.fillText("←　・　→" , 520, 460);
   for(var i = 0; i < detective_demention.length;i++){
   	if(i != detective){
   		ctx.rect(detective_demention[i].x , detective_demention[i].y , 200 , 80);
   	}
   }
   ctx.fillStyle = "rgba(255, 255, 255, 0.5)";
   ctx.fill();
   ctx.closePath();
}

function stopTimer(){
 clearInterval(testTimer);
}


var interval = setInterval(draw, 20);
[endscript]

[s]


*tweets
@wait time=300
[tb_twitter_share tweet_str="&'私のスコアは' + tf.score + '点です。切り捨て…御免！'" url="https://chloe.animelife.info" hashtags="カエデが斬る"]
;@jump target=*backtitle
[s]

*backtitle
[bg  storage="stage6.png" time="300"  ]

[iscript]
//キャンバスの全削除
$('canvas').remove();
[endscript]

@wait time=500
[jump storage="titlekaede01.ks"  target="*restart"  ]

[s]
