
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
StrInt[] categories;

int sum_games;
PieChart p;
DoubleLevelPieChart dp;

void setup() {
  size(500, 500);
  categories = new StrInt[game_names.length];
  for (int i = 0; i < game_names.length; i++) {
    //for (String[] category : game_names) {
    int cnt = game_names[i].length;
    if (cnt == 1) {
      sum_games += 1;
    } else {
      sum_games += cnt - 1;
    }
    categories[i] = new StrInt(game_names[i][0], cnt == 0 ? 1 : cnt);
  }
  println(sum_games);
  sortSI(categories, true);
  printSI(categories);
  //rectMode(CENTER);
  p = new PieChart(width/2, height/2, 200, categories);
  dp = new DoubleLevelPieChart(width/2, height/2, 200, categories, game_names);
  noLoop();
}

void draw() {
  background(255, 200, 200);

  dp.display();
}
