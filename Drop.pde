//Jeffrey Andersen

class Drop {
  PVector pos; //position
  float r; //radius
  PVector v; //velocity
  int splashAge;
  
  Drop() {
    pos = new PVector(random(width), sq(random(sqrt(2 * height))) - height); //initially fill screen with drops (with height distributed according to statistical steady-state 2nd-power curve)
    //r = random(minRadius, maxRadius); //deprecated for not showing the initial frames of animation
    v = new PVector(0, gravity * sqrt((pos.y + random(1) * height) / gravity)); //velocity equals acceleration times time (which is derived by working backwards from randomized starting height (relative to ground), initial velocity, and acceleration); important to have despite simulating frames of animation before activating the display so as to keep drops from being reset closer in time to each other (if velocity were initialized to zero)
    splashAge = 0;
  }
  
  void update() {
    if (splashAge < maxSplashAge) {
      pos.y += v.y;
      v.y += gravity;
    }
    if (splashAge == 0) {
      if (pos.y > height) {
        pos.y = height;
        splashAge++;
        float splashAngle = random(PI / 2);
        v.set(v.y * cos(splashAngle), v.y * -sin(splashAngle));
        v.mult(random(0.8)); //0.8 here was experimentally determined to be decent; energy lost to collision with the ground (splash)
      }
    }
    else if (splashAge < maxSplashAge) {
      splashAge++;
      r *= dropSizeDecayFactor; //raindrops decay after splash
    }
    else {
      pos = new PVector(random(width), random(-height, -r));
      r = random(minRadius, maxRadius); //reset
      v.set(0, 0); //reset
      splashAge = 0; //reset
    }
  }
  
  void show() {
    fill(0, 127, 255, 255 - splashAge * (255 / v.y)); //raindrops decay after splash //future consideration: allow for customizing fill color
    if (splashAge > 0) {
      circle(pos.x - v.x * splashAge + (pos.x - v.x * splashAge < 0 ? width : 0), pos.y, r); //splashes wrap around the edges
      circle(pos.x + v.x * splashAge - (pos.x + v.x * splashAge > width ? width : 0), pos.y, r); //splashes wrap around the edges
    }
    else {
      circle(pos.x, pos.y, 2 * r);
    }
  }
}
