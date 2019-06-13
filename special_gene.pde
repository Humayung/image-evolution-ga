class Gene {
  ArrayList<Vertex> vertices;
  final float ADD_VERT_CHANCE = 0.1;
  final float REM_VERT_CHANCE = 0.1;
  final int MAX_VERT = 10;
  float[] data;
  Gene() {
    vertices = new ArrayList<Vertex>();
    
    data = new float[4];
    data[0] = random(size[0]);
    data[1] = random(size[1]);
    data[2] = random(1, 40);    
    data[3] = color(random(255), random(255), random(255), random(255));

    for (int i : range(random(3, MAX_VERT))) {
      vertices.add(new Vertex(random(-data[2], data[2]), random(-data[2], data[2])));
    }
  }

  Gene(float[] data, ArrayList<Vertex> vertices ) {
    this.data = data.clone();
    this.vertices = new ArrayList<Vertex>();
    for (Vertex v : vertices) {
      this.vertices.add(v.clone());
    }
  }


  void paint(PGraphics canvas) {
    canvas.noStroke();
    canvas.pushMatrix();
    canvas.translate(data[0], data[1]);
    canvas.beginShape();
    canvas.fill(floor(data[3]));
   
    for (Vertex v : vertices) {
      canvas.vertex(v.x, v.y);
    }
    canvas.endShape(CLOSE);
    canvas.popMatrix();
  }

  void mutate() {
    int mutateSelect = floor(random(3));
    data[mutateSelect] += randomGaussian() * 5;
    int red = floor(constrain(red(floor(data[3])) + randomGaussian() * 4, 0, 255));
    int green = floor(constrain(green(floor(data[3])) + randomGaussian() * 4, 0, 255));
    int blue  = floor(constrain(blue(floor(data[3])) + randomGaussian() * 4, 0, 255));
    data[3] = color(red, green, blue);

    int vertIndex = floor(random(vertices.size()));
    vertices.get(vertIndex).x += randomGaussian() * 2;
    vertices.get(vertIndex).y += randomGaussian() * 2;

    if (vertices.size() < MAX_VERT && random(1) < ADD_VERT_CHANCE) {
      vertices.add(new Vertex(random(-data[2], data[2]), random(-data[2], data[2])));
    }

    if (vertices.size() > 0 && random(1) < REM_VERT_CHANCE) {
      int i = floor(random(vertices.size()));
      vertices.remove(i);
    }
  }

  

  Gene clone() {
    return new Gene(data, vertices);
  }
}

class Vertex {
    float x;
    float y;
    Vertex(float x, float y) {
      this.x = x;
      this.y = y;
    }
    
    Vertex clone(){
      return new Vertex(this.x, this.y);
    }
  }
