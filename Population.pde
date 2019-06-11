class Population {
  DNA[] dnas; 
  Population(int size) {
    dnas = new DNA[size];
    for (int i : range(size)) {
      dnas[i] = new DNA(w, h);
    }
  }
}
