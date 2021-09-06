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
        var num = Math.floor(Math.random() * Math.floor(3));//3か2か1にする
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
    console.log(e);
    clearInterval(interval);
  }
}
var interval = setInterval(draw, 20);
