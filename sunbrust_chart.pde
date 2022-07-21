
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
  background(255, 100, 100);
  //ellipse(width/2, height/2, 100, 100);

  stroke(0);
  //strokeWeight(3);
  float radv = TWO_PI/sum_games;
  push();
  rectMode(CENTER);
  translate(width/2, height/2);
  rotate(radv/2);
  for (float rad = -radv; rad < TWO_PI-radv; rad += radv) {
    push();
    {
      rotate(rad);
      rect(200, 0, 50, 50);
    }
    pop();
  }
  pop();

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
}
