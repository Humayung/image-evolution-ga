class Population {
  DNA[] dnas; 
  Population(int size) {
    dnas = new DNA[size];
    for (int i : range(size)) {
      dnas[i] = new DNA();
    }
  }

  DNA bestDna() {
    calcErr();

    long minErr = Long.MAX_VALUE;
    DNA best = null;
    for (DNA d : dnas) {
      if (d.error < minErr) {
        best = d;
        minErr = best.error;
      }
    }
    
    return best.clone();
  }

  DNA worseDna() {
    calcErr();

    long maxErr = 0;
    DNA worst = null;
    for (DNA d : dnas) {
      if (d.error > maxErr) {
        worst = d;
        maxErr = worst.error;
      }
    }
    return worst.clone();
  }

  void calcErr() {
    for (DNA d : dnas) {
      d.calcErr(image);
    }
  }
}
