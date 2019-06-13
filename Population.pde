class Population {
  float bestEver = Float.POSITIVE_INFINITY;
  final float MUTATION_RATE = 0.02;
  DNA bestEverDNA = null;
  long total = 0;
  DNA[] dnas; 
  int popSize;
  Population(int size) {
    this.popSize = size;
    dnas = new DNA[popSize];
    for (int i : range(popSize)) {
      dnas[i] = new DNA();
    }
  }

  void nextGeneration() {
    DNA parent = bestDna();
    println("Generation       : " + gen);
    println("    Error        : " + parent.error);
    println("    Genes Length : " + parent.genes.size());
    //println(parent.error);
    DNA[] newDnas = new DNA[popSize];
    for(int i : range(popSize)){
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
    if (best.error < bestEver) {
      bestEverDNA = best.clone();
      bestEver = best.error;
    }
    return best.clone();
  }
  
  //DNA bestDna() {
  //  calcError(); 
  //  float maxError = 0; 
  //  DNA best = null; 
  //  for (DNA d : dnas) {
  //    if (d.error > maxError) {
  //      best = d; 
  //      maxError = best.error;
  //    }
  //  }
  //  if (best.error > bestEver) {
  //    bestEverDNA = best.clone();
  //    bestEver = best.error;
  //  }
  //  return best.clone();
  //}
  
  
  void calcError() {
    for (DNA d : dnas) {
      d.calcError(image);
    }
  }
}
