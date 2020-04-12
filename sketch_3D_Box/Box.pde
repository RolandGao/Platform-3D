class Box {
  int x, y, z;
  color c;

  public Box(int xx, int yy, int zz) {
    x = xx+gs/2;
    y = -(yy+gs/2);
    z = -(zz+gs/2);
    c = color(random(255), random(255), random(255));
    drawBox();
  }

  void drawBox() {
    fill(c);
    pushMatrix();
    translate(x, y, z);
    box(gs);
    popMatrix();
  }

  boolean isCollide() {
    for (Bullet b : bullets) {
      float r = b.getRadius() + gs/2;
      //float r = gs/2;
      if (b.getX() > x-r && b.getX() < x+r
        && b.getY() > y-r && b.getY() < y+r
        && b.getZ() > z-r && b.getZ() < z+r) {
        b.setTime(500);
        deleteBullets();
        return true;
      }
    }
    return false;
  }

  boolean isOuterBox2() {
    boolean b1 = false, b2 = false, b3 = false, b4 = false, b5 = false;
    for (Box b : boxes) {
      if (!b1 && b.getX() == x-gs && b.getY() == y && b.getZ() == z)
        b1 = true;
      else if (!b2 && b.getX() == x+gs && b.getY() == y && b.getZ() == z)
        b2 = true;
      else if (!b3 && b.getX() == x && b.getY() == y-gs && b.getZ() == z)
        b3 = true;
      else if (!b4 && b.getX() == x && b.getY() == y && b.getZ() == z-gs)
        b4 = true;
      else if (!b5 && b.getX() == x && b.getY() == y && b.getZ() == z+gs)
        b5 = true;
    }
    if (b1 && b2 && b3 && b4 && b5)
      return false;
    return true;
  }
  
  boolean isOuterBox(){
    if (hasBox(x-gs, y, z) && hasBox(x+gs, y, z) && hasBox(x, y-gs, z)  && hasBox(x, y, z-gs) && hasBox(x, y, z+gs))
     return false;
     return true;
  }

  int getX() {
    return x;
  }
  int getY() {
    return y;
  }
  int getZ() {
    return z;
  }
  boolean hasBox(int x, int y, int z) {
    for (Box b : boxes) {
      if (b.getX() == x && b.getY() == y && b.getZ() == z)
        return true;
    }
    return false;
  }
}

class Terrain {

  Terrain() {
    boxes = new ArrayList<Box>();
    outerBoxes = new ArrayList<Box>();
    initBoxes();
    initOuterBoxes();
  }
  void drawBoxes() {
    for (Box b : outerBoxes) {
      int x = (int)(b.getX()-px);
      int y = (int)(b.getY()-py);
      int z = (int)(b.getZ()-pz);
      float dis = dist(0, 0, 0, x, y, z);
      if (dis < 20*gs)
        b.drawBox();
    }
  }
  void initBoxes() {
    float f = 0.03;
    int size = 100;
    int [][]world = new int[size][size];
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        world[i][j] = (int)(noise(i*f, j*f) * 10);
        for (int k = 0; k < world[i][j]; k++) {
          Box b = new Box(gs*i, gs*k, gs*j);
          boxes.add(b);
        }
      }
    }
  }
  void initOuterBoxes() {
    for (Box b : boxes) {
      if (b.isOuterBox())
        outerBoxes.add(b);
    }
  }
  void deleteBoxes() {
    for (int i = 0; i < outerBoxes.size(); i++) {
      Box box = outerBoxes.get(i);
      int x = box.getX();
      int y = box.getY();
      int z = box.getZ();
      if (box.isCollide()) {
        boxes.remove(boxes.indexOf(box));
        outerBoxes.remove(i);
        for (Box b : boxes) {
          if (abs(b.getX()-x) + abs(b.getY()-y) + abs(b.getZ() - z) == gs && outerBoxes.indexOf(b) == -1)
            outerBoxes.add(b);
        }
      }
    }
  }
}

void drawRoom1() {
  rectMode(CENTER);
  //fill(100);
  pushMatrix();
  translate(500, -500, 0);
  rect(0, 0, 1000, 1000);
  popMatrix();
  pushMatrix();
  translate(500, -500, -1000);
  rect(0, 0, 1000, 1000);
  popMatrix();
  //fill(255);
}

void drawRoom() {
  fill(100);
  pushMatrix();
  translate(500, -500, -500);
  box(2000);
  popMatrix();
  fill(255);
}