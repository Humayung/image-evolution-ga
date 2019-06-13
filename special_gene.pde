class Gene {
  ArrayList<Vertex> vertices;
  final float ADD_VERT_CHANCE = 0.2;
  final float REM_VERT_CHANCE = 0.2;
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
    switch(mutateSelect) {
    case  0:
      data[0] = constrain(data[0] + randomGaussian() * 5, 0, size[0]);
      break;
    case  1:
      data[1] = constrain(data[1] + randomGaussian() * 5, 0, size[1]);
      break;
    case  2:
      data[2] = constrain(data[2] + randomGaussian() * 2, 1, 30);
      break;
    }
    int red = floor(constrain(red(floor(data[3])) + randomGaussian() * 3, 0, 255));
    int green = floor(constrain(green(floor(data[3])) + randomGaussian() * 3, 0, 255));
    int blue  = floor(constrain(blue(floor(data[3])) + randomGaussian() * 3, 0, 255));
    data[3] = color(red, green, blue);

    for (Vertex v : vertices) {
      v.x += randomGaussian() * 5;
      v.y += randomGaussian() * 5;
    }

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

  Vertex clone() {
    return new Vertex(this.x, this.y);
  }
}
