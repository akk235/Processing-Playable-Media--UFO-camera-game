class Bomb {
  PVector position;
  float bombSize = 50;
  float size;
PShape  bomb;
  Bomb() {
    bomb = loadShape("bomb2.obj");
    position = new PVector(0, 0, 0);
    size = 100;
    
    refreshPosition();
  }

//set a boolean to check wheteher the distance between player cube and the bomb is 
//smaller than the distance
  boolean checkCollision(PVector otherPosition, float otherSize) {
    float distance = position.dist(otherPosition);
    if (distance < (size/2 + otherSize/2)) {
      return true;
    }
    return false;
  }
//show the appearnce of it
  void display() {
    pushMatrix();
    translate(position.x, position.y, position.z);
    noStroke();
    fill(0, 0, 0);
    shape(bomb);
    popMatrix();
  }//to let it shows within the screen properly
  void refreshPosition() {
    position.x = random(-width/2 + size/2, width/2 - size/2);
    position.y = 0;
    position.z = random(-height/2 + size/2, height/2 - size/2);
  }
}
