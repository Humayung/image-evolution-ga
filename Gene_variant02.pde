//class Gene {

//  float[] data = new float[4];
//  int type = 0;
//  Gene() {
//    data[0] = random(size[0]); 
//    data[1] = random(size[1]);

//    data[2] = color(random(255), random(255), random(255), random(255));
//    data[3] = random(1, 40);
//  }

//  Gene(float[] data) {
//    this.data = data.clone();
//  }

//  void paint(PGraphics canvas) {
//    canvas.fill(int(data[2]));
//    canvas.ellipse(data[0], data[1], data[3], data[3]);
//  }

//  void mutate() {
//    int param = floor(random(3));
//    switch(param) {      
//    case 0:
//      float shift = ((size[0] * size[1])/5000);
//      data[0] = constrain(data[0] + randomGaussian()*shift, 0, size[0]);
//      data[1] = constrain(data[1] + randomGaussian()*shift, 0, size[1]);
//      break;
//    case 1:      
//      int c = int(data[2]);
//      int red = int(constrain(red(c) + randomGaussian() * 20, 0, 255));
//      int green = int(constrain(green(c) + randomGaussian() * 20, 0, 255));
//      int blue = int(constrain(blue(c) + randomGaussian() * 20, 0, 255));
//      int alpha = int(constrain(alpha(c) + randomGaussian() * 20, 0, 255));
//      data[2] = color(red, green, blue, alpha);
//    case 2:
//      shift = ((size[0] * size[1])/11000);
//      data[3] = constrain(data[3] + randomGaussian()*shift, 1, 40);
//      break;
//    }
//  }


//  Gene clone() {
//    return new Gene(this.data);
//  }
//} 
