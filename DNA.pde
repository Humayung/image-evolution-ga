class DNA {
  final int length = 6000;
  long error;
  Gene[] genes = new Gene[length];
  PGraphics canvas;

  DNA() {
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
  
  DNA(DNA clone) {
    this.genes = clone.genes.clone();   
    this.error = clone.error;
    canvas = createGraphics(w, h);
    canvas.noStroke();
    canvas.rectMode(CENTER);
    updateCanvas();
  }

  void show(float tx, float ty) {
    image(canvas, tx, ty);
  }

  void calcErr(PImage target) {
    target.loadPixels();
    canvas.loadPixels();
    error = 0;
    float rErr;
    float gErr;
    float bErr;
    float meanErr;
    for (int i : range(target.pixels.length)) {
      rErr = abs(red(target.pixels[i]) - red(canvas.pixels[i])); 
      gErr = abs(green(target.pixels[i]) - green(canvas.pixels[i])); 
      bErr = abs(blue(target.pixels[i]) - blue(canvas.pixels[i])); 
      meanErr = (rErr + gErr + bErr) / 3;
      error += meanErr;
    }
  }

  void mutate(float mutationRate) {
    for (Gene g : genes) {
      if (random(1) < mutationRate) {
        g.reInit(w, h);
      }
    }
    updateCanvas();
  }

  void updateCanvas() {
    canvas.beginDraw(); 
    canvas.clear();
    for (Gene g : genes) { 
      g.paint(canvas);
    }
    canvas.endDraw();
  }
  
  DNA clone(){
    return new DNA(this);
  }
}
