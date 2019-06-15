//class Gene {
//  float[] data = new float[6];
//  Gene() {
//    data[0] = random(size[0]); 
//    data[1] = random(size[1]);
//    data[2] = random(size[0]); 
//    data[3] = random(size[1]);
//    data[4] = color(random(255), random(255), random(255), random(255));
//    data[5] = random(1, 5);
//  }

//  Gene(float[] data) {
//    this.data = data.clone();
//  }

//  void paint(PGraphics canvas) {
//    canvas.stroke(int(data[4]));
//    //canvas.strokeWeight(data[5]);
//    canvas.line(data[0], data[1], data[2], data[3]);
//  }

//  void mutate() {
//    int param = floor(random(4));
//    switch(param) {      
//    case 0:
//      data[0] = constrain(data[0] + randomGaussian()*3, 0, size[0]);
//      data[1] = constrain(data[1] + randomGaussian()*3, 0, size[1]);
//      break;
//    case 1:
//      data[2] = constrain(data[0] + randomGaussian()*3, 0, size[0]);
//      data[3] = constrain(data[1] + randomGaussian()*3, 0, size[1]);
//    case 2:      
//      int c = int(data[2]);
//      int red = int(constrain(red(c) + randomGaussian() * 4, 0, 255));
//      int green = int(constrain(green(c) + randomGaussian() * 4, 0, 255));
//      int blue = int(constrain(blue(c) + randomGaussian() * 4, 0, 255));
//      int alpha = int(constrain(alpha(c) + randomGaussian() * 4, 0, 255));
//      data[4] = color(red, green, blue, alpha);
//    case 3:
//      data[5] = constrain(data[5] + randomGaussian(), 1, 5);
//      break;
//    }
//  }


//  Gene clone() {
//    return new Gene(this.data);
//  }
//} 
