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

//----------------------------------------------------------------外部管理用変数
/**ライフ管理
 * [elife1 ライフ管理用変数]
 * @type {Number}
 */
var elife1 = 10;

/**フラグ管理
 * [eflag1 フラグ管理用変数]
 * @type {Number}
 */
var eflag1 = 0;

//クリア時の外的要因の追加
var spclear1 = false;
var spclear2 = false;
var spnclear1 = false;
var spnclear2 = false;

/**敗北管理
 * [elose1 敗北管理用変数]
 * @type {Number}
 */
var elose1 = 0;

//-----------------------------------------------------------------------------

//---------------------------------------------------------------開発者用
/**デバッグモード判定
 * [debugMode description]
 * @type {Boolean}
 */
var debugMode = false;

/**デバッグモード管理者用
 * [debugModeCommand description]
 * @type {Boolean}
 */
var debugModeCommand = false;

//--------------------------------------------------------------


/**画面停止判定
 * [pause 画面停止用変数]
 * @type {Boolean}
 */
var pause = false;

/**画面停止時パターン
 * [pauseCase 画面停止パターン変数]
 * @type {Number}
 */
var pauseCase = 0;

/**総時間
 * [time 総時間変数]
 * @type {Number}
 */
var time = 0;

/**スコア
 * [score スコア保管用変数]
 * @type {Number}
 */
var score = 100000;

/**秒間あたりの減少数
 * [scoreDegTime 減少変数]
 * @type {Number}
 */
var scoreDegTime = 10;
