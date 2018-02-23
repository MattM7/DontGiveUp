// Release 3.2 - Darth Maul - the eye!

/* NOTE: You will have to download the Minim library:
 At the top of the processing window, click on Sketch -> Import Library
 -> Add Library. Then search for Minim and click Install.
 */

import ddf.minim.*;
// ============== MINIM SETUP =========================================================
Minim minim;
AudioSample jump;
AudioPlayer player;

// ============== GLOBAL/INTIAL VARIABLES =============================================
int nLevel = 1; // the level number
int nMaxLevel = 43; // 42 is the last level
boolean bDrawn = false;// needed for multiple levels in later releases and to stop continously adding more boxes (of Class Box)
int nI; //general variable used for hit testing with the arrayList 
int nBoxSize = 50; //width of a box
int nLevelHeight, nLevelWidth; // for only scrolling till the edge of the level  
float fXCamOffset = 0, fYCamOffset = 0; //will translate by this much to give the effect of scrolling
int nXLevelRect, nYLevelRect, nLevelRectWidth, nLevelRectHeight; // a rectangular "background" for the level display
int nXTimerRect, nYTimerRect, nTimerRectWidth, nTimerRectHeight; // a rectangular "background" for the timer display
PFont font8Bit;

// ============== CREATE OBJECTS =============================================
Sprite entry;// create doors
Sprite exit; // create doors
Messages message;
Sprite hero; // create an instance of Protagonist
Timer timer;
LevelBase LvlBase;
Level1 Lvl1;
Level2 Lvl2;
Level3 Lvl3;
Level4 Lvl4;
Eye eyeL;
Eye eyeR;

// ============== SETUP =============================================
void setup() {
  size(900, 600);
  nLevelHeight = height+nBoxSize;
  nLevelWidth=width+width/2;// seems like a good size
  entry = new Sprite (nBoxSize, nLevelHeight-nBoxSize-75, nBoxSize, nLevelHeight-nBoxSize-75, 1.6, 0.6, 16, 0, "entryDoor.png"); //75 for height of the door 
  exit = new Sprite (nLevelWidth-nBoxSize-48, nLevelHeight-nBoxSize-75, nLevelWidth-nBoxSize-48, nLevelHeight-nBoxSize-75, 1.6, 0.6, 16, 0, "exitDoor.png"); // 48 for width of the door
  //Protagonist(PVector vTempPos, PVector vTempPosStart, float fTempAccel, float fTempVelocity, int nTempVelocityLimit, int nTempDirec)
  hero = new Sprite (75, 75, 75, 75, 1.6, 0.6, 16, 0, "PixelCrab.png");//construct a hero // to fix the lag had to change from 0.8 to 1.6, 0.3 to 0.6, 8 to 16 
  //font8Bit = loadFont("ArcadeClassic.vlw");  
  font8Bit = loadFont("RetroComputer.vlw");  // this font is bitmapped, and might have to be a multiple of 14 px
  message = new Messages (width/2, (height/2)-(height/4));
  frameRate(30); // to fix the lag
  // Stuff for the level number background
  nXLevelRect =  width-4*nBoxSize;
  nYLevelRect = height-nBoxSize+5;
  nLevelRectWidth = 4*nBoxSize-10;
  nLevelRectHeight = nBoxSize-10;
  // Stuff for the timer background
  nXTimerRect =  nBoxSize/4;
  nYTimerRect = height-nBoxSize+5;
  nTimerRectWidth = 5*nBoxSize-20;
  nTimerRectHeight = nBoxSize-10;
  timer = new Timer(1000); // 1000 ms = 1 second
  LvlBase = new LevelBase();
  eyeL = new Eye(nLevelWidth/2, 100);
  eyeR = new Eye(nLevelWidth/2+75, 100);

  minim = new Minim(this);
  jump = minim.loadSample("jump.wav");
  player = minim.loadFile("DontGiveUp.mp3");
  player.loop();
  jump.setGain(9001); //OVER 9000!!!!!!
  //Lvl1 =new Level1();
  // Lvl2 = new Level2();
  //Lvl3 =new Level3();
}

// ============== DRAW =============================================
void draw() {
  //println(millis()); // used for debugging
  //println(frameRate); // used for debugging
  pushMatrix();  // save origin
  updateCameraPosition();  
  translate(-fXCamOffset, -fYCamOffset); //translate the origin by the camerOffset variable to give a sidescrolling effect
  background(20);    

  if (bDrawn==false) {
    if (nLevel==1) {
      Lvl1=null;
      nullAndRecreatePlatAL();
      Lvl1 =new Level1();
    } else if (nLevel==2) {
      Lvl1=null;
      nullAndRecreatePlatAL();
      Lvl2 =new Level2();
    } else if (nLevel==3) {
      Lvl2=null;
      nullAndRecreatePlatAL();
      Lvl3 =new Level3();
    } else if (nLevel==4) {
      Lvl3=null;
      nullAndRecreatePlatAL();
      Lvl4 =new Level4();
    } else if (nLevel==5) {
      Lvl4=null;
    }
  }
  //Lvl3.createBoxes();
  //Lvl2.createBoxes();
  //Lvl1.createBoxes();
  //  LvlBase.createBoxes();
  //sLevel = "Lvl"+str(nLevel);
  //sLevel.createBoxes(); // trying to find a shorter way to have the level create boxes

  entry.display();
  exit.display();

  hero.update();
  eyeL.update();
  eyeR.update();
  // display all boxes in the arrayList
  for (Sprite nI : LvlBase.alBox) {//nI = 0; nI<alBox.size(); nI++) {
    nI.display();
  }
  for (Sprite nI : LvlBase.alPlat) {//nI = 0; nI<alBox.size(); nI++) {
    nI.display();
  }
  popMatrix(); // replace the translated origin with the original one
  fill(0, 255, 0, 200);
  rect(nXLevelRect, nYLevelRect, nLevelRectWidth, nLevelRectHeight); // a rectangular "background" for the level display
  fill(0, 0, 255, 200);
  rect(nXTimerRect, nYTimerRect, nTimerRectWidth, nTimerRectHeight); // a rectangular "background" for the timer display
  message.display();
  timer.display();
}

// ============== KEYPRESSED =============================================
void keyPressed() {
  if (key == 'w' || key == 'W') {
    hero.jump();
    hero.nJumpCount++;
  }
  if (key == 'a' || key == 'A') {
    hero.nDirec=1; //left
  }
  if (key == 'd' || key == 'D') {
    hero.nDirec=2; //right
  }
}

// ============== KEY RELEASED =============================================
void keyReleased() { // if key stops being pressed, the player will stop going left or right, this gives smoother movement
  if ((key=='d'||key=='D')||(key=='a'||key=='A')) {
    hero.nDirec=0;
  }
}

// ============== UPDATE CAMERA POSITION =============================================
/* From platformer example // http://www.hobbygamedev.com/int/platformer-game-source-in-processing/
 
 Unfortunetly, there wasn't much to change in the function below. We attempted to do it a different way,
 But it didn't work out so well
 We did add the scrolling along the Y axis*/
void updateCameraPosition() {
  int nRightEdge = nLevelWidth-width; // the right side of the camera panel shouldn't go right of the orignal "rightEdge" of the "camera"
  // (width of the level - the width of width of the screen)
  int nTopEdge = nLevelHeight-height;

  fXCamOffset = hero.fX-width/2; // the camera offset is equal to the position of the player , subtract half the width of the level
  fYCamOffset = hero.fY-height/2; // the camera offset is equal to the position of the player , subtract half the height of the level

  if (fXCamOffset <= 0) { 
    fXCamOffset = 0; // if the offset is less than 0, set it to 0 so that the level doesn't translate into thin air
  }
  if (fXCamOffset >= nRightEdge) {
    fXCamOffset = nRightEdge; //if the offset is more than the rightEdge, set it to the rightEdge so that the level doesn't translate into thin air
  }

  if (fYCamOffset <= 0) { 
    fYCamOffset = 0; // if the offset is less than 0, set it to 0 so that the level doesn't translate into thin air
  }
  if (fYCamOffset >= nTopEdge) {
    fYCamOffset = nTopEdge; //if the offset is more than the TopEdge, set it to the rightEdge so that the level doesn't translate into thin air
  }
}
// ============== GET RID OF AND THEN RECREATE THE ARRAYLIST =============================================
void nullAndRecreatePlatAL() {
  LvlBase.alPlat=null;
  LvlBase.alPlat = new ArrayList<Sprite>();
}