
// 文字列と数値を格納できる
class StrInt {
  String name;
  int value;
  StrInt(String str, int num) {
    name = str;
    value = num;
  }
}
// 出力
void printSI(StrInt si) {
  println("name: " + si.name + ", value: " + si.value);
}
// 配列の出力
void printSI(StrInt[] sis) {
  for (StrInt si : sis) {
    printSI(si);
  }
}
// bubble sort
void sortSI(StrInt[] sis, boolean reverse) {
  for (int i = 0; i < sis.length; i++) {
    int id = i;
    for (int j = i; j < sis.length; j++) {
      if (reverse) {
        if (sis[id].value < sis[j].value) id = j;
      } else {
        if (sis[id].value > sis[j].value) id = j;
      }
    }
    StrInt buffer = sis[i];
    sis[i] = sis[id];
    sis[id] = buffer;
  }
}
