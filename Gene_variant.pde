//class Gene {

//  float[] data = new float[7];
//  int type = 0;
//  Gene() {
//    data[0] = random(size[0]); 
//    data[1] = random(size[1]);

//    data[2] = color(random(255), random(255), random(255), random(255));
//    data[3] = random(1, 40);
//    data[4] = random(1, 40);

//    data[5] = random(TWO_PI);
//    data[6] = floor(random(2));
//  }

//  Gene(float[] data) {
//    this.data = data.clone();
//  }

//  void paint(PGraphics canvas) {
//    canvas.fill(int(data[2]));
//    canvas.pushMatrix();
//    canvas.translate(data[0], data[1]);
//    canvas.rotate(data[5]);
//    if (int(data[6]) == 0)
//      canvas.rect(0, 0, data[3], data[4]);
//    else
//      canvas.ellipse(0, 0, data[3], data[4]);
//    canvas.popMatrix();
//  }

//  void mutate() {
//    int param = floor(random(5));
//    float shift;
//    switch(param) {      
//    case 0:
//      shift = 50;
//      data[0] = constrain(data[0] + randomGaussian()*shift, 0, size[0]);
//      data[1] = constrain(data[1] + randomGaussian()*shift, 0, size[1]);
//      break;
//    case 1:      
//      int c = int(data[2]);
//      int red = int(constrain(red(c) + randomGaussian() * 20, 0, 255));
//      int green = int(constrain(green(c) + randomGaussian() * 20, 0, 255));
//      int blue = int(constrain(blue(c) + randomGaussian() * 20, 0, 255));
//      int alpha = int(constrain(alpha(c) + randomGaussian() * 20, 0, 255));
//      data[2] = color(red, green, blue, alpha);
//    case 2:
//      shift = 10;
//      data[3] = constrain(data[3] + randomGaussian()*shift, 1, 40);
//      data[4] = constrain(data[4] + randomGaussian()*shift, 1, 40);
//      break;
//    case 3:
//      data[6] = floor(random(2));
//      break;
//    case 4:
//      data[5] = constrain(data[5] + randomGaussian(), 0, TWO_PI);
//      break;
//    }
//  }


//  Gene clone() {
//    return new Gene(this.data);
//  }
//} 

//=============================================================================+DNA
//class DNA {
//  final float ADD_GENE_CHANCE = 0.3;
//  final float REM_GENE_CHANCE = 0.3;
//  float error = 0.0;
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

//    int num = floor(random(10));
//    for (int i : range(num)) {
//      if (random(1) < ADD_GENE_CHANCE) {
//        genes.add(new Gene());
//      }
//      if (random(1) < REM_GENE_CHANCE && genes.size() > 0) {
//        genes.remove(floor(random(genes.size())));
//      }
//    }
//    updateCanvas();
//  }

//  void updateCanvas() {
//    canvas.beginDraw(); 
//    canvas.noStroke();
//    canvas.background(255);
//    for (Gene g : genes) { 
//      g.paint(canvas);
//    }
//    canvas.endDraw();
//  }

//  void saveDNA() {
//    Table genesTable = new Table();
//    for (int i : range(7)) {
//      genesTable.addColumn(Integer.toString(i));
//    }
//    for (int i : range(genes.size())) {
//      TableRow tr = genesTable.addRow();
//      for (int j : range(7)) {      
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
//    float[] data = new float[7];
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
