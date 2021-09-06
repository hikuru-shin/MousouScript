//------------------------------------------------------------ブロックの初期設定
/**ブロックの個数
 * [brickCum description]
 * @type {Number}
 */
var brickCum = 0;

/**ブロックの列数
 * [brickRowCount description]
 * @type {Number}
 */
var brickRowCount =36;

/**ブロックの行数
 * [brickColumnCount description]
 * @type {Number}
 */
var brickColumnCount = 53;

/**ブロックの横幅
 * [brickWidth description]
 * @type {Number}
 */
var brickWidth = 20;

/**ブロックの高さ
 * [brickHeight description]
 * @type {Number}
 */
var brickHeight = 20;

/**ブロック間の余白
 * [brickPadding description]
 * @type {Number}
 */
var brickPadding = 0;

/**ブロック間の上余白
 * [brickOffsetTop description]
 * @type {Number}
 */
var brickOffsetTop = 0;

/**ブロック間の左余白
 * [brickOffsetLeft description]
 * @type {Number}
 */
var brickOffsetLeft = 80;

/**生成ブロック管理用
 * [bricks description]
 * @type {Array}
 */
var bricks = [];

/**ブロックの初期設定(statusをすべて0)
 * [for description]
 * @param  {[type]} var [description]
 * @return {[type]}     [description]
 */
for(var c=0; c<brickColumnCount; c++) {
    bricks[c] = [];
    for(var r=0; r<brickRowCount; r++) {
      bricks[c][r] = { x: 0, y: 0, status: 0 };
    }
}
