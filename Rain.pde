//Jeffrey Andersen

int numDrops = 2000;
int minRadius = 2, maxRadius = 8;
float gravity = 0.6;

Drop[] drops = new Drop[numDrops];
int maxSplashAge = 20; //experimentally determined to be decent
float dropSizeDecayFactor = 0.99; //experimentally determined to be decent

void setup() {
  size(800, 800, P2D); //specifying P2D was found to be faster than not
  for (int i = 0; i < drops.length; i++) {
    drops[i] = new Drop();
    for (int j = 0; j < 20 * int(sqrt(2 * height / gravity)); j++) { //simulate frames before the animation gets displayed to hide small initialization bugs (as well as starting the animation with splashing drops)
      drops[i].update();
    }
  }
  noStroke(); //future consideration: allow for customizing stroke color
}

void draw() {
  background(191, 223, 255);
  for (Drop d : drops) {
    d.update(); //call update() before show() to help hide small initialization bugs (as well as starting the animation with splashing drops)
    d.show();
  }
}
