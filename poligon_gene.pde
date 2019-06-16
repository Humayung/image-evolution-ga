//class Gene {
//  ArrayList<Vertex> vertices;
//  final float ADD_VERT_CHANCE = 0.2;
//  final float REM_VERT_CHANCE = 0.2;
//  final int MAX_VERT = MAX_POLIGON;
//  float[] data;
//  Gene() {
//    vertices = new ArrayList<Vertex>();

//    data = new float[4];
//    data[0] = random(size[0]);
//    data[1] = random(size[1]);
//    data[2] = random(1, 30);    
//    data[3] = color(random(255), random(255), random(255), random(255));

//    for (int i : range(random(3, MAX_VERT))) {
//      vertices.add(new Vertex(random(-data[2], data[2]), random(-data[2], data[2])));
//    }
//  }

//  Gene(float[] data, ArrayList<Vertex> vertices ) {
//    this.data = data.clone();
//    this.vertices = new ArrayList<Vertex>();
//    for (Vertex v : vertices) {
//      this.vertices.add(v.clone());
//    }
//  }


//  void paint(PGraphics canvas) {
//    canvas.noStroke();
//    canvas.pushMatrix();
//    canvas.translate(data[0], data[1]);
//    canvas.beginShape();
//    canvas.fill(floor(data[3]));

//    for (Vertex v : vertices) {
//      canvas.vertex(v.x, v.y);
//    }
//    canvas.endShape(CLOSE);
//    canvas.popMatrix();
//  }

//  void mutate() {
//    int mutateSelect = floor(random(4));
//    switch(mutateSelect) {
//    case  0:
//      data[0] = constrain(data[0] + randomGaussian() * 20, 0, size[0]);
//      data[1] = constrain(data[1] + randomGaussian() * 20, 0, size[1]);
//      break;
//    case  1:
//      data[2] = constrain(data[2] + randomGaussian() * 5, 1, 30);
//      break;
//    case 2:
//      for (Vertex v : vertices) {
//        v.add(randomGaussian() * 10, randomGaussian() * 10);
//        v.bound(-data[2], data[2]);
//      }
//      break;

//    case 3:
//      int red = floor(constrain(red(floor(data[3])) + randomGaussian() * 10, 0, 255));
//      int green = floor(constrain(green(floor(data[3])) + randomGaussian() * 10, 0, 255));
//      int blue  = floor(constrain(blue(floor(data[3])) + randomGaussian() * 10, 0, 255));
//      int alpha = int(constrain(alpha(floor(data[3])) + randomGaussian() * 10, 0, 255));
//      data[3] = color(red, green, blue, alpha);
//      break;
//    }

//    if (vertices.size() < MAX_VERT && random(1) < ADD_VERT_CHANCE) {
//      vertices.add(new Vertex(random(-data[2], data[2]), random(-data[2], data[2])));
//    }

//    if (vertices.size() > 0 && random(1) < REM_VERT_CHANCE) {
//      int i = floor(random(vertices.size()));
//      vertices.remove(i);
//    }
//  }

//  void shrinkifyData() {
//    for (int i = 0; i < data.length; i++) {
//      data[i] = floor(data[i] * 100) / 100.0;
//    }
    
//    for(Vertex v : vertices){
//      v.shrinkify();
//    }
//  }


//  Gene clone() {
//    return new Gene(data, vertices);
//  }
//}

//class Vertex {
//  float x;
//  float y;
//  Vertex(float x, float y) {
//    this.x = x;
//    this.y = y;
//  }

//  Vertex clone() {
//    return new Vertex(this.x, this.y);
//  }

//  void add(float ax, float ay) {
//    x += ax;
//    y += ay;
//  }

//  void shrinkify(){
//    x =  floor(x * 100) / 100.0;
//    y =  floor(y * 100) / 100.0;
//  }
  
//  void bound(float low, float high) {
//    x = constrain(x, low, high);
//    y = constrain(y, low, high);
//  }
//}
