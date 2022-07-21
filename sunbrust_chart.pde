
String[][] game_names = {
  {"shooting game", "FPS / TPS", "flight "}, 
  {"action game", "platform game", 
  "PvP game", "Fighting game", "stealth action"}, 
  {"roll playing game", "action RPG", "simulation RPG"}, 
  {"adventure game", "action adventure game"}, 
  {"race game"}, 
  {"puzzle game"}, 
  {"simulation RPG", "trun based strategy", "real time strategy", 
    "tower defence", "Nurturing game", 
  "construction and management simulation", "operation game"}, 
  {"sandbox"}, 
  {"music"}, 
  {"table game", "boad game", "card game"}
};

int sum_games;


void setup() {
  size(500, 500);
  for (String[] category : game_names) {
    int cnt = category.length - 1;
    if (cnt == 0) {
      sum_games += 1;
    } else {
      sum_games += cnt;
    }
  }
  println(sum_games);
  //rectMode(CENTER);
  noLoop();
}

void draw() {
  background(100, 100, 100);

  stroke(0);
  //strokeWeight(3);
  //circlePutting();
  //drawTreeVis();
  tenBlock();
  //float radv = TWO_PI/sum_games;
  //float rad = -radv;
  //push();
  //{
  //  //rectMode(CENTER);
  //  translate(width/2, height/2);
  //  rotate(radv/2);
  //  for (int i = 0; i < game_names.length; i++) {
  //    push();
  //    {
  //      rotate(rad);
  //      int w = 50;
  //      int h = 50*game_names[i].length;
  //      rect(200+w/2, 0-h/2, w, h);
  //    }
  //    pop();
  //    println(game_names[i].length == 1 ? 1 : game_names[i].length-1);
  //    rad += radv*(game_names[i].length == 1 ? 1 : game_names[i].length-1);
  //  }
  //}
  //pop();
}

void drawTreeVis() {
  push();
  for (int i = 0; i < game_names.length; i++) {
    int x = i*width/game_names.length;
    int y = 0;
    int h = 50;
    float w = width/game_names.length;
    rect(x, y, w, h);
    for (int j = 1; j < game_names[i].length; j++) {
      float nw = w/(game_names[i].length-1);
      float nx = x+nw*(j-1);
      rect(nx, y+h, nw, h);
    }
  }
  pop();
}

void circlePutting() {
  push();
  {
    float radv = TWO_PI/10;
    //rectMode(CENTER);
    translate(width/2, height/2);
    rotate(radv/2);
    int cnt = 1;
    for (int i = 0; i < 10; ) {
      for (int j = 0; j < cnt; j++) {
        rotate(radv);
      }
      fill(128, 255, 128);

      stroke(0, 0, 255);
      rect(70+50/2, 0-50/2, 50, 50);
      line(0, 0, width, 0);
      i+=cnt;
      cnt++;
    }
  }
  pop();
}


void tenBlock() {
  float radv = TWO_PI/10;
  float[][] startEndRads = new float[4][2];
  for (int i = 0; i < startEndRads.length; i++) {
    if (i == 0) {
      startEndRads[i][0] = 0;
      startEndRads[i][1] = radv;
      //startEndRads[i][1] = 1;
    } else {
      startEndRads[i][0] = startEndRads[i-1][1];
      startEndRads[i][1] = startEndRads[i][0] + radv*(i+1);
      //startEndRads[i][1] = startEndRads[i][0] + i+1;
    }
  }
  for (float[] rads : startEndRads) {
    println(rads);
  }

  push();
  {
    strokeWeight(3);
    translate(width/2, height/2);
    int cr = 100;
    noFill();
    ellipse(0, 0, cr*2, cr*2);
    for (float[] rads : startEndRads) {
      push();
      rotate(rads[0]);
      stroke(0, 255, 255);
      line(0, 0, width, 0);
      translate(cr, 0);
      float innerRad =rads[1] - rads[0];
      rotate(innerRad/2);
      rect(0, 0, 50, cr*sin(innerRad)/sin((PI-innerRad)/2));
      pop();
    }
  }
  pop();
}
