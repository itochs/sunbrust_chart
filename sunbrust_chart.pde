// 全データ
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
DoubleLevelPieChart dp;

void setup() {
  size(500, 500);
  // 先頭要素だけ取得，子要素の数に応じた値も取得
  categories = new StrInt[game_names.length];
  for (int i = 0; i < game_names.length; i++) {
    int cnt = game_names[i].length;
    if (cnt == 1) {
      sum_games += 1;
    } else {
      sum_games += cnt - 1;
    }
    categories[i] = new StrInt(game_names[i][0], cnt == 0 ? 1 : cnt);
  }
  // 取得した要素数の表示
  //println(sum_games);
  // カテゴリのソート
  /* 要らないかも */
  sortSI(categories, true);
  // カテゴリの表示
  printSI(categories);
  // double level pie chartの初期化
  // 中心座標(x, y)，直径，親子の距離，カテゴリ(後々要らないかも)，全データ
  dp = new DoubleLevelPieChart(width/2, height/2, 200, 100, categories, game_names);
  //noLoop();
}

void draw() {
  background(255, 200, 200);
  // double level pie chartの描画
  dp.display();
}

void mouseClicked(){
  dp.onClick();
}
