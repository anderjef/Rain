import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Rain extends PApplet {

//started 09/12/2019
//inspiration: https://www.youtube.com/watch?v=KkyIDI6rQJI

Drop[] drops = new Drop[1024];

public void setup() {
  
  for (int i = 0; i < drops.length; ++i) {
    drops[i] = new Drop();
  }
}

public void draw() {
  background(191, 223, 255);
  for (int i = 0; i < drops.length; ++i) {
    drops[i].show();
    drops[i].update();
  }
}
class Drop {
  float x;
  float y;
  float r;
  float fallVelocity;
  float gravity = 0.4f;
  boolean splashMode;
  int splashAge;
  
  Drop() {
    x = random(width);
    y = random(-height, height);
    r = random(4, 10);
    fallVelocity = random(2, 4);
    splashAge = 0;
  }
  
  public void update() {
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
  
  public void show() {
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
  public void settings() {  size(800, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Rain" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
