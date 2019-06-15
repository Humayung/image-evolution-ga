DNA dna;
PImage image;
//PGraphics image;
int popSize = 100;
int[] size = new int[2];
//PGraphics image;
Population pop;
double MAX_ERROR;
void setup() {
  //textSize(20);
  //fullScreen();
  size(360, 640);

  image = loadImage("/home/cornoblue/Pictures/captain_america_shield.jpg");
  image.resize(floor(image.width/1.3), floor(image.height/1.3));
  MAX_ERROR = image.width * image.height * (255 *3); 
  //image = createGraphics(100, 100);
  //image.beginDraw();
  //image.noStroke();
  //image.background(255);
  //image.fill(255, 100, 50);
  //image.ellipse(50, 50, 50, 50);
  //image.endDraw();
  size[0] = image.width;
  size[1] = image.height;
  pop = new Population(popSize);
}
void draw() {  
  pop.nextGeneration();
  gen++;
  //if (pop.prevScore != pop.bestEver) {
    saveFrame("results/best" + gen + ".png");
  //}
  show();
  pop.bestEverDNA.canvas.save("best.png");
}

void show() {
  background(255);
  image(image, 17, 0) ;
  pop.bestEverDNA.show(17, image.height); 
  fill(0);
  pushMatrix();
  translate(0, image.height - 30);
  text("Generation  : " + gen, 0, 20);
  text("Error       : " + pop.bestEver, 0, 40);
  text("Genes Length: " + pop.bestEverDNA.genes.size(), 0, 60);
  popMatrix();
  
  //text("Generation  : " + gen, 0, 20);
  //text("Error       : " + pop.bestEver, 0, 40);
  //text("Delta Error : " + (pop.prevScore - pop.bestEver), 0, 60);
  //text("Genes Length: " + pop.bestEverDNA.genes.size(), 0, 80);
  //text("Pop Size    : " + pop.popSize, 0, 100);

  //int index = 0;
  //for (int x : range(0, width, image.width)) {
  //  for (int y : range(image.height, height, image.height)) {
  //    pop.dnas[index].show(x, y);
  //    index++;
  //  }
  //}
}
int gen = 0;
