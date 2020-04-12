import java.util.Iterator;

boolean w, a, s, d, f;
float px, py, pz, dx, dy, dz;
float r;
float vx = 0, vy = 0, vz = 0;
float theta, phi;
final int gs = 100;
//Box [][][] boxs = new Box[50][10][50];
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList <Box> boxes;
ArrayList <Box> outerBoxes;
Terrain terrain;

void setup() {
  size(960, 540, P3D);
  //fullScreen(P3D);
  theta = PI/2;
  phi = 0;
  r = (height/2) / tan(PI/6);
  px = 2000;
  py = -1000;
  pz = -2000;
  dx = px + r*cos(phi)*cos(theta);
  dy = py - r*sin(phi);
  dz = pz - r*cos(phi)*sin(theta);
  terrain = new Terrain();
  frameRate(30);
}

void draw() {
  background(0);
  //ambientLight(188, 202, 82);
  //directionalLight(0, 255, 0, 0, 1, 0);
  //spotLight(255, 0, 0, width/2, height/2, 400, 0, 0, -1, PI/4, 2);
  act();
  pan();
  dx = px + r*cos(phi)*cos(theta);
  dy = py - r*sin(phi);
  dz = pz - r*cos(phi)*sin(theta);
  camera(px, py, pz, dx, dy, dz, 0, 1, 0);
  // drawRoom();
  terrain.drawBoxes();
  drawBullets();
  terrain.deleteBoxes();
  //println(frameRate);
  println(boxes.size());
  println(outerBoxes.size());
}

void pan() {
  float dangle = 0.0001;
  float dx = mouseX-width/2;
  float dy = mouseY-height/2;
  float dist = dist(width/2, height/2, mouseX, mouseY);
  if (dist > 200) {
    theta -= dx * dangle;
    phi -= dy * dangle;
  }
}



void keyPressed() {
  if (key == 'W' || key == 'w')
    w = true;
  if (key == 'A' || key == 'a')
    a = true;
  if (key == 'S' || key == 's')
    s = true;
  if (key == 'D' || key == 'd')
    d = true;
  if (key == 'F' || key == 'f')
    f = true;
}

void keyReleased() {
  if (key == 'W' || key == 'w')
    w = false;
  if (key == 'A' || key == 'a')
    a = false;
  if (key == 'S' || key == 's')
    s = false;
  if (key == 'D' || key == 'd')
    d = false;
  if (key == 'F' || key == 'f')
    f = false;
}

void mouseClicked() {
  initBullets();
}