var imgs_url= [
  "data/bgimage/paddle.png",

  //上に描画する画像
  "data/bgimage/ast1.png",

  //下に描画する画像
  "data/bgimage/ast2.png",

  "data/bgimage/pause.png",
  "data/bgimage/laser1.png",
  "data/bgimage/laser2.png",
  "data/bgimage/laser3.png",
  "data/bgimage/bakuhatu.png",
  "data/bgimage/skill3.png",
  "data/bgimage/skill2.png",
  "data/bgimage/skill1.png",
  "data/bgimage/fan1.png",
  "data/bgimage/fan2.png",
  "data/bgimage/fan3.png",
  "data/bgimage/fan4.png",
  "data/bgimage/fog1.png",
  "data/bgimage/fog2.png",
  "data/bgimage/fog3.png",
  "data/bgimage/eyes1.png",
  "data/bgimage/eyes2.png",
  "data/bgimage/eyes1_ori.png",
  "data/bgimage/eyes2_ori.png",
  "data/bgimage/fan11.png",
  "data/bgimage/fan21.png",
  "data/bgimage/fan31.png",
  "data/bgimage/fan41.png",
  "data/bgimage/Rlaser1.png",
  "data/bgimage/Rlaser2.png",
  "data/bgimage/Rlaser3.png"
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
