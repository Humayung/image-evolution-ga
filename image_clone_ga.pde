DNA dna;
PImage target;
//PGraphics image;
import java.util.concurrent.TimeUnit;
int popSize = 80;
int[] size = new int[2];

int peakDeltaError = 0;

Population pop;
float MAX_ERROR;
long timeElapsed = 0;
void setup() {

  size(1000, 620);
  target = loadImage("reference.png");
  target.resize(floor(target.width/2), floor(target.height/2));
  target.loadPixels();
  MAX_ERROR = target.width * target.height * (255 *3); 
  size[0] = target.width;
  size[1] = target.height;
  pop = new Population(popSize);
}
void draw() {  
  long start = millis();
  pop.nextGeneration();
  displayGen();
  timeElapsed += millis() - start;
}

void nextGeneration() {
  pop.nextGeneration();
}


void displayGen() {
  background(0);
  fill(255);
  textSize(100);
  textAlign(LEFT, BOTTOM);
  //image(image, 0, 0) ;
  pop.bestEverDNA.show(0, 0);
  float percentage = pop.bestEver/MAX_ERROR * 100;
  percentage = floor(percentage * 1000) / 1000.0;
  text(percentage + "%", 10, target.height + 120);
  int cols = target.width/5;
  int rows = target.height/5;

  for (int i : range(0, target.width, cols)) {
    for (int j : range(0, target.height, rows)) {
      int index = i/cols + j/rows * target.width/cols;
      pushMatrix();
      translate(i + target.width, j);
      scale(1/5.0);
      pop.dnas[index].show(0, 0);
      popMatrix();
    }
  }
  fill(255);
  pushMatrix();
  textAlign(LEFT);
  textSize(15);
  translate(width - 250, target.height);
  text("Generation     : " + pop.gen, 0, 15);
  text("Error              : " + int(pop.bestEver), 0, 35);
  int deltaError = int(pop.prevError - pop.bestEver);
  if(deltaError > 10000000) deltaError = 0;
  if(deltaError > peakDeltaError && deltaError < 10000){
    peakDeltaError = deltaError;
  }
  
  text("Delta Error     : " + deltaError, 0, 55);
  text("Circles           : " + pop.bestEverDNA.genes.size(), 0, 75);
  text("Mutation Rate: " + pop.MUTATION_RATE *100 + "%", 0, 95);
  text("Time Elapsed : " + timeFormat(timeElapsed), 0, 115);
  popMatrix();

  saveFrame("results/best" + pop.gen + ".png");
  pop.bestEverDNA.showMutated(0, 0);
  pop.bestEverDNA.canvas.save("best.png");
}

String timeFormat(long millis) {
  long days = TimeUnit.MILLISECONDS.toDays(millis);
  millis -= TimeUnit.DAYS.toMillis(days);
  long hours = TimeUnit.MILLISECONDS.toHours(millis);
  millis -= TimeUnit.HOURS.toMillis(hours);
  long minutes = TimeUnit.MILLISECONDS.toMinutes(millis);
  millis -= TimeUnit.MINUTES.toMillis(minutes);
  long seconds = TimeUnit.MILLISECONDS.toSeconds(millis);

  String format = days + "d " + hours + "h "+ minutes + "m " + seconds + "s "; 
  return format;
}
