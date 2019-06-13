DNA dna;
//PImage image;
//PGraphics image;
int popSize = 100;
int[] size = new int[2];
PGraphics image;
Population pop;
void setup() {
  //textSize(20);
  fullScreen();

  //image = loadImage("/home/cornoblue/Pictures/reference.png");
  //image.resize(100, 100);
  //image.resize(image.width/3, image.height/3);
  image = createGraphics(100, 100);
  image.beginDraw();
  image.noStroke();
  image.background(255);
  image.fill(255, 100, 50);
  image.ellipse(50, 50, 50, 50);
  image.endDraw();
  size[0] = image.width;
  size[1] = image.height;
  pop = new Population(popSize);
}
void draw() {

  //println(floor(random(3)));  
  pop.nextGeneration();
  gen++;
  if (pop.prevScore != pop.bestEver) {
    pop.bestEverDNA.canvas.save("results/best" + gen + ".png");
  }
  if (gen % 3 ==0) {
    show();
    pop.bestEverDNA.canvas.save("best.png");
  }
  
  
  
  //println(pop.bestEver + " - " + gen + " - " + pop.mean());
}

void show() {
  background(255);
  image(image, 0, 0) ;
  fill(0);
  text("Generation  : " + gen, image.width*2, 20);
  text("Error       : " + pop.bestEver, image.width*2, 40);
  text("Genes Length: " + pop.bestEverDNA.genes.size(), image.width*2, 60);
  pop.bestEverDNA.show(image.width, 0);  

  int index = 0;
  for (int x : range(0, width, image.width)) {
    for (int y : range(image.height, height, image.height)) {
      pop.dnas[index].show(x, y);
      index++;
    }
  }
}
int gen = 0;
