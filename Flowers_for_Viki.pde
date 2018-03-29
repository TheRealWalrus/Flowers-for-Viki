import java.util.*;

ArrayList<Particle> flowers;

void setup() {
  size(640, 360, P2D);
  flowers = new ArrayList();
}

void draw() {
  background(255);
  PVector spawnLoc = new PVector(mouseX, mouseY);
  flowers.add(new Particle(spawnLoc));

  Iterator<Particle> it = flowers.iterator();
  //Using an Iterator object instead of counting with int i
  while (it.hasNext()) {
    Particle p = it.next();
    p.run();
    if (p.isDead()) {
      it.remove();
    }
  }
  //println(flowers.size());
}



class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector gravity;
  PVector wind;
  float lifespan;
  float angle;
  float angVel;

  Particle(PVector l) {
    //For demonstration purposes we assign the Particle an initial velocity and constant acceleration.
    acceleration = new PVector();
    wind = new PVector();
    gravity = new PVector(0, 0.05);
    velocity = new PVector(random(-1, 1), random(-2, 0));
    location = l.copy();
    angle = random(2 * PI);
    angVel = random(0.05, 0.15);
  }


  void run() {
    acceleration.mult(0);
    applyForce(gravity);
    applyForce(wind);
    update();
    display();
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 2.0;
    angle += angVel;
  }

  void display() {
    pushMatrix();
    translate(location.x, location.y);
    rotate(angle);
    stroke(255, 0, 0);
    noFill();
    rectMode(CENTER);
    //rect(0, 0, 16, 32);

    color flowerGreen = color(60, 200, 80);
    color flowerPetal = color(255, 0, 0);
    color flowerCenter = color(255, 255, 0);

    stroke(flowerGreen);
    line(0, 16, 0, -8);

    stroke(0);
    fill(flowerPetal);
    ellipse(-4, -12, 8, 8);
    ellipse(4, -12, 8, 8);
    ellipse(-4, -4, 8, 8);
    ellipse(4, -4, 8, 8);

    fill(flowerCenter);
    ellipse(0, -8, 8, 8);

    fill(flowerGreen);
    ellipse(4, 6, 8, 4);

    popMatrix();
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  //Is the Particle alive or dead?
  boolean isDead() {
    if (location.y > height + 32) {
      //println("done");
      return true;
    } else {
      return false;
    }
  }
}

/* NOTE

You can also declare an iterator in a for-loop like this:

for (Iterator<String> i = stringList.iterator(); i.hasNext();) { 
  if (i.next().equals("Jack")) { 
    i.remove();
  }
}

It's the same thing as the while-loop, but the scope of the iterator variable is only in the for-loop curly braces

*/