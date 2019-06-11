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
    canvas.rect(x, y, 1, 1);
  }

  void reInit(float w, float h) {
    x = random(0, w);
    y = random(0, h);
    c = color(random(255), random(255), random(255));
  }
} 

class DNA {
  final int length = 6000;
  float error;
  float w, h;
  Gene[] genes = new Gene[length];
  PGraphics canvas;

  DNA(int w, int h) {
    this.w = w;
    this.h = h;
    canvas = createGraphics(w, h);
    canvas.beginDraw();
    canvas.noStroke();
    canvas.rectMode(CENTER);

    for (int i : range(genes.length)) {
      color c = color(random(255), random(255), random(255));
      genes[i] = new Gene(random(0, w), random(0, h), c);      
      genes[i].paint(canvas);
    }
    canvas.endDraw();
  }

  void show(float tx, float ty) {
    image(canvas, tx, ty);
  }

  void calcErr(PImage target) {
    target.loadPixels();
    canvas.loadPixels();
    error = 0f;
    for (int i : range(target.pixels.length)) {
      float rErr = abs(red(target.pixels[i]) - red(canvas.pixels[i])); 
      float gErr = abs(red(target.pixels[i]) - red(canvas.pixels[i])); 
      float bErr = abs(red(target.pixels[i]) - red(canvas.pixels[i])); 
      float meanErr = (rErr + gErr + bErr) / 3;
      error += meanErr;
    }
  }

  void mutate() {
    for (Gene g : genes) {
      g.reInit(w, h);
    }
    updateCanvas();
  }

  void updateCanvas() {
    canvas.beginDraw();
    canvas.clear();
    for (Gene g: genes) { 
      g.paint(canvas);
    }
    canvas.endDraw();
  }
}
