class Player {
  PVector position;
  PVector velocity;
  float size;
  //declare a 3d model formula for player 
  PShape model;


  Player() {
    position = new PVector(0, 0, 0);
    velocity = new PVector(0, 0, 0);
    model = loadShape("UFO.obj");
    size = 80;
  }

  void update(Capture video) {
    position.add(velocity);
    video.loadPixels();

    float sumX = 0.0;
    float sumY = 0.0;
    float count = 0.0;
//analyse every pixels from its rgb value, than mutply by 3, to get threshold,
//plus check their brightness to identfy where is space , where is object,
//and by which area the object get the most to identify moving direction
    for (int y = 0; y < video.height; y += 10) {
      for (int x = 0; x < video.width; x += 10) {
        int loc = x + y * video.width;
        int currentColor = video.pixels[loc];
        float r = (currentColor >> 16) & 0xff;
        float g = (currentColor >> 8) & 0xff;
        float b = currentColor & 0xff;
        float brightness = (r + g + b) / 3.0;

        if (brightness > threshold) {
          sumX += x;
          sumY += y;
          count += 1.0;
        }
      }
    }

    if (count > 0.0) {
      float averageX = sumX / count;
      float averageY = sumY / count;
      float newX = map(averageX, 0, video.width, -width/2, width/2);
      float newY = map(averageY, 0, video.height, -height/2, height/2);
      position.x = newX;
      position.y = newY;
    }
  }

  void display() {
    pushMatrix();
    //follow with handleinput function and translate player's location
    translate(position.x, position.y, 0);
    fill(0, 0, 255);
    shape(model);
    popMatrix();
  }

  

  boolean reachedTarget(Target target) {
    return PVector.dist(position, target.position) <= size/2 + target.size/2;
  }
}
