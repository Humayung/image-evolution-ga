class Gene {
  float x;
  float y;
  color c;
  Gene(float x, float y, color c) {
    this.x = x;
    this.y = y;
    this.c = c;
  }

  void paint(PGraphics canvas) {
    canvas.fill(c);
    canvas.rect(x, y, 2, 2);
  }

  void reInit(float w, float h) {
    x = random(0, w);
    y = random(0, h);
    c = color(random(255), random(255), random(255));
  }
} 
