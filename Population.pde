class Population {
  float bestEver = Float.POSITIVE_INFINITY;
  final float MUTATION_RATE = 0.03;
  DNA bestEverDNA = null;
  float prevScore;
  float bestError;
  float deltaError;
  DNA[] dnas; 
  int popSize;
  Population(int size) {
    this.popSize = size;
    dnas = new DNA[popSize];
    try {  
      DNA parent = new DNA();
      parent.loadDNA();
      bestEverDNA = parent.clone();
      parent.calcError(image);
      bestEver = parent.error;   
      createGeneration(parent);
    }
    catch(Exception e) {

      for (int i : range(popSize)) {
        dnas[i] = new DNA();
      }
    }
  }

  void nextGeneration() {
    DNA parent = bestDna();
    if (gen % 5 == 0) {
      parent.saveDNA();
    }
    deltaError = prevScore - bestEverDNA.error;
    println("Generation       : " + gen);
    println("    Error        : " + parent.error);
    println("    Delta Error  : " + (prevScore - parent.error));
    println("    Genes Length : " + parent.genes.size());
    DNA[] newDnas = new DNA[popSize];
    newDnas[0] = bestEverDNA.clone(); 
    for (int i : range(1, popSize)) {
      newDnas[i] = parent.clone();
      newDnas[i].mutate(MUTATION_RATE);
    }
    dnas = newDnas.clone();
  }

  void createGeneration(DNA parent) {
    DNA[] newDnas = new DNA[popSize];
    for (int i : range(popSize)) {
      newDnas[i] = parent.clone();
      newDnas[i].mutate(MUTATION_RATE);
    }
    dnas = newDnas.clone();
  }


  DNA bestDna() {
    calcError(); 
    float minError = Float.POSITIVE_INFINITY; 
    DNA best = null; 
    for (DNA d : dnas) {
      if (d.error < minError) {
        best = d; 
        minError = best.error;
      }
    }
    prevScore = bestError;
    bestError = best.error;

    if (best.error < bestEver) {
      bestEverDNA = best.clone();
      bestEver = best.error;
    }
    return best.clone();
  }

  void calcError() {
    for (DNA d : dnas) {
      d.calcError(image);
    }
  }
}
