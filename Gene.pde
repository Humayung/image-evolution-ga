class Gene {
  float x;
  float y;
  color c;
  Gene(float x, float y, color c) {
    this.x = x;
    this.y = y;
    this.c = c;
  }

  void show() {
    fill(c);
    rect(x, y, 5, 5);
  }
} 
