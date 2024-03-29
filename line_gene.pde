//class Gene {
//  float[] data = new float[6];
//  Gene() {
//    data[0] = random(size[0]); 
//    data[1] = random(size[1]);
//    data[2] = random(size[0]); 
//    data[3] = random(size[1]);
//    data[4] = color(random(255), random(255), random(255), random(255));
//    data[5] = random(1, 5);
//  }

//  Gene(float[] data) {
//    this.data = data.clone();
//  }

//  void paint(PGraphics canvas) {
//    canvas.stroke(int(data[4]));
//    //canvas.strokeWeight(data[5]);
//    canvas.line(data[0], data[1], data[2], data[3]);
//  }

//  void mutate() {
//    int param = floor(random(4));
//    switch(param) {      
//    case 0:
//      data[0] = constrain(data[0] + randomGaussian()*3, 0, size[0]);
//      data[1] = constrain(data[1] + randomGaussian()*3, 0, size[1]);
//      break;
//    case 1:
//      data[2] = constrain(data[0] + randomGaussian()*3, 0, size[0]);
//      data[3] = constrain(data[1] + randomGaussian()*3, 0, size[1]);
//    case 2:      
//      int c = int(data[2]);
//      int red = int(constrain(red(c) + randomGaussian() * 4, 0, 255));
//      int green = int(constrain(green(c) + randomGaussian() * 4, 0, 255));
//      int blue = int(constrain(blue(c) + randomGaussian() * 4, 0, 255));
//      int alpha = int(constrain(alpha(c) + randomGaussian() * 4, 0, 255));
//      data[4] = color(red, green, blue, alpha);
//    case 3:
//      data[5] = constrain(data[5] + randomGaussian(), 1, 5);
//      break;
//    }
//  }


//  Gene clone() {
//    return new Gene(this.data);
//  }
//} 
//===========================================================++DAN
//class DNA {
//  final float ADD_GENE_CHANCE = 0.3;
//  final float REM_GENE_CHANCE = 0.3;
//  int geneDataLen = 6;
//  float error = 0.0;
//  float geneFitness = 0;
//  ArrayList<Gene> genes;
//  PGraphics canvas;

//  DNA() {
//    genes = new ArrayList<Gene>();
//    canvas = createGraphics(size[0], size[1]);
//    canvas.rectMode(CENTER);
//    updateCanvas();
//  }

//  DNA(DNA clone) {
//    error = clone.error;
//    genes = new ArrayList<Gene>();
//    for (Gene g : clone.genes) {
//      this.genes.add(g.clone());
//    }
//    canvas = createGraphics(size[0], size[1]);
//    canvas.rectMode(CENTER);
//    updateCanvas();
//  }

//  void show(float tx, float ty) {
//    image(canvas, tx, ty);
//  }

//  void calcError(PImage target) {
//    target.loadPixels();
//    canvas.loadPixels();
//    error = 0;
//    float rErr = 0;
//    float gErr = 0;
//    float bErr = 0;
//    for (int i : range(target.pixels.length)) {
//      rErr = abs(red(target.pixels[i]) - red(canvas.pixels[i]));
//      gErr = abs(green(target.pixels[i]) - green(canvas.pixels[i]));
//      bErr = abs(blue(target.pixels[i]) - blue(canvas.pixels[i]));
//      error += (rErr + gErr + bErr);
//    }
//  }

//  void mutate(float mutationRate) {
//    for (Gene g : genes) {
//      if (random(1) < mutationRate) {
//        g.mutate();
//      }
//    }
//    if (random(1) < ADD_GENE_CHANCE) {
//      genes.add(new Gene());
//    }
//    if (random(1) < REM_GENE_CHANCE && genes.size() > 0) {
//      genes.remove(floor(random(genes.size())));
//    }
//    updateCanvas();
//  }
  
//  void updateCanvas() {
//    canvas.beginDraw(); 
//    canvas.background(255);
//    geneFitness = 0.0;
//    for (Gene g : genes) { 
//      g.paint(canvas);
//    } 
//    canvas.endDraw();
//  }

//  void saveDNA() {
//    Table genesTable = new Table();
//    for (int i : range(6)) {
//      genesTable.addColumn(Integer.toString(i));
//    }
//    for (int i : range(genes.size())) {
//      TableRow tr = genesTable.addRow();
//      for (int j : range(6)) {
//        tr.setFloat(j, genes.get(i).data[j]);
//      }
//    }
//    Table infoTable = new Table();
//    infoTable.addColumn("Gen");
//    infoTable.addColumn("Genes Length");
//    TableRow tr;
//    tr = infoTable.addRow();
//    tr.setInt(0, gen);
//    tr.setInt(1, genes.size());

//    saveTable(infoTable, "info.csv");
//    saveTable(genesTable, "Genes.csv");
//  }


//  void loadDNA() {
//    Table genesTable = loadTable("Genes.csv");
//    Table infoTable = loadTable("info.csv");
//    TableRow tr = infoTable.getRow(1);

//    gen = tr.getInt(0);
//    int genesLength = tr.getInt(1);
//    genes.clear();
//    float[] data = new float[6];
//    for (int i : range(genesLength)) {
//      TableRow tRow = genesTable.getRow(i);
//      for (int j : range(data.length)) {
//        data[j] = tRow.getFloat(j);
//      }
//      genes.add(new Gene(data));
//    }
//    updateCanvas();
//  }


//  DNA clone() {
//    return new DNA(this);
//  }
//}
