// Bubble class adapted from "Learning Processing" by Daniel Shiffman p. 395

class Bubble {
  float x, y, mag;
  color c;
  String name;

  boolean over = false;

  Bubble(float _x, float _y, float _mag, String _name) {
    x = _x;
    y = _y;
    mag = _mag;
    name = _name;

    if (mag < 2)
      c = color(0, 255, 0);
    else if (mag < 5)
      c = color(255, 255, 0);
    else
      c = color(255, 0, 0);
  }

  // check if mouse is over the bubble
  void rollover(float px, float py) {
    float d = dist(px, py, x, y);
    if (d < mag / 2) {
      over = true;
    } else {
      over = false;
    }
  }

  void display() {
    //stroke(0);
    map(mag, 0, 9, 1, 20);
    fill(c);
    circle(x, y, mag);
    if (over) {
      fill(0);
      textAlign(CENTER);
      text(name, x, y + mag/2+20);
    }
  }
}
