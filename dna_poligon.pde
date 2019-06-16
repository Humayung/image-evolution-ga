//int MAX_POLIGON  = 6;
//class DNA {
//  int INITIAL_GENES = 0;
//  final int MAX_GENES = 200;
//  final float ADD_GENE_CHANCE = 0.2;
//  final float REM_GENE_CHANCE = 0.2;
//  float error = 0.0;
//  ArrayList<Gene> genes;
//  PGraphics canvas;

//  DNA() {
//    genes = new ArrayList<Gene>();
//    canvas = createGraphics(size[0], size[1]);
//    canvas.beginDraw();
//    canvas.noStroke();
//    canvas.background(255);
//    canvas.rectMode(CENTER);

//    for (int i : range(INITIAL_GENES)) {
//      genes.add(new Gene()); 
//      genes.get(i).paint(canvas);
//    }
//    canvas.endDraw();
//  }

//  DNA(DNA clone) {
//    error = clone.error;
//    genes = new ArrayList<Gene>();
//    for (Gene g : clone.genes) {
//      this.genes.add(g.clone());
//    }
//    canvas = createGraphics(size[0], size[1]);
//    canvas.noStroke();
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
//      error += (rErr + gErr + bErr)/3;
//    }
//  }

//  void mutate(float mutationRate) {
//    //if(genes.size() < MAX_GENES){
//    for (Gene g : genes) {
//      if (random(1) < mutationRate) {
//        g.mutate();
//      }
//    }
//    //}else{
//    //  ArrayList<Gene> mutant = new ArrayList<Gene>();
//    //  for(int i : range(mutationRate * genes.size())){
//    //    mutant.add(genes.get(floor(random(genes.size()))));
//    //  }

//    //  for(Gene g : mutant){
//    //    g.mutate(size);
//    //  }
//    //}
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
//    canvas.noStroke();
//    canvas.background(255);
//    for (Gene g : genes) { 
//      g.paint(canvas);
//    }
//    canvas.endDraw();
//  }

//  void saveDNA() {

//    Table infoTable = new Table();


//    infoTable.addColumn("Gen");
//    infoTable.addColumn("Genes Length");
//    TableRow tr;
//    tr = infoTable.addRow();
//    tr.setInt(0, gen);
//    tr.setInt(1, genes.size());
//    saveTable(infoTable, "info.csv");

//    Table genesTable = new Table();   
//    for (int i : range(4)) {
//      genesTable.addColumn(Integer.toString(i));
//    }
//    for (int i : range(0, MAX_POLIGON * 2, 2)) {
//      genesTable.addColumn(Integer.toString(i + 4));
//      genesTable.addColumn(Integer.toString(i+1 + 4));
//    }
//    for (int i : range(genes.size())) {
//      genes.get(i).shrinkifyData();
//      TableRow currRow = genesTable.addRow();
//      for (int j : range(4)) {
//        currRow.setFloat(j, genes.get(i).data[j]);
//      }      

//      for (int j : range(0, MAX_POLIGON * 2, 2)) {
//        Gene g = genes.get(i);
//        if (j/2 < g.vertices.size()) {
//          currRow.setFloat(j + 4, g.vertices.get(j/2).x);
//          currRow.setFloat(j + 5, g.vertices.get(j/2).y);
//        } else {
//          currRow.setFloat(j + 4, 99.0);
//          currRow.setFloat(j + 5, 99.0);
//        }
//      }
//    }
//    saveTable(genesTable, "genes.csv");
//  }


//  void loadDNA() {

//    Table infoTable = loadTable("info.csv");
//    TableRow tr = infoTable.getRow(1);

//    gen = tr.getInt(0);
//    INITIAL_GENES = tr.getInt(1);

//    genes.clear();
//    Table genesTable = loadTable("genes.csv");
//    for (int i : range(INITIAL_GENES)) {
//      TableRow currRow = genesTable.getRow(i);

//      float[] data = new float[4];
//      for (int j : range(4)) {
//        data[j] = currRow.getFloat(j);
//      }

//      ArrayList<Vertex> vertices = new ArrayList<Vertex>();
//      for (int j : range(0, MAX_POLIGON * 2, 2)) {
//        float x = currRow.getFloat(j + 4);
//        float y = currRow.getFloat(j+ 5);
//        if (int(x) != 99 ) {
//          vertices.add(new Vertex(x, y));
//        }
//      }
//      genes.add(new Gene(data, vertices));
//    }
//    updateCanvas();
//  }


//  DNA clone() {
//    return new DNA(this);
//  }
//}
