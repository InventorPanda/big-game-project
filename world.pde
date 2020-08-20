class tile {
  int indx, indy;
  block bokbok; //Chicken Placeholder
  boolean empty;
  boolean p = false;

  tile(int inx, int iny, block chicken) {
    indx = inx;
    indy = iny;
    bokbok = chicken; //Chicken Placeholder
  }

  tile(int inx, int iny) {
    indx = inx;
    indy = iny;
    bokbok = null; //Chicken Placeholder
    empty = true;
  }

  void render(int Viewindx, int Viewindy) {
    if (!empty)
      image(bokbok.texture, Viewindx*worldScale, Viewindy*worldScale);
  }

  ItemStack brakeI() {
    return new ItemStack(indx, indy, bokbok.dropMe().tim, bokbok.dropMe().count);
  }

  ItemStack brake() {
    return new ItemStack(indx, indy, bokbok, bokbok.dropMax);
  }
}

class block {
  PImage texture;
  String name;
  boolean dropsSelf; //if Yes then no special item drop variable;
  item drop;
  block drOOp;
  byte dropMin, dropMax; //How many to drop, randomly selected between here.
  boolean isWall;

  block(String Name, PImage txtr, boolean dropsit, item drOp, byte min, byte mx) {
    name = Name;//Name, from One Piece. Said "Nom may", I've only got up to the episode where she betrays them, so please come back Name!
    texture = txtr;
    dropsSelf = dropsit;
    drop = drOp; // Epic hacker name, without an actual Zero.
    dropMin = min;
    dropMax = mx;
  }
  block(String Name, PImage txtr, boolean dropsit, item drOp, byte min, byte mx, boolean wal) {
    name = Name;//Name, from One Piece. Said "Nom may", I've only got up to the episode where she betrays them, so please come back Name!
    texture = txtr;
    dropsSelf = dropsit;
    drop = drOp; // Epic hacker name, without an actual Zero.
    dropMin = min;
    dropMax = mx;
    isWall = wal;
  }

  block(String Name, PImage txtr, boolean dropsit, block drOp, byte min, byte mx) {
    name = Name;
    texture = txtr;
    dropsSelf = dropsit;
    drOOp = drOp;
    dropMin = min;
    dropMax = mx;
  }

  block(String Name, PImage txtr, boolean wall) {
    name = Name;
    texture = txtr;
    dropsSelf = true;
    drop = null; 
    drOOp = this;
    dropMin = 0;
    dropMax = 0;
    isWall = wall;
  }

  ItemAndCount dropMe() {
    return new ItemAndCount(drop, byte(random(dropMin, dropMax)));
  }

  BlockAndCount dropMe(byte d) {
    return new BlockAndCount(drOOp, d);
  }
}

class item {
  PImage texture;
  String name;

  item(PImage img, String Name) {
    texture = img;
    name = Name;
  }
}

class ItemAndCount {
  item tim;
  byte count;

  ItemAndCount(item IMT, byte COUNt) {
    tim = IMT;
    count = COUNt;
  }
}

class BlockAndCount {
  block tim;
  byte count;

  BlockAndCount(block IMT, byte COUNt) {
    tim = IMT;
    count = COUNt;
  }
}

class ItemStack { // Items On the Ground that can be Collected
  int WorldPosX, WorldPosY;
  BlockAndCount bokStak;
  ItemAndCount TimsSecretStash;

  ItemStack(int x, int y, block bokokaa, byte count) {
    bokStak = new BlockAndCount(bokokaa, count);
    TimsSecretStash = null;
    WorldPosX = x;
    WorldPosY = y;
  }

  ItemStack(int x, int y, item Chocolates, byte count) {
    bokStak = null;
    TimsSecretStash = new ItemAndCount(Chocolates, count);
    WorldPosX = x;
    WorldPosY = y;
  }

  tile makeRenderable(byte CoUnT) {
    return new tile(WorldPosX, WorldPosY, new block("Cookie Block", TimsSecretStash.tim.texture, false, cookie, CoUnT, CoUnT));
  }
}

void generate() {

  for (int i = 0; i < worldSize; i ++) {
    for (int j = 0; j < worldSize; j ++) {
      world[i][j] = new tile(j, i, blockArry[1]);
    }
  }

  createCookie();
  for(int I = 0; I < int(random(2, 5))) {}
  createTrees();

  for (int i = 0; i < worldSize; i ++) {
    world[i][0] = new tile(0, i, blockArry[3]);
    world[i][worldSize-1] = new tile(worldSize-1, i, blockArry[3]);
  }
  for (int i = 0; i < worldSize; i ++) {
    world[0][i] = new tile(i, 0, blockArry[3]);
    world[worldSize-1][i] = new tile(i, worldSize-1, blockArry[3]);
  }
}

void renderAFloor() {
  for (int i = 0; i < worldSize; i ++) {
    for (int j = 0; j < worldSize; j ++) {
      world[i][j].render(j * worldScale, i * worldScale);
      if (!worldlayer[i][j].empty) 
        worldlayer[i][j].render(j*worldScale, i*worldScale);
    }
  }
}

void generateEmpty() {
  for (int i = 0; i < worldSize; i ++) {
    for (int j = 0; j < worldSize; j ++) {
      worldlayer[i][j] = emptytile;
    }
  }
}

void createTrees() {
  boolean b = false;
  while (!b) {
    int rnx = floor(random(worldSize-1))+1;
    int rny = floor(random(worldSize-1))+1;
    if (worldlayer[rny][rnx].empty) {
      b = true;
      tils[0] = new tile(rnx, rny, blockArry[4]);
      worldlayer[rny][rnx] = tils[0];
    }
  }
}

void createCookie() {
  cookies = new ItemStack(ceil(random(worldSize-2)), ceil(random(worldSize-2)), cookie, byte(1));
  worldlayer[cookies.WorldPosY][cookies.WorldPosX] = cookies.makeRenderable(byte(1));
}
