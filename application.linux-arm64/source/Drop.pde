class Drop {
  float x;
  float y;
  float r;
  float fallVelocity;
  float gravity = 0.4;
  boolean splashMode;
  int splashAge;
  
  Drop() {
    x = random(width);
    y = random(-height, height);
    r = random(4, 10);
    fallVelocity = random(2, 4);
    splashAge = 0;
  }
  
  void update() {
    if (splashAge == 0) {
      y += fallVelocity;
      fallVelocity += gravity;
      if (y > height + r / 2) {
        y = height + r / 2;
        splashAge++;
        fallVelocity += random(32);
      }
    }
    else if (splashAge < fallVelocity / 2) {
      y -= fallVelocity / 4 - splashAge;
      splashAge++;
    }
    else {
      x = random(width);
      y = random(-height / 2, 0);
      r = random(4, 10);
      fallVelocity = random(0, 8);
      splashAge = 0;
    }
  }
  
  void show() {
    noStroke();
    if (splashAge > 0) {
      fill(0, 127, 255, 256 - 256 / fallVelocity * splashAge);
      ellipse(x - 3 * splashAge, y, r / 2, r / 2);
      ellipse(x + 3 * splashAge, y, r / 2, r / 2);
    }
    else {
      fill(0, 127, 255);
      ellipse(x, y, r, r);
    }
  }
}
