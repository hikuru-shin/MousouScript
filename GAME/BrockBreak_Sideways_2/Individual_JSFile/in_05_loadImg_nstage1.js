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
