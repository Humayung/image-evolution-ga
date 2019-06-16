class Gene {

  float[] data = new float[7];
  int type = 0;
  Gene() {
    data[0] = random(size[0]); 
    data[1] = random(size[1]);

    data[2] = color(random(255), random(255), random(255), random(255));
    data[3] = random(1, 40);
    data[4] = random(1, 40);

    data[5] = random(TWO_PI);
    data[6] = floor(random(2));
  }

  Gene(float[] data) {
    this.data = data.clone();
  }

  void paint(PGraphics canvas) {
    canvas.fill(int(data[2]));
    canvas.pushMatrix();
    canvas.translate(data[0], data[1]);
    canvas.rotate(data[5]);
    if (int(data[6]) == 0)
      canvas.rect(0, 0, data[3], data[4]);
    else
      canvas.ellipse(0, 0, data[3], data[4]);
    canvas.popMatrix();
  }

  void mutate() {
    int param = floor(random(5));
    float shift;
    switch(param) {      
    case 0:
      shift = 50;
      data[0] = constrain(data[0] + randomGaussian()*shift, 0, size[0]);
      data[1] = constrain(data[1] + randomGaussian()*shift, 0, size[1]);
      break;
    case 1:      
      int c = int(data[2]);
      int red = int(constrain(red(c) + randomGaussian() * 20, 0, 255));
      int green = int(constrain(green(c) + randomGaussian() * 20, 0, 255));
      int blue = int(constrain(blue(c) + randomGaussian() * 20, 0, 255));
      int alpha = int(constrain(alpha(c) + randomGaussian() * 20, 0, 255));
      data[2] = color(red, green, blue, alpha);
    case 2:
      shift = 10;
      data[3] = constrain(data[3] + randomGaussian()*shift, 1, 40);
      data[4] = constrain(data[4] + randomGaussian()*shift, 1, 40);
      break;
    case 3:
      data[6] = floor(random(2));
      break;
    case 4:
      data[5] = constrain(data[5] + randomGaussian(), 0, TWO_PI);
      break;
    }
  }


  Gene clone() {
    return new Gene(this.data);
  }
} 
