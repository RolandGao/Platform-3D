void act() {
  float v = 10;
  vx = 0; vz = 0;
  float accel = 0.5;
  float vcos = v*cos(theta);
  float vsin = v*sin(theta);
  if (a) {
    vx -= vsin;
    vx -= vsin;
    vz -= vcos;
    vz -= vcos;
  }
  if (d) {
    vx += vsin;
    vx += vsin;
    vz += vcos;
    vz += vcos;
  }
  if (w) {
    vx += vcos;
    vx += vcos;
    vz -= vsin;
    vz -= vsin;
  }
  if (s) {
    vx -= vcos;
    vx -= vcos;
    vz += vsin;
    vz += vsin;
  }
  if (isTouchingGround()) {
    if (f)
      vy = -v;
    else
      vy = 0;
  } else {
    vy += accel;
  }
/*  if (isTouchingCeil()){
    vy = 0;
  }
  */
  px += vx;
  if (isTouchingAround())
    px -= vx;
  dx += vx;
  py += vy;
  if (isTouchingAround())
    py -= vy;
  dy += vy;
  pz += vz;
  if (isTouchingAround())
    pz -= vz;
  dz += vz;
  
}

boolean isTouchingGround() {
  for (Box b : outerBoxes) {
    if (b.getX()+gs/2 >= px && b.getX()-gs/2 <= px
      && b.getZ()+gs/2 >= pz && b.getZ()-gs/2 <= pz)
      if (b.getY()-py < gs*2 && b.getY()-py >0)
        return true;
  }

  return false;
}

boolean isTouchingCeil(){
  for (Box b : outerBoxes) {
    if (b.getX()+gs/2 >= px && b.getX()-gs/2 <= px
      && b.getZ()+gs/2 >= pz && b.getZ()-gs/2 <= pz)
      if (py-b.getY() < gs && py-b.getY() >0)
        return true;
  }
  return false;
}

boolean isTouchingAround(){
  for (Box b : outerBoxes) {
    if (abs(b.getX()-px) < gs *0.8 && abs(b.getY()-py) < gs && abs(b.getZ()-pz) < gs*0.8){
      return true;
    }
  }
  return false;
}
