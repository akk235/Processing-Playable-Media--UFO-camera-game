import processing.core.PImage;
import processing.core.PVector;
import processing.video.*;


Player player;
Target target;
Capture video;
//the larger the threshold , larger sentivity
float threshold = 70.0;
//for exploision effect
ArrayList<Particle> particles;
boolean exploding = false;
int score = 0;
int maxScore = 10;
boolean gameOver = false;
Bomb bomb;


// Add a new variable for the background image
PImage backgroundImage;

void setup() {
  size(1000, 1000, P3D);
  player = new Player();
  target = new Target();
  particles = new ArrayList<Particle>();
  bomb = new Bomb();
  video = new Capture(this, width, height, 30);
  video.start();
  


  // Load the background image from a file
  backgroundImage = loadImage("pxArt.png");

  // Scale the background image to the canvas size
  backgroundImage.resize(width, height);
}

void draw() {
  if (video.available()) {
    video.read();
    background(backgroundImage);
    translate(width/2, height/2);
    //roatate the appearnce of cube
    image(video,0,0);
    rotateX(0.5);
    rotateY(0.5);
        

    lights();
    
//constructor of player to update the movement
    player.update(video);
    //show the player
    player.display();
    // show bomb and target
    bomb.display();
    target.display();
//when player touched target, score +1 , and if over 12 ,then win,restart,refresh postion of all things
    if (player.reachedTarget(target)) {
      if (!exploding) {
        createExplosion(target.position);
        score++;
        if (score >= maxScore) {
          gameOver = true;
        }
        exploding = true;
        bomb.refreshPosition();
      }
    }

//if player touched target , trigger expolition effect immediately
    updateParticles();
    if (bomb.checkCollision(player.position, player.size/2)) {
      gameOver = true;
    }

//the score system , UI
    displayHUD();
  } else {
    // displayGameOverScreen();
  }
}
//CLICK R to restart
void keyPressed() {
  if (key == 'r' || key == 'R') 
    restartGame();
  } 

  


// Array of cube came when explosion, then faded out
void createExplosion(PVector position) {
  int numParticles = 50;
  for (int i = 0; i < numParticles; i++) {
    particles.add(new Particle(position));
  }
}

void updateParticles() {
  for (int i = particles.size() - 1; i >= 0; i--) {
    Particle p = particles.get(i);
    p.update();
    p.display();
    if (p.isDead()) {
      particles.remove(i);
    }
  }

  if (exploding && particles.isEmpty()) {
    target.resetPosition();
    exploding = false;
  }
}
//ui
void displayHUD() {
  camera();
  textAlign(LEFT, TOP);
  textSize(32);
  fill(255);
  text("Score: " + score, 20, 20);
}
//gaameover screen
void displayGameOverScreen() {
  background(0);
  textAlign(CENTER, CENTER);
  textSize(48);
  fill(255);
  text("GAME OVER", width/2, height/2);
  textSize(24);
  text("Press 'R' to restart", width/2, height/2 + 50);
}

void restartGame() {
  gameOver = false;
  score = 0;
  target.resetPosition();
  bomb.refreshPosition();
}
