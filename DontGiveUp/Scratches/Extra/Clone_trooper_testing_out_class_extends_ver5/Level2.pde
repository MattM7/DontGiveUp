class Level2 extends LevelBase {
  Level2() {
    super();
    LvlBase.alPlat.add(new Box (nLevelWidth-10*nBoxSize, nLevelHeight-3*nBoxSize));
    LvlBase.alPlat.add(new Box (nLevelWidth-9*nBoxSize, nLevelHeight-3*nBoxSize));
    LvlBase.alPlat.add(new Box (nLevelWidth-8*nBoxSize, nLevelHeight-3*nBoxSize));
    bDrawn = true;
  }
}