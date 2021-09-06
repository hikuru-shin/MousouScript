/**
 * ブロック描画
 * @return {[type]} [description]
 */
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
