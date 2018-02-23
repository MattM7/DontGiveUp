/*  We use this class to have a timer appear on screen, and 
 make it so that you don't instantly move onto the next level,
 but you do so after a second of touching the door.
 We also use it for the give up Button
 */
class Timer {
  int nTimerLength;
  int nTimeAtTimerStart;     
  int nTimeSinceTimerStarted ;
  int nMillisec, nSec, nMin, nHour;
  String sTime, sHour, sMin, sSec, sMillisec;
  int nXTimerRect, nYTimerRect, nTimerRectWidth, nTimerRectHeight; // a rectangular "background" for the timer display
  // ============== CONSTRUCTOR =============================================
  Timer(int nTempTimerLength) {
    nTimerLength=nTempTimerLength;
    textFont(font8Bit, 28); 
    // textAlign(LEFT, CENTER);
    fill(0);
    nXTimerRect =  nBoxSize/4;
    nYTimerRect = height-nBoxSize+5;
    nTimerRectWidth = 5*nBoxSize-20;
    nTimerRectHeight = nBoxSize-10;
  } // ============== START =============================================
  void start() {
    nTimeAtTimerStart=millis();
  }
  // ============== DISPLAY =============================================

  /* got help from https://forum.processing.org/one/topic/timer-in-processing.html
   the link above was used to help create a timer that displayed properly*/
  void display() {
    textAlign(LEFT, CENTER);
    nMillisec = (millis()/10)%100;
    nSec = (millis()/1000)% 60;
    nMin = (millis()/(1000*60)) % 60;
    nHour = (millis()/ (1000*60*60)) % 24;
    /*https://www.processing.org/discourse/alpha/board_Syntax_action_display_num_1087808386.html
     https://processing.org/reference/conditional.html
     below is a shorter way to "if/else" that works w/ strings
     basically works like this - (expression) ? statement1 : statement2;
     what the 4 lines of code does below is that if the value of whatever
     place (ex. seconds) is less than 10, then it adds a "0" in front 
     so that it displays "09:54" instead of "9:54"*/
    sHour = (nHour<10)? "0"+str(nHour):str(nHour); 
    sMin = (nMin<10)? "0"+str(nMin):str(nMin);
    sSec = (nSec<10)? "0"+str(nSec):str(nSec);
    sMillisec= (nMillisec<10)? "0"+str(nMillisec):str(nMillisec);
    sTime = sHour +":"+sMin+":"+sSec+":"+sMillisec; 
    fill(0, 0, 255, 200);
    rect(nXTimerRect, nYTimerRect, nTimerRectWidth, nTimerRectHeight); // a rectangular "background" for the timer display
    fill (0);
    text(sTime, nXTimerRect+nTimerRectWidth/16, nYTimerRect+nTimerRectHeight/2); // original was nTimerRectWidth/2 when we didn't use textAlgin();
  }

  // ============== IS-REACHED-TIME=============================================
  boolean isReachedTime() { 
    // Check how much time has passed
    nTimeSinceTimerStarted = millis() - nTimeAtTimerStart;
    if (nTimeSinceTimerStarted >= nTimerLength) {
      return true;
    } else {
      return false;
    }
  }
}