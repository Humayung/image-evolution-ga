class Population {
  float bestEver = Integer.MAX_VALUE;
  float bestGen = Integer.MAX_VALUE;

  int gen = 0;
  final float MUTATION_RATE = 0.005;
  DNA bestEverDNA = null;
  float prevError;
  DNA[] dnas; 
  int popSize;
  Population(int size) {
    this.popSize = size;
    dnas = new DNA[popSize];

    try {      
      DNA parent = new DNA();
      PopData data = parent.loadDNA();
      bestEverDNA = parent.clone();
      bestEverDNA.updateCanvas();
      createGeneration(parent);
      gen = data.gen;
    }
    catch(Exception e) {

      for (int i : range(popSize)) {
        dnas[i] = new DNA();
      }
    }
  }

  void nextGeneration() {
    gen++;
    DNA parent = bestDna();
    parent.saveDNA();
    println("Generation       : " + gen);
    println("    Error        : " + parent.error);
    println("    Delta Error  : " + (prevError - bestEver));
    println("    Peak DE      : " + peakDeltaError);
    println("    Genes Length : " + parent.genes.size());
    dnas[0] = parent.clone(); 
    dnas[0].updateCanvas();
    for (int i : range(1, popSize)) {
      dnas[i] = parent.clone();
      dnas[i].mutate(MUTATION_RATE);
      dnas[i].updateCanvas();
    }
  }

  void createGeneration(DNA parent) {    
    DNA[] newDnas = new DNA[popSize];
    newDnas[0] = parent.clone();
    newDnas[0].updateCanvas();
    for (int i : range(1, popSize)) {
      newDnas[i] = parent.clone();
      newDnas[i].mutate(MUTATION_RATE);  
      newDnas[i].updateCanvas();
    }
    dnas = newDnas.clone();
  }


  DNA bestDna() {
    calcError();   
    DNA best = null; 
    prevError = bestGen;
    for (DNA d : dnas) {
      if (d.error <= bestGen) {
        best = d; 
        bestGen = best.error;
      }
    }
    if (bestGen < bestEver) {
      bestEverDNA = best.clone();
      bestEver = bestGen;
    }
    bestEverDNA.updateCanvas();
    return best.clone();
  }

  void calcError() {
    for (DNA d : dnas) {
      d.calcError();
    }
  }
}

class PopData {
  int gen;
  int genesLength;
  PopData(int gen, int genesLength) {
    this.gen = gen;
    this.genesLength = genesLength;
  }
}
