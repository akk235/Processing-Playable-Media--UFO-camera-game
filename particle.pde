class Particle {
  PVector position;
  PVector velocity;
  float life;
  float size;

  Particle(PVector position) {
    this.position = position.copy();
    this.velocity = PVector.random3D().mult(random(1, 4));
    this.life = 255;
    this.size = random(5, 15);
  }

  void update() {
    position.add(velocity);
    life -= 4;
    size *= 0.95;
  }

  void display() {
    pushMatrix();
    translate(position.x, position.y, position.z);
    fill(255, 0, 0, life);
    box(size);
    popMatrix();
  }

  boolean isDead() {
    return life < 0 || size < 1;
  }
}
