class StrInt {
  String name;
  int value;
  StrInt(String str, int num) {
    name = str;
    value = num;
  }
}

void printSI(StrInt si) {
  println("name: " + si.name + ", value: " + si.value);
}

void printSI(StrInt[] sis) {
  for (StrInt si : sis) {
    printSI(si);
  }
}

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
    StrInt buff = sis[i];
    sis[i] = sis[id];
    sis[id] = buff;
  }
}
