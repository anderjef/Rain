// Jeffrey Andersen
//started 09/12/2019
//inspiration: https://www.youtube.com/watch?v=KkyIDI6rQJI

Drop[] drops = new Drop[1024];

void setup() {
  size(800, 800);
  for (int i = 0; i < drops.length; ++i) {
    drops[i] = new Drop();
  }
}

void draw() {
  background(191, 223, 255);
  for (int i = 0; i < drops.length; ++i) {
    drops[i].show();
    drops[i].update();
  }
}
