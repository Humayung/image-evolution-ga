DNA dna;
PImage image;
void setup() {
  fullScreen();

  image = loadImage("/home/cornoblue/Pictures/b.jpeg");
  image.resize(100, 100);
  dna = new DNA(image.width, image.height);
}

void draw() {
  background(0);
  image(image, 0, 0) ;
  dna.show(image.width, 0);
  text(frameRate, width/2, height/2);
  text(dna.error, width/2, height/2+10);
}

void keyPressed() {
  dna.mutate();
  dna.calcErr(image);
  println(dna.error);
}
