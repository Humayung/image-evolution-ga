int[] range(float from, float to, float step) {
  try {
    int[] range = new int[floor(abs((to - from)/step))];

    for (int i = 0; i < range.length; i++) {
      range[i] = floor(from + i * step);
    }
    return range;
  }
  catch(ArithmeticException e) {
    println("Invalid!");
  }
  return null;
}

int[] range(float from, float to) {
  return (range(from, to, 1));
}

int[] range(float to) {
  return (range(0, to, 1));
}
