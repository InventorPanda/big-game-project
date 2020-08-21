byte worldScale = 4;
int invSlotSize = 560/12;
int worldSize = 40;

float noiseIncr = 0.001;
float timeX = 10;
float timeY = 0;

PImage txtgrass;
PImage txtdirt;

int numDirt = 0;

tile emptytile = new tile(0, 0);

block dirt;
block grass;

block[] blockArry = new block[5];
tile[][] world = new tile[40][40];
tile[][] worldlayer = new tile[40][40];

tile[] tils = new tile[1];

player MC;
tile MCtil;

boolean invtog = false;

item cookie;
ItemStack cookies;
item[] itms = new item[1];

byte yMvm, xMvm;

void setup() {

size(640, 640);

//Begin the Epic Quest!!!
MC = new player(floor(worldSize/2), floor(worldSize/2), byte(worldSize));

txtgrass = loadImage("grass.png");
txtdirt = loadImage("dirt.png");

dirt = new block("Dirt", txtdirt, false);
grass = new block("Grass", txtgrass, false, dirt, byte(1), byte(1));

itms[0] = new item(loadImage("wood.png"), "Wood");

blockArry[0] = dirt;
blockArry[1] = grass;
blockArry[2] = new block("Wooden Wall", loadImage("planks_birch.png"), true);
blockArry[3] = new block("Barrier Wall", loadImage("wall.png"), true);
blockArry[4] = new block("Sapling", loadImage("sapling.png"), false, itms[0], byte(4), byte(7), true);

MCtil = new tile(MC.posx, MC.posy, new block("Player", loadImage("ruby.png"), false));
MCtil.p = true;

cookie = new item(loadImage("cookie.png"), "Cookie");

generateEmpty();
generate();
frameRate(24);
}

void draw() {
background(0);
if (!invtog)
renderAFloor();
else {
MC.Inverted.display(40, 40, width-80, height-80);
}
MC.quickswap.display(width/3 - 40, (height/3) * 2 - 40, width/3, 40);
}

void keyPressed() {
switch (key) {

case 'w':
  yMvm = 1;
  break;

case 's':
  yMvm = -1;
  break;

case 'd':
  xMvm = 1;
  break;

case 'a':
  xMvm = -1;
  break;
}
}

void keyReleased() {
MC.move(yMvm, xMvm);
switch (key) {

case 'w':
  yMvm = 0;
  break;

case 's':
  yMvm = 0;
  break;

case 'd':
  xMvm = 0;
  break;

case 'a':
  xMvm = 0;
  break;
case 'e':
  invtog = !invtog;
  break;
}
}