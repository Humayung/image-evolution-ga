DNA dna;
int w;
int h;
PImage image;
Population pop;
void setup() {
  fullScreen();

  image = loadImage("/home/cornoblue/Pictures/b.jpeg");
  image.resize(150, 150);
  w = image.width;
  h = image.height;
  int size = (width/w) * (height/h);
  pop = new Population(size);
  println("Best: " + pop.bestDna().error);
  println("Worse: " + pop.worseDna().error);
}

void draw() {
  background(0);
  image(image, 0, 0) ;
  text(frameRate, width/2, height/2);
  int index = 0;
  //translate(0, 200);
  for (int x : range(0, width, w)) {
    for (int y : range(0, height, h)) {
      if (index > 0) {
        pop.dnas[index].show(x, y);
      }
      index++;
    }
  }
}
