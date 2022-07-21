
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



void setup() {
  size(500, 500);
}

void draw() {
  background(255, 100, 100);
  ellipse(width/2, height/2, 100, 100);
  for(int i = 0; i < game_names.length; i++){
    int x = i*width/game_names.length;
    int y = 0;
    int h = 50;
    float w = width/game_names.length;
    rect(x, y, w, h);
    for(int j = 0; j < game_names[i].length; j++){
      float nw = w/game_names[i].length;
      float nx = x+nw*j;
      rect(nx, y+h, nw, h);
    }
  }
}
