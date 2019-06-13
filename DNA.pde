class DNA {
  final int INITIAL_GENES = 0;
  final int MAX_GENES = 200;
  final float ADD_GENE_CHANCE = 0.2;
  final float REM_GENE_CHANCE = 0.2;
  float error = 0.0;
  ArrayList<Gene> genes;
  PGraphics canvas;

  DNA() {
    genes = new ArrayList<Gene>();
    canvas = createGraphics(size[0], size[1]);
    canvas.beginDraw();
    canvas.noStroke();
    canvas.background(255);
    canvas.rectMode(CENTER);
    
    for (int i : range(INITIAL_GENES)) {
      genes.add(new Gene()); 
      genes.get(i).paint(canvas);
    }
    canvas.endDraw();
  }

  DNA(DNA clone) {
    error = clone.error;
    genes = new ArrayList<Gene>();
    for(Gene g : clone.genes){
      this.genes.add(g.clone());
    }
    canvas = createGraphics(size[0], size[1]);
    canvas.noStroke();
    canvas.rectMode(CENTER);
    updateCanvas();
  }

  void show(float tx, float ty) {
    image(canvas, tx, ty);
  }

  void calcError(PImage target) {
    target.loadPixels();
    canvas.loadPixels();
    error = 0;
    float rErr = 0;
    float gErr = 0;
    float bErr = 0;
    for (int i : range(target.pixels.length)) {
      rErr = abs(red(target.pixels[i]) - red(canvas.pixels[i]));
      gErr = abs(green(target.pixels[i]) - green(canvas.pixels[i]));
      bErr = abs(blue(target.pixels[i]) - blue(canvas.pixels[i]));
      error += (rErr + gErr + bErr);
    }
    //error = 
  }

  void mutate(float mutationRate) {
    if(genes.size() < MAX_GENES){
      for(Gene g : genes){
        if(random(1) < mutationRate){
          g.mutate(size);
        }
      }
    }else{
      ArrayList<Gene> mutant = new ArrayList<Gene>();
      for(int i : range(mutationRate * genes.size())){
        mutant.add(genes.get(floor(random(genes.size()))));
      }
      
      for(Gene g : mutant){
        g.mutate(size);
      }
    }
    if(random(1) < ADD_GENE_CHANCE){
      genes.add(new Gene());
    }
    if(random(1) < REM_GENE_CHANCE && genes.size() > 0){
      genes.remove(floor(random(genes.size())));
    }
    updateCanvas();
  }

  void updateCanvas() {
    canvas.beginDraw(); 
    canvas.noStroke();
    canvas.background(255);
    for (Gene g : genes) { 
      g.paint(canvas);
    }
    canvas.endDraw();
  }

  DNA clone() {
    return new DNA(this);
  }
}
