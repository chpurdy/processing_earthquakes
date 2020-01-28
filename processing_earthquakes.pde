// https://processing.org/tutorials/data/
// https://en.wikipedia.org/wiki/Web_Mercator_projection

PImage worldImg;
Bubble[] bubbles;

void setup() {
  size(1028, 1024);

  // https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Web_maps_Mercator_projection_SW.jpg/1028px-Web_maps_Mercator_projection_SW.jpg
  worldImg = loadImage("web_mercator.jpg");
  background(worldImg);

  // https://earthquake.usgs.gov/earthquakes/feed/v1.0/csv.php
  // https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_week.csv

  loadData();
}

void loadData() {
  Table data = loadTable("all_week.csv", "header");
  bubbles = new Bubble[data.getRowCount()];
  for (int i = 0; i < data.getRowCount(); i++) {
    TableRow row = data.getRow(i); 
    float lat = row.getFloat("latitude");
    float lon = row.getFloat("longitude");
    float mag = row.getFloat("mag");
    String place = row.getString("place");
    lat = radians(lat);
    lon = radians(lon);
    float zoom = 2; // 256 * 2 * 2 = 1024 (zoom level = 2)

    // formulas from https://en.wikipedia.org/wiki/Web_Mercator_projection
    float x = (256 / (2 * PI)) * pow(2, zoom)*(lon + PI);
    float y = (256 / (2 * PI)) * pow(2, zoom)*(PI - log(tan(PI/4 + lat/2)));
    bubbles[i] = new Bubble(x, y, mag, place);
  }
}


void draw() {

  for (Bubble b : bubbles) {
    b.rollover(mouseX, mouseY);
    b.display();
  }
}
