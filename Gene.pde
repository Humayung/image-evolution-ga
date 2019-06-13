class Gene {
  float x;
  float y;
  color c;
  float w;
  float h;
  float r;
  float alpha;
  int type = 0;
  Gene() {
    x = random(size[0]); 
    y = random(size[1]);
    type = floor(random(2));
    c = color(random(255), random(255), random(255));
    w = random(0.1, 20);
    h = random(0.1, 20);
    r = random(TWO_PI);
    alpha = random(255);
  }

  Gene(float x, float y, color c, float w, float h, float r, float alpha, int type) {
    this.x = x; 
    this.y = y;
    this.c = c;
    this.w = w;
    this.h = h;
    this.r = r;
    this.type = type;
    this.alpha = alpha;
  }

  void paint(PGraphics canvas) {
    canvas.fill(c, alpha);
    canvas.pushMatrix();
    canvas.translate(x,y);
    canvas.rotate(r);
    if (type == 0)
      canvas.rect(0, 0, w, h);
    else
      canvas.ellipse(0, 0, w, h);
    canvas.popMatrix();
  }

  //void mutate(int[] size) {
  //  int s = floor(random(3));
  //  switch(s) {      
  //  case 0:
  //    d = random(1, 20);
  //    break;
  //  case 1:
  //    x = random(size[0]);
  //    y = random(size[1]);
  //  case 2:
  //    c = color(random(255), random(255), random(255));
  //    break;
  //  }
  //}

  void mutate(int[] size) {
    int param = floor(random(6));
    switch(param) {      
    case 0:
      w = constrain(w + randomGaussian()*3, 0, 20);
      h = constrain(h + randomGaussian()*3, 0, 20);
      break;
    case 1:
      x = constrain(x + randomGaussian()*3, 0, size[0]);
      y = constrain(y + randomGaussian()*3, 0, size[1]);
    case 2:
      c = color(constrain(red(c) + randomGaussian() * 4, 0, 255), constrain(green(c) + randomGaussian()*4, 0, 255), constrain(blue(c) + randomGaussian()*4, 0, 255));
      break;
    case 3:
      type = floor(random(2));
      break;
    case 4:
      r = constrain(r + randomGaussian(), 0, TWO_PI);
      break;
    case 5:
      alpha = constrain(alpha + randomGaussian() * 3, 0, 255);
      break;
    }
  }

  Gene clone() {
    return new Gene(x, y, c, w, h,r, alpha,  type);
  }
} 
