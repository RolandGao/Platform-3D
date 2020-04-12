class Bullet{
  float x,y,z;
  float vx, vy, vz;
  int t;
  float radius;
  color c;
  
  public Bullet(float xx, float yy, float zz, float vxx, float vyy, float vzz){
    x = xx;
    y = yy;
    z = zz;
    vx = vxx;
    vy = vyy-5;
    vz = vzz;
    t = 0;
    radius = gs/4;
    c = color(random(255), random(255), random(255));
    drawBullet();
  }
  
  void move(){
    float accel = 0.1;
    x += vx;
    y += vy;
    z += vz;
    vy += accel;
    t++;
  }
  void drawBullet(){
    fill(c);
    pushMatrix();
    translate(x,y,z);
    sphere(radius);
    popMatrix();
  }
  
  boolean outOfBounds(){
    if (t > 400)
      return true;
    return false;
  }
  float getX(){return x;}
  float getY(){return y;}
  float getZ(){return z;}
  float getRadius(){return radius;}
  void setTime(int time){t = time;}
  
}

void initBullets(){
  float v = 40;
  float vx = v*cos(phi)*cos(theta);
  float vy = - v*sin(phi);
  float vz = - v*cos(phi)*sin(theta);
  Bullet b = new Bullet(px,py,pz,vx,vy,vz);
  bullets.add(b);
}

void drawBullets(){
  for (Bullet b : bullets){
    b.move();
    b.drawBullet();
  }
  deleteBullets();
}

void deleteBullets(){
  Iterator<Bullet> itr = bullets.iterator();
  while (itr.hasNext()){
    if(itr.next().outOfBounds()){
      itr.remove();
    }
  }
}