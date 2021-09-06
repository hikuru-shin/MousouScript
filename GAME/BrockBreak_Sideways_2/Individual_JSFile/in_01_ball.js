//----------------------------------------------------------------ボール初期設定
/**ボールの大きさ
 * [ballRadius description]
 * @type {Number}
 */
var ballRadius = 7;

/**ボールのx座標
 * [x description]
 * @type {Number}
 */
var x = 110;

/**ボールのy座標
 * [y description]
 * @type {[type]}
 */
//var y = $('canvas')[0].height-107;
var y = 60;

/**ボールのx座標加速度
 * [dx description]
 * @type {Number}
 */
var dx = +5;

/**ボールのy座標加速度
 * [dy description]
 * @type {Number}
 */
var dy = -5;

/**ひとつ前のボールのx座標
 * [lastx description]
 * @type {Number}
 */
var lastx = 0;

/**ひとつ前のボールのy座標
 * [lasty description]
 * @type {Number}
 */
var lasty = 0;

/**ボールの貫通モード判定
 * [enatlation description]
 * @type {Number}
 */
var enatlation = 0;

/**ボールの発射判定
 * [waitBall description]
 * @type {Number}
 */
var waitBall = 0;

/**ボールの発射しているか判定
 * [start description]
 * @type {Number}
 */
var start = 0;

/**スタート角度決定用
 * [startalfanum description]
 * @type {Number}
 */
var startalfanum = 0;

/**
 * スタート角度可否判定
 * @type {Boolean}
 */
var isStartalfa = true;

/**スタート角度可否判定
 * [isStartalfanum description]
 * @type {Number}
 */
var isStartalfanum = 0;

/**スタート角度数格納用
 * [startalfa description]
 * @type {Array}
 */
var startalfa = [];
startalfa[0] = {x:30,y:70};
startalfa[1] = {x:60,y:40};
startalfa[2] = {x:100,y:0};
startalfa[3] = {x:60,y:-40};
startalfa[4] = {x:30,y:-70};
