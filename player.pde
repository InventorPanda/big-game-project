class player {
long healthmx, health;
float strengthmx, strengthmn;
int posx, posy;
int prevx, prevy;
byte viewfield;
inventory Inverted;
inventory quickswap;

player(int x, int y, byte fov) {
posx = x;
posy = y;
viewfield = fov;
Inverted = new inventory(byte(9), byte(3));
quickswap = inventory(byte(3), byte(1));
}

void move(byte y, byte x) {
prevx = posx;
prevy = posy;

posx += x;
posy -= y;

if (world[posy][posx].bokbok.isWall) {

posx = prevx;
posy = prevy;
} else {
if (!worldlayer[posy][posx].empty && worldlayer[posy][posx] != MCtil) {
//worldlayer[posy][posx]
ItemStack i = worldlayer[posy][posx].brakeI();
Inverted.collect(i.TimsSecretStash);
}

float attack(item s) {

return random(strengthmn, strengthmx) + s.atkPlus;
}

worldlayer[prevy][prevx] = emptytile;
worldlayer[posy][posx] = MCtil;
}
}

boolean inFOV(int i, int j) {
return ((i < posy + viewfield / 2) || (i > posy - viewfield / 2)) && ((j < posx + viewfield / 2) || (j > posx - viewfield / 2));
}
}

class inventory {
itemSlot[] items;
byte size;
byte lngth, wdth;

// I N F R A S T R U C T R E
inventory(byte lOng, byte ThIcC) {
lngth = lOng;
wdth = ThIcC;
size = byte(lngth * wdth);
items = new itemSlot[size];
}

// D I S P L A Y   M E   P L E A S E
void display(int x, int y, int wide, int tall) {
stroke(144);
strokeWeight(2);
fill(192);
ellipseMode(CORNER);
rectMode(CORNER);

rect(x, y, wide, tall);
translate(x, y);
for (int i = 0; i < wdth; i ++) {
for (int j = 0; j < lOng; j ++) {


fill(144);
noStroke();

ellipse(j * invSlotSize + x, i * invSlotSize + y, invSlotSize - sqrt(invSlotSize)/2, invSlotSize - sqrt(invSlotSize)/2);

try {
items[(i * wdth) + j].display(j * invSlotSize + 2 + x, i * invSlotSize - 2 + y, invSlotSize - 8);
fill(255);
text(items[(i*wdth)+j].count, j*invSlotSize + x, i*invSlotSize + y);
}

catch (NullPointerException exception) {
}

strokeWeight(5);
stroke(224);
noFill();

rect(j*invSlotSize+x-2, i*invSlotSize+y-2, invSlotSize, invSlotSize);
}
}
}

//Now, onto some Actual Gameplay. Let's collect an item!
void collect(ItemAndCount ijk) {
//boolean b = false;
//int i = 0, j = 0;
//while (b != true) {
//  i = 0;
//  if (items[j].time == ijk.tim) {
//    i ++;
//    while (items[j] == null) {
//      j ++;
//    }
//    if (items[j].time == ijk.tim) {
//      items[j].collect(ijk.tim, ijk.count);
//    }
//  }
//  if (ijk.count == 0) b = true;
//}
int i = 0;
try {
while (items[i].time != ijk.tim) {
i ++;
}

items[i].count += ijk.count;
}
catch(NullPointerException exception) {
while (items[i] != null) {
i ++;
}
items[i] = new itemSlot(new item(ijk.tim.texture, ijk.tim.name), ijk.count, byte(255));
}
}

//This time we collect a block
void collect(block tim, byte count) {
boolean b = false;
int i = 0, j = 0;
BlockAndCount ijk = new BlockAndCount(tim, count);
while (b != true) {
i = 0;
if (items[i].blokc == tim) {
i ++;
while (items[j] == null) {
j ++;
}
if (items[j].blokc == tim) {
items[j].collect(ijk.tim, ijk.count);
}
}
if (ijk.count == 0) b = true;
}
}
}

class itemSlot {
block blokc;
item time;
boolean itm;
byte count; //How many I has
byte maxCount; //How many I CAN has

// I N F R A S T R U C T R E
itemSlot(block bokBOk, byte CNout, byte CountMaxTheDoggoToo) { //don't forget to include Max the Doggo.
blokc = bokBOk;
time = null;
count = CNout;
maxCount = CountMaxTheDoggoToo;
}
// A R C H I T E X T U R E
itemSlot(item ThymeTheSPice, byte CNout, byte CountMaxTheDoggoToo) {
blokc = null;
time = ThymeTheSPice;
count = CNout;
maxCount = CountMaxTheDoggoToo;
}

// D I S P L A Y   M E   P L E A S E
void display(int x, int y, int hite) {
PImage img;
try {
img = time.texture;
}
catch(NullPointerException exception) {
img = blokc.texture;
}

try {
img = blokc.texture;
}

catch(NullPointerException exception) {
img = time.texture;
}
image(img, x, y, hite, hite);
}

//Give Me Stuff
ItemAndCount collect(item im, byte cont) {
count += cont;
byte carrySum = byte(count - maxCount);
if (count > maxCount) count = maxCount;
return new ItemAndCount(im, carrySum);
}
BlockAndCount collect(block im, byte cont) {
count += cont;
byte carrySum = byte(count - maxCount);
if (count > maxCount) count = maxCount;
return new BlockAndCount(im, carrySum);
}
}