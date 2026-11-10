class Target {
  PVector position;
  float size;

  Target() {
    position = new PVector(0, 0, 0);
    size = 50;
    resetPosition();
  }

  void display() {
    pushMatrix();
    translate(position.x, position.y, position.z);
    fill(255, 0, 0);
    box(size);
    popMatrix();
  }

  void resetPosition() {
    position.x = random(-width/2 + size/2, width/2 - size/2);
    position.y = 0;
    position.z = random(-height/2 + size/2, height/2 - size/2);
  }
}
