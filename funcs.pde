int[] range(int from, int to, int step) {
  try {
    int[] range = new int[(to - from)/step];

    for (int i = 0; i < range.length; i++) {
      range[i] = from + i * step;
    }
    return range;
  }
  catch(ArithmeticException e) {
    println("Invalid!");
  }
  return null;
}

int[] range(int from, int to) {
  return (range(from, to, 1));
}

int[] range(int to) {
  return (range(0, to, 1));
}
