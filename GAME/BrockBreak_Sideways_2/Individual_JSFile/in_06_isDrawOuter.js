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
