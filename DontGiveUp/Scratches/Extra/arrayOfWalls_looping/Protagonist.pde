class Protagonist {
  PVector vPos;
  PVector vPosStart;
  float fAccel; //0.8 seems real /// never changes
  float fVelocity, fVelocityLimit;
  boolean canJump;
  int nDirec;
  PImage img;
  Protagonist(PVector vTempPos, float fTempAccel, float fTempVelocity, int nTempVelocityLimit, boolean canTempJump, int nTempDirec) {
    vPos = vTempPos;
    fAccel = fTempAccel; //0.8 seems real /// never changes
    fVelocity = fTempVelocity;
    fVelocityLimit = nTempVelocityLimit;
    canJump = canTempJump;
    nDirec = nTempDirec;
    vPosStart= vTempPos;
  }

  void update() {
    move();
    display();
    gravity();
  }

  void gravity() {//PVector vPos, float fAccel, float fVelocity, boolean canJump, int nDirec) {
    println("Accel "+fAccel+" Velocity "+fVelocity+" vPos "+vPos+" CanJump "+canJump+" nDirec "+nDirec); // debugging
    fVelocity+=fAccel;
    if (canJump) {
      vPos.y-=fVelocity;
      if (fVelocity==fVelocityLimit||fVelocity>fVelocityLimit) {
        fVelocity*=-1; // slows it down near the top
        canJump=false;
      }
    }
    if (!canJump) {
      vPos.y+=fVelocity;
    }
    ////sto  ps from falling//
    vPosStart.y=vPos.y;
    if (isHit(hero)) {
      vPos.y=470;//vPosStart.y;
      fVelocity=0;
    }
  }
  void display() {
    rect(vPos.x, vPos.y, 30, 30);
  }

  void move() {
    if (nDirec==-1) {
      vPos.x-=2;
    }
    if (nDirec==1) {
      vPos.x+=2;
    }
  }

  boolean isHit(Protagonist hero) {
    if (hero.vPos.y+30>=(height-100)) {
      return true;
    } else {
      return false;
    }
  }
}