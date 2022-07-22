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
  int INIT_SIZE;
  int size;
  int selected_parent_id = -1;
  /*
   *  データサイズ:
   *  子要素が0なら，要素数は1
   *  子要素が0以外なら，要素数は親を抜いた全要素数
   *  面倒なことしてるのは自覚してる
   */
  DoubleLevelPieChart(int x, int y, int _r, int _w, StrInt[] main, String[][] sub) {
    //代入
    position = new PVector(x, y);
    r = _r;
    w = _w;
    main_data = main;
    sub_data = sub;
    //データ数の初期化
    size = 0;
    for (StrInt si : main) {
      size += si.value;
    }
    INIT_SIZE = size;
    println("init: " + INIT_SIZE);
  }

  void display() {
    //boolean tf = isInFan(position, new PVector(mouseX, mouseY), 100, -PI/2, PI/2);
    ////println(tf);
    //if(tf){
    //  return;
    //}
    // 要素数に対する角度の割合
    float radv = TWO_PI/size;

    // 初期角度
    float rad = -PI/2;

    // マウス座標
    PVector mouse_pos = new PVector(mouseX, mouseY);
    //描画
    for (int i = 0; i < main_data.length; i++) {

      //選択されたやつではないなら何もしない
      if (selected_parent_id >= 0 && i != selected_parent_id) {
        continue;
      }
      //println(degrees(rad));

      // 親が選択されているかどうか
      boolean parent_selected = isInFan(position, mouse_pos, r/2, rad, rad+radv*main_data[i].value);

      // 子要素の描画
      if (main_data[i].value != 1) {
        float srad = rad;
        for (int j = 0; j < main_data[i].value; j++) {
          //println("\t" + degrees(srad) + " & " + degrees(srad+radv));

          //子が選択されているかどうか
          boolean child_selected = isInFan(position, mouse_pos, (r+w)/2, srad, srad+radv);

          //子の色
          color sc = color(200, int(map(j, 0, main_data[i].value, 0, 255)), 200, 128);

          //子要素だけ選択されているかどうか
          if (!parent_selected && child_selected) {

            //親も選択されていることにする
            parent_selected = true;

            //子の色を選択されていることがわかる色にする
            sc = color(0, 0, 255, 128);
          }
          //colorMode(RGB, 255);
          fill(sc);
          arc(position.x, position.y, r+w, r+w, srad, srad+radv);
          srad += radv;
        }
        //printSI(main_data[i]);
      }

      // 親要素の描画
      push();
      colorMode(HSB, 255);

      //親の色
      color mc = color(int(map(i, 0, main_data.length, 0, 255)), 128, 255);

      //親が選択されているかどうか
      if (parent_selected) {
        //親が選択されいるのがわかる色に変更
        mc = color(0, 0, 255);
      }

      //描画本体
      fill(mc);
      arc(position.x, position.y, r, r, rad, rad+radv*main_data[i].value);
      pop();

      //角度の更新
      rad += radv*main_data[i].value;
    }

    //テキストの描画
    displayText();

    //中心からマウス座標の場所までの表示，デバッグ用
    stroke(0, 255, 0);
    line(mouse_pos.x, mouse_pos.y, position.x, position.y);
  }

  //テキストの描画
  void displayText() {
    push();

    //テキストの大きさ
    textSize(24);

    //テキストの位置指定
    textAlign(LEFT, TOP);

    //中心へ移動
    translate(position.x, position.y);

    // 要素数に対する角度の割合
    float radv = TWO_PI/size;

    // 初期角度
    float rad = -PI/2;

    //描画
    for (int i = 0; i < main_data.length; i++) {

      //選択されたやつではないなら何もしない
      if (selected_parent_id >= 0 && i != selected_parent_id) {
        continue;
      }

      //親要素の描画
      push();
      noStroke();

      //回転させて適切な位置に？
      rotate(rad + radv*main_data[i].value/2);
      fill(0);
      text(sub_data[i][0], 20, -12);
      //ellipse(10, 0, 10, 10);
      pop();

      //子がない場合
      if (main_data[i].value == 1) {
        rad += radv*main_data[i].value;
        continue;
      }

      //子の描画
      float srad = rad;
      for (int j = 0; j < main_data[i].value; j++) {
        push();
        boolean wrapBack = textWidth(sub_data[i][j+1]) > (r+w)/2;

        //はみ出す場合
        if (wrapBack) {

          //扇の端に移動
          rotate(srad);

          //テキストの分割
          String[] strs = sub_data[i][j+1].split(" ");

          //それぞれのテキストの描画
          for (int l = 0; l < strs.length; l++) {
            float x = 10 + r/2;
            //println(strs[l]);
            fill(0);
            text(strs[l], x, 24*l);
          }
          
        } else {  //はみ出さい場合
          
          //扇の中心に移動
          rotate(srad + radv/2);
          
          //テキストの描画
          fill(0);
          text(sub_data[i][j+1], 10 + r/2, 0);
          //println(sub_data[i][j]);
        }
        pop();
        
        //角度の更新
        srad += radv;
      }
      
      //角度の更新，変数に入れた方が絶対にいい
      rad += radv*main_data[i].value;
    }
    pop();
  }

  void onClick() {
    // 要素数に対する角度の割合
    float radv = TWO_PI/size;
    //println("size: " + size);
    //println("deglee: " + degrees(radv));
    // 初期角度
    float rad = -PI/2;
    // マウス座標
    PVector mouse_pos = new PVector(mouseX, mouseY);
    for (int i = 0; i < main_data.length; i++) {
      if (selected_parent_id >= 0 && i != selected_parent_id) {
        continue;
      }
      
      // 親が選択されているかどうか
      boolean parent_selected = isInFan(position, mouse_pos, r/2, rad, rad+radv*main_data[i].value);
      //println(i + ": " + parent_selected);
      if (main_data[i].value != 1) {
        float srad = rad;
        for (int j = 0; j < main_data[i].value; j++) {
          //println(degrees(srad) + " & " + degrees(srad+radv));
          
          //子が選択されているかどうか
          boolean child_selected = isInFan(position, mouse_pos, (r+w)/2, srad, srad+radv);
          //println("\t" + j + ": " + child_selected);
          
          //子が選択されているなら何もしない
          if (!parent_selected && child_selected) {
            return;
          }
      
          //更新
          srad += radv;
        }
      }
      
      //親が選択されて，選択されたものがない場合
      if (parent_selected && selected_parent_id < 0) {
        
        //選択されたものを格納
        selected_parent_id = i;
        
        //選択されたもののデータ数
        size = main_data[i].value;
        return;
      }

      //更新
      rad += radv*main_data[i].value;
    }
    
    //チャート外をクリックした，もしくは親要素をクリックした場合
    //初期設定に戻す
    selected_parent_id = -1;
    size = INIT_SIZE;
  }

  boolean isInFan(PVector center, PVector mouse_position, int fan_len, float start_rad, float end_rad) {
    //ellipse(center.x, center.y, fan_len*2, fan_len*2);
    //扇の中心からの距離が遠い
    float dist = dist(center.x, center.y, mouse_position.x, mouse_position.y);
    if (dist >= fan_len) {
      return false;
    }

    //最初の角度での弧の座標
    PVector fan_start_pos = new PVector(center.x + fan_len*cos(start_rad), center.y + fan_len*sin(start_rad));
    //line(fan_start_pos.x, fan_start_pos.y, center.x, center.y);
    //ellipse(fan_start_pos.x, fan_start_pos.y, 10, 10);

    //終わりの角度の座標
    PVector fan_end_pos = new PVector(center.x + fan_len*cos(end_rad), center.y + fan_len*sin(end_rad));
    //line(fan_end_pos.x, fan_end_pos.y, center.x, center.y);
    //ellipse(fan_end_pos.x, fan_end_pos.y, 10, 10);

    //扇の中心からのベクトル
    PVector fan2start = fan_start_pos.copy().sub(center);
    PVector fan2end = fan_end_pos.copy().sub(center);
    //stroke(0, 0, 255);
    //strokeWeight(8);
    //line(center.x + fan2start.x, center.y + fan2start.y, center.x, center.y);
    //strokeWeight(5);
    //line(center.x + fan2end.x, center.y + fan2end.y, center.x, center.y);

    //扇を二分割するベクトル
    float half_rad = (end_rad - start_rad)/2;
    //PVector fan_center = fan2start.copy().add(fan2end).normalize().mult(fan_len);
    PVector fan_c = new PVector(cos(start_rad + half_rad), sin(start_rad + half_rad));
    //strokeWeight(3);
    //line(center.x + fan_c.x, center.y + fan_c.y, center.x, center.y);

    //扇の中心からマウス座標のベクトル
    PVector fan2mouse = mouse_position.copy().sub(center);
    //stroke(0, 255, 0);
    //line(center.x + fan2mouse.x, center.y + fan2mouse.y, center.x, center.y);
    //ellipse(center.x + fan2mouse.x, center.y + fan2mouse.y, 10, 10);

    //扇を二分割するベクトルと扇の中心からマウス座標のベクトルのなす角
    //println(fan2mouse);
    //println(fan_c);
    float theta = PVector.angleBetween(fan2mouse, fan_c);
    //println(theta);
    //thetaが扇の角度の半分より大きいなら扇の外
    if (theta >= half_rad) {
      return false;
    }

    //最終的に残ったら扇の中
    return true;
  }
}
