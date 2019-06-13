class DNA {
  int INITIAL_GENES = 0;
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
    for (Gene g : clone.genes) {
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
  }

  void mutate(float mutationRate) {
    //if(genes.size() < MAX_GENES){
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
    canvas.endDraw();
  }

  void saveDNA() {
    Table genesTable = new Table();
    genesTable.addColumn("x");
    genesTable.addColumn("y");
    genesTable.addColumn("d");
    genesTable.addColumn("c");
    
    final int MAX_VERT = 10;
    for (int i : range(4, 25)) {
      genesTable.addColumn("vert" + (i - 4));
    }

    for (int i : range(genes.size())) {
      TableRow tr = genesTable.addRow();
      
      for (int j : range(4)) {
        tr.setFloat(j, genes.get(i).data[j]);
      }
      
      for (int j : range(MAX_VERT* 2)) {
        Gene g = genes.get(i);
        if (j/2 < g.vertices.size()) {
          tr.setFloat(j + 4, g.vertices.get(j/2).x);
          tr.setFloat(j + 5, g.vertices.get(j/2).y);
        }else{
          tr.setFloat(j + 4, -999);
          tr.setFloat(j + 5, -999);
        }
      }
      //for (int j : range(4, 24, 2)) {
      //for (int j = 0; j < 20; j+= 2) {
      //  if (j/2 < genes.get(i).vertices.size()) {
      //    tr.setFloat(j + 3, genes.get(i).vertices.get(j/2).x);
      //    tr.setFloat(j+1 + 3, genes.get(i).vertices.get(j/2).y);
      //  } else {
      //    tr.setFloat(j + 3, -9999);
      //    tr.setFloat(j+1 + 3, -9999);
      //  }
      //}
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
    INITIAL_GENES = tr.getInt(1); 

    genes.clear(); 
    for (int i : range(INITIAL_GENES)) {
      TableRow tRow = genesTable.getRow(i); 
      float[] data = new float[4]; 
      ArrayList<Vertex> vertices = new ArrayList<Vertex>(); 

      for (int j : range(4)) {
        data[j] = tr.getFloat(j);
      }

      for (int j : range(4, genes.get(0).MAX_VERT * 2, 2)) {
        if (tRow.getFloat(j) != -9999) {
          vertices.add(new Vertex(tRow.getFloat(j), tRow.getFloat(j+1)));
        }
      }
      genes.add(new Gene(data, vertices));
    }
    updateCanvas();
  }



  DNA clone() {
    return new DNA(this);
  }
}
