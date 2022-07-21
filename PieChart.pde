class PieChart {
  int cx, cy, r;
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

  void display() {
    float radv = TWO_PI/size;
    float rad = -PI/2;
    for (int i = 0; i < data.length; i++) {
      fill(int(map(i, 0, data.length, 0, 255)));
      arc(cx, cy, r, r, rad, rad+radv*data[i].value);
      rad += radv*data[i].value;
    }
  }
}
