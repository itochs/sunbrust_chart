class DoubleLevelPieChart {
  // 中心座標と親の直径と親子の距離
  PVector position;
  int r, w;
  // 親データ
  StrInt[] main_data;
  /* 子データが実質的に全データになってるから親データ要らないかも */
  // 子データ
  String[][] sub_data;
  // データサイズ
  int size;
  /*
   *  データサイズ:
   *  子要素が0なら，要素数は1
   *  子要素が0以外なら，要素数は親を抜いた全要素数
   *  面倒なことしてるのは自覚してる
   */
  DoubleLevelPieChart(int x, int y, int _r, int _w, StrInt[] main, String[][] sub) {
    position = new PVector(x, y);
    r = _r;
    w = _w;
    main_data = main;
    sub_data = sub;
    size = 0;
    for (StrInt si : main) {
      size += si.value;
    }
  }

  void display() {
    boolean tf = isInFan(position, new PVector(mouseX, mouseY), 100, -PI/2, 0);
    if (!tf) {
      println(tf);
    } else {
      // 要素数に対する角度の割合
      float radv = TWO_PI/size;
      // 初期角度
      float rad = -PI/2;
      for (int i = 0; i < main_data.length; i++) {
        // 子要素の描画
        if (main_data[i].value != 1) {
          float srad = rad;
          for (int j = 0; j < main_data[i].value; j++) {
            color sc = color(200, int(map(j, 0, main_data[i].value, 0, 255)), 200);
            fill(sc);
            arc(position.x, position.y, r+w, r+w, srad, srad+radv*(j+1));
            srad += radv;
          }
          //printSI(main_data[i]);
        }
        // 親要素の描画
        color mc = color(int(map(i, 0, main_data.length, 0, 255)));
        fill(mc);
        arc(position.x, position.y, r, r, rad, rad+radv*main_data[i].value);
        //角度の更新
        rad += radv*main_data[i].value;
      }
    }
  }

  boolean isInFan(PVector center, PVector mouse_position, int fan_len, float start_rad, float end_rad) {
    PVector fan_start_pos = new PVector(center.x + fan_len*cos(start_rad), center.y + fan_len*sin(start_rad));
    line(fan_start_pos.x, fan_start_pos.y, center.x, center.y);
    ellipse(fan_start_pos.x, fan_start_pos.y, 10, 10);
    
    PVector fan_end_pos = new PVector(center.x + fan_len*cos(end_rad), center.y + fan_len*sin(end_rad));
    line(fan_end_pos.x, fan_end_pos.y, center.x, center.y);
    ellipse(fan_end_pos.x, fan_end_pos.y, 10, 10);
    
    PVector fan2pos = mouse_position.copy();
    fan2pos.sub(center);
    stroke(0, 255, 0);
    line(center.x + fan2pos.x, center.y + fan2pos.y, center.x, center.y);
    ellipse(center.x + fan2pos.x, center.y + fan2pos.y, 10, 10);
    return false;
  }
}
