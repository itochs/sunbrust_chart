class PieChart {
  // 中心座標と直径
  int cx, cy, r;
  // 描画するデータ(名前とその個数)
  StrInt[] data;
  int size;
  PieChart(int x, int y, int _r, StrInt[] _data) {
    cx = x;
    cy = y;
    r = _r;
    data = _data;
    size = 0;
    for (StrInt si : data) {
      size += si.value;
    }
  }

  // 描画
  void display() {
    // 全個数に対する角度
    float radv = TWO_PI/size;
    // 初期角度
    float rad = -PI/2;
    for (int i = 0; i < data.length; i++) {
      fill(int(map(i, 0, data.length, 0, 255)));
      arc(cx, cy, r, r, rad, rad+radv*data[i].value);
      rad += radv*data[i].value;
    }
  }
}
