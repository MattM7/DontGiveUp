class Protagonist {
  PVector vPos;
  PVector vPosStart;
  float fAccel; //0.8 seems real /// never changes
  float fVelocity, fVelocityLimit;
  boolean canJump;
  int nDirec;
  PImage img;
  boolean bJump; 
  boolean bHitSide;
  Protagonist(PVector vTempPos, float fTempAccel, float fTempVelocity, int nTempVelocityLimit, boolean canTempJump, int nTempDirec, boolean bTempJump, boolean bTempHitSide) {
    vPos = vTempPos;
    fAccel = fTempAccel; //0.8 seems real /// never changes
    fVelocity = fTempVelocity;
    fVelocityLimit = nTempVelocityLimit;
    canJump = canTempJump;
    nDirec = nTempDirec;
    vPosStart= vTempPos;
    img=loadImage("patrick.png");
    bJump = bTempJump;
    bHitSide = bTempHitSide;
  }

  void update() {
    move();
    display();
    gravity();
  }

  void gravity() {//PVector vPos, float fAccel, float fVelocity, boolean canJump, int nDirec) {
    println("Accel "+fAccel+" Velocity "+fVelocity+" vPos "+vPos+" CanJump "+canJump+" nDirec "+nDirec); // debugging
    fVelocity+=fAccel;
    canJump = false;
    if (fVelocity > fVelocityLimit) {
      fVelocity = fVelocityLimit;
    }
    if (fVelocity < -fVelocityLimit) {
      fVelocity = -fVelocityLimit;
    }
    vPos.y+=fVelocity;
    for (int i = 1; i< alWall.size(); i ++) { //does nothing
      if (isHit(vPos.x, vPos.y, alWall.get(i).fX, alWall.get(i).fY, img, alWall.get(i).img)) {
        //if (vPos.y < alWall.get(i).fX) { // without this line it gets stuck in the floor, with it it doesnt detect anything
        vPos.y = alWall.get(i).fY - img.height;
        fVelocity = 0;
        canJump = true;
        //}
      }
    }
  }
  void display() {
    image(img, vPos.x, vPos.y);
  }
  
  void jump() {
    if (fVelocity < fVelocityLimit) {
      fVelocity = fVelocityLimit;
    }
  }

  void move() {
    vPosStart.x = vPos.x;
    if (nDirec==-1) {
      vPos.x-=2;
    }
    if (nDirec==1) {
      vPos.x+=2;
    }
    for (int i = 1; i< alWall.size(); i ++) { //does nothing
     if (isHit(vPos.x, vPos.y, alWall.get(i).fX, alWall.get(i).fY, img, alWall.get(i).img)) {
        //if (vPos.y < alWall.get(i).fY) { // without this line it gets stuck in the floor, with it it doesnt detect anything
        //vPos.x = vPosStart.x;
        //nDirec = 0;
        //fVelocity = 0;
        }
      //}
    }
  }

  boolean isHit(float nX1, float nY1, float nX2, float nY2, PImage img1, PImage img2) {

    int nW1 =img1.width;
    int nW2 = img2.width;
    int nH1 = img1.height;
    int nH2 = img2.height;

    if (
      ( ( (nX1 <= nX2) && (nX1+nW1 >= nX2) ) ||
      ( (nX1 >= nX2) && (nX1 <= nX2+nW2) ) )
      &&
      ( ( (nY1 <= nY2) && (nY1+nH1 >= nY2) ) ||
      ( (nY1 >= nY2) && (nY1 <= nY2+nH2) ) )
      )
      return (true) ;
    else
      return(false) ;
  }
}