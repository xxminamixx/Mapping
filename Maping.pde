PImage img;
int[] mappingX = new int[20];
int[] mappingY = new int[20];
int[][] mapColor = new int[3][20];
int cPoint = 1;//mapColorのポインタ
int mPoint = 1;
int eliSize = 20;
int sec = 0;
float imgCalc;
boolean saveFlag;
boolean blueFlag;
boolean greenFlag;
boolean redFlag;

/*ファイルを選択*/
void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    img = loadImage(selection.getName());
    frame.setSize(img.width + frame.getInsets().left +frame.getInsets().right, img.height + frame.getInsets().top + frame.getInsets().bottom);
  }
}

void setup() {
  size(600, 600);
  noStroke();
}

void draw() {

  // background(255, 255, 255);
  if (img != null)  image(img, 0, 0, img.width, img.height);

  if (saveFlag == false) {
    //青色の円を描写
    fill(100, 149, 237);
    ellipse(550, 20, eliSize, eliSize);
    //緑色の円を描写
    fill(60, 179, 113);
    ellipse(550, 60, eliSize, eliSize);
    //赤色の円を描写
    fill(255, 99, 71);
    ellipse(550, 100, eliSize, eliSize);

    //画像を開くボタンを描写
    rect(520, 180, 60, 20);
    fill(255, 255, 255);
    text("open", 535, 192);

    //画像を保存するボタンを描写
    fill(100, 149, 237);
    rect(520, 220, 60, 20);
    fill(255, 255, 255);
    text("save", 535, 232);
  }

  ellipseCnt();
  if (saveFlag == true) {
    text("保存に\n成功しました", 520, 260);
    sec = sec + 1; 
    if (sec == 60) {
      sec = 0;
      saveFlag = false;
    }
  }
}


void ellipseCnt() {
  if (blueFlag == true) {
    fill(100, 149, 237);
    ellipse(mouseX, mouseY, eliSize, eliSize);
  } else if (greenFlag == true) {
    fill(60, 179, 113);
    ellipse(mouseX, mouseY, eliSize, eliSize);
  } else if (redFlag == true) {
    fill(255, 99, 71);
    ellipse(mouseX, mouseY, eliSize, eliSize);
  } 
  for (int i = 1; i < mappingX.length; i++) {
    fill(mapColor[0][i], mapColor[1][i], mapColor[2][i]);  
    if (mappingX[i] != 0 && mappingY[i] != 0) ellipse(mappingX[i], mappingY[i], eliSize, eliSize);
  }
}

/*
void saveEvent(){
 text("保存に成功しました",550,250);
 }
 */

void mousePressed() {
  if (540 <= mouseX && mouseX <= 560 && 10 <= mouseY && mouseY <= 30 && img != null) {
    blueFlag = true;//青の円の範囲内をクリックしたら青フラグをtrue
    mapColor[0][cPoint] = 100;
    mapColor[1][cPoint] = 149;
    mapColor[2][cPoint] = 237;
  } else if (540 <= mouseX && mouseX <= 560 && 50 <= mouseY && mouseY <= 70 && img != null) {
    greenFlag = true;//緑の円の範囲内をクリックしたら緑フラグをtrue
    mapColor[0][cPoint] = 60;
    mapColor[1][cPoint] = 179;
    mapColor[2][cPoint] = 113;
  } else if (540 <= mouseX && mouseX <= 560 && 90 <= mouseY && mouseY <= 110 && img != null) {
    redFlag = true;//赤の円の範囲内をクリックしたら赤フラグをtrue
    mapColor[0][cPoint] = 255;
    mapColor[1][cPoint] = 99;
    mapColor[2][cPoint] = 71;
  } else if (520 <= mouseX && mouseX <= 580 && 180 <= mouseY && mouseY <= 200) {
    selectInput("ファイルを選んでください:", "fileSelected");
  } else if (520 <= mouseX && mouseX <= 580 && 220 <= mouseY && mouseY <= 240) {
   saveFlag = true;
    save("mapping.jpg");
   
  } else if (blueFlag == true || greenFlag == true || redFlag == true && img != null) {
    //どれかのフラグがtrueの時何もない場所をクリックしたらその場所のx.y座標を配列に記録し、フラグを全てfalseにする
    blueFlag = false;
    greenFlag = false;
    redFlag = false;

    mappingX[mPoint] = mouseX;//マッピングしたい場所をクリックしたときのX座業を記録
    mappingY[mPoint] = mouseY;//マッピングしたい場所をクリックしたときのY座標を記録
    if (mPoint < 19) mPoint = mPoint + 1; //nullPointer防止
    if (cPoint < 19) cPoint = cPoint + 1;
  }
}

