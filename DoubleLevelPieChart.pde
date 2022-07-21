class DoubleLevelPieChart {
  int cx, cy, r;
  StrInt[] main_data;
  String[][] sub_data;
  int size;
  DoubleLevelPieChart(int x, int y, int _r, StrInt[] main, String[][] sub) {
    cx = x;
    cy = y;
    r = _r;
    main_data = main;
    sub_data = sub;
    size = 0;
    for (StrInt si : main) {
      size += si.value;
    }
  }

  void display() {
    float radv = TWO_PI/size;
    float rad = -PI/2;
    for (int i = 0; i < main_data.length; i++) {
      color mc = color(int(map(i, 0, main_data.length, 0, 255)));
      if (main_data[i].value != 1) {
        float srad = rad;
        for (int j = 0; j < main_data[i].value; j++) {
          color sc = color(200, int(map(j, 0, main_data[i].value, 0, 255)), 200);
          fill(sc);
          arc(cx, cy, r+100, r+100, srad, srad+radv*(j+1));
          srad += radv;
        }
        printSI(main_data[i]);
      }
      fill(mc);
      arc(cx, cy, r, r, rad, rad+radv*main_data[i].value);
      rad += radv*main_data[i].value;
    }
  }
}
