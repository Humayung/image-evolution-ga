class DNA {
  final float ADD_GENE_CHANCE = 0.3;
  final float REM_GENE_CHANCE = 0.3;
  float error = 0.0;
  ArrayList<Gene> genes;
  PGraphics canvas;

  DNA() {
    genes = new ArrayList<Gene>();
    canvas = createGraphics(size[0], size[1]);
    canvas.rectMode(CENTER);
    updateCanvas();
  }

  DNA(DNA clone) {
    error = clone.error;
    genes = new ArrayList<Gene>();
    for (Gene g : clone.genes) {
      this.genes.add(g.clone());
    }
    canvas = createGraphics(size[0], size[1]);
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
  }

  void mutate(float mutationRate) {
    for (Gene g : genes) {
      if (random(1) < mutationRate) {
        g.mutate();
      }
    }
    if (random(1) < ADD_GENE_CHANCE) {
      genes.add(new Gene());
    }
    if (random(1) < REM_GENE_CHANCE && genes.size() > 0) {
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
    //println("Gene fitness: " + geneFitness); 
    canvas.endDraw();
  }

  void saveDNA() {
    Table genesTable = new Table();
    for (int i : range(7)) {
      genesTable.addColumn(Integer.toString(i));
    }
    for (int i : range(genes.size())) {
      TableRow tr = genesTable.addRow();
      for (int j : range(7)) {
        tr.setFloat(j, genes.get(i).data[j]);
      }
    }
    Table infoTable = new Table();
    infoTable.addColumn("Gen");
    infoTable.addColumn("Genes Length");
    TableRow tr;
    tr = infoTable.addRow();
    tr.setInt(0, gen);
    tr.setInt(1, genes.size());

    saveTable(infoTable, "info.csv");
    saveTable(genesTable, "Genes.csv");
  }


  void loadDNA() {
    Table genesTable = loadTable("Genes.csv");
    Table infoTable = loadTable("info.csv");
    TableRow tr = infoTable.getRow(1);

    gen = tr.getInt(0);
    int genesLength = tr.getInt(1);
    genes.clear();
    float[] data = new float[7];
    for (int i : range(genesLength)) {
      TableRow tRow = genesTable.getRow(i);
      for (int j : range(data.length)) {
        data[j] = tRow.getFloat(j);
      }
      genes.add(new Gene(data));
    }
    updateCanvas();
  }


  DNA clone() {
    return new DNA(this);
  }
}
