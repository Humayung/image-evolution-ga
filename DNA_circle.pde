class Gene {
  float maxDia= max(size);
  float[] data = new float[4];
  int type = 0;
  int mutated = 0;
  float mutationSize = 2;
  float colMutation = 0.05 * mutationSize;
  float diaMutation = 0.0225 * mutationSize;
  float posMutation = 0.0225 * mutationSize;

  Gene() {
    data[0] = random(size[0]); 
    data[1] = random(size[1]);
    data[2] = color(random(255), random(255), random(255), random(255));
    data[3] = random(1, random(random(random(maxDia))));
  }

  Gene(float[] data) {
    this.data = data.clone();
  }

  void paint(PGraphics canvas) {
    canvas.fill(int(data[2]));
    canvas.ellipse(data[0], data[1], data[3], data[3]);
  }

  void mutate() {
    int param = floor(random(7));
    float mt = 0.7;
    mutated = param + 1;
    float m =  randomGaussian() * 2;
    if (param > 2 && floor(m) < 1) {
      mutated = 0;
    }
    int c = int(data[2]);
    float[] col = new float[]{red(c), green(c), blue(c), alpha(c)};

    switch(param) {      
    case 0:
      data[0] = constrain(data[0] + randomGaussian() * mt, 0, size[0]);
      break;

    case 1:
      data[1] = constrain(data[1] + randomGaussian() * mt, 0, size[1]);
      break;
    case 2:
      data[3] = constrain(data[3] + randomGaussian() * mt, 1, maxDia);
      break;
    case 3:     
      col[0] = constrain(col[0] + m, 0, 255);       
      data[2] = color(col[0], col[1], col[2], col[3]);
      break;
    case 4:     
      col[1] = constrain(col[1] + m, 0, 255);       
      data[2] = color(col[0], col[1], col[2], col[3]);
      break;
    case 5:     
      col[2] = constrain(col[2] + m, 0, 255);       
      data[2] = color(col[0], col[1], col[2], col[3]);
      break;
    case 6:     
      col[3] = constrain(col[3] + m, 0, 255);       
      data[2] = color(col[0], col[1], col[2], col[3]);
      break;
    }
  }


  Gene clone() {
    Gene clone = new Gene(this.data);
    clone.mutated = mutated;
    return clone;
  }
} 

//===================================================================================+DNA
//===================================================================================+DNA
//===================================================================================+DNA
Table genesTable;
Table infoTable;
class DNA {
  final float ADD_GENE_CHANCE = 0.3;
  final float REM_GENE_CHANCE = 0.2;
  int error = 0;
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
  }

  void show(float tx, float ty) {
    image(canvas, tx, ty);
  }
  void showMutated(float tx, float ty) {
    strokeWeight(1.5);
    pushMatrix();
    translate(tx, ty);

    for (Gene g : genes) {
      if (g.mutated > 0) {
        color c = color(255);
        String text = "";
        switch(g.mutated) {
        case 1:
          c = color(255, 10, 0);
          text = "X";
          break;
        case 2:
          c = color(255, 255, 0);
          text = "Y";
          break;
        case 3:
          c = color(255, 0, 255);
          text = "D";
          break;
        case 4:
          c = color(255, 100, 100);
          text = "R";
          break;
        case 5:
          c = color(100, 255, 100);
          text = "G";
          break;
        case 6:
          c = color(90, 255, 0);
          text = "B";
          break;
        case 7:
          c = color(51);
          text = "A";
          break;
        case 8:
          c = color(255, 255, 255);
          text = "N";
          break;
        }
        stroke(c);
        noFill();

        ellipse(g.data[0], g.data[1], g.data[3], g.data[3]);
        fill(c);
        text(text, g.data[0], g.data[1]);
      }
    }
    strokeWeight(1);
    popMatrix();
  }

  void calcError() {
    canvas.loadPixels();
    error = 0;
    float rErr;
    float gErr;
    float bErr;
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
      } else {
        g.mutated = 0;
      }
    }


    if (random(1) < ADD_GENE_CHANCE) {
      Gene newGene = new Gene();
      genes.add(newGene);
      newGene.mutated = 8;
    }
    if (random(1) < REM_GENE_CHANCE && genes.size() > 0) {
      genes.remove(floor(random(genes.size())));
    }
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
    genesTable = new Table();
    for (int i : range(4)) {
      genesTable.addColumn(Integer.toString(i));
    }
    for (int i : range(genes.size())) {
      TableRow tr = genesTable.addRow();
      for (int j : range(4)) {      
        tr.setFloat(j, genes.get(i).data[j]);
      }
    }
    infoTable = new Table();
    infoTable.addColumn("Gen");
    infoTable.addColumn("Genes Length"); 
    infoTable.addColumn("Time Elapsed");
    TableRow tr;
    tr = infoTable.addRow();
    tr.setInt(0, pop.gen);
    tr.setInt(1, genes.size());  
    tr.setLong(2, timeElapsed);

    try {
      saveTable(infoTable, "info.csv");
      saveTable(genesTable, "Genes.circle.csv");
    }
    catch(Exception e) {
      e.printStackTrace();
    }
  }


  PopData loadDNA() {
    Table genesTable = loadTable("Genes.circle.csv");
    Table infoTable = loadTable("info.csv");
    TableRow tr = infoTable.getRow(1);

    timeElapsed = tr.getLong(2);
    PopData popData = new PopData(tr.getInt(0), tr.getInt(1));
    genes.clear();
    float[] data = new float[4];
    for (int i : range(popData.genesLength)) {
      TableRow tRow = genesTable.getRow(i);
      for (int j : range(data.length)) {
        data[j] = tRow.getFloat(j);
      }
      genes.add(new Gene(data));
    }
    updateCanvas();
    return popData;
  }


  DNA clone() {
    return new DNA(this);
  }
}
