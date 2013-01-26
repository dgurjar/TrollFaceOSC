import oscP5.*;
OscP5 oscP5;

// num faces found
int found;

// pose
float poseScale;
PVector posePosition = new PVector();
PVector poseOrientation = new PVector();

// gesture
float mouthHeight;
float mouthWidth;
float eyeLeft;
float eyeRight;
float eyebrowLeft;
float eyebrowRight;
float jaw;
float nostrils;

//Troll image
PImage img, img0, img1, img2, img3, img4, img5;

void setup(){
  size(640,480);
  oscP5 = new OscP5(this, 8338);
  oscP5.plug(this, "found", "/found");
  oscP5.plug(this, "poseScale", "/pose/scale");
  oscP5.plug(this, "posePosition", "/pose/position");
  oscP5.plug(this, "poseOrientation", "/pose/orientation");
  oscP5.plug(this, "mouthWidthReceived", "/gesture/mouth/width");
  oscP5.plug(this, "mouthHeightReceived", "/gesture/mouth/height");
  oscP5.plug(this, "eyeLeftReceived", "/gesture/eye/left");
  oscP5.plug(this, "eyeRightReceived", "/gesture/eye/right");
  oscP5.plug(this, "eyebrowLeftReceived", "/gesture/eyebrow/left");
  oscP5.plug(this, "eyebrowRightReceived", "/gesture/eyebrow/right");
  oscP5.plug(this, "jawReceived", "/gesture/jaw");
  oscP5.plug(this, "nostrilsReceived", "/gesture/nostrils");
  loadPixels();
  
  img0 = loadImage("0.jpeg");
  img1 = loadImage("1.jpeg");
  img2 = loadImage("2.jpeg");
  img3 = loadImage("3.jpeg");
  img4 = loadImage("4.jpeg");
  img5 = loadImage("5.jpeg");
}


void draw(){
  background(255); 

  //Given the FaceOSC parameters, choose the right troll face
  if(found > 0){
    translate(posePosition.x -100*poseScale, posePosition.y-100*poseScale);

    if(is0())
      img = img0;
    else if(is1())
      img = img1;
    else if(is2())
      img = img2;
    else if(is3())
      img = img3;
    else if(is4())
      img = img4;
    else
      img = img5;
      
    scale(poseScale);
    image(img, 0, 0);
  }
  
}

boolean isGrinning(){
  if(mouthWidth > 16.5)
    return true;
  return false;
}

boolean areEyebrowsRaised(){
  if(eyebrowLeft > 9 && eyebrowRight > 9)
    return true;
  return false;
}

boolean areEyebrowsMad(){
  if(eyebrowLeft < 6.3 && eyebrowRight < 6.3)
    return true; 
  return false;
}

boolean isSmiling(){
  if(mouthWidth > 14.5)
    return true;
  return false;
}

boolean isFrowning(){
  return false;
}


//Troll Face Profiles
boolean is0(){
  if(isGrinning())
    return true;
  return false;
}

boolean is1(){
  if(areEyebrowsRaised() && isSmiling())
   return true; 
  return false;
}

boolean is2(){
    if(areEyebrowsMad() && !isSmiling())
    return true;
  return false;
}


boolean is3(){
  return false;
}

boolean is4(){
  return false;
}

boolean is5(){
  return false;
}

boolean is6(){
  return false;
}


// OSC CALLBACK FUNCTIONS
public void found(int i) {
  println("found: " + i);
  found = i;
}

public void poseScale(float s) {
  println("scale: " + s);
  poseScale = s;
}

public void posePosition(float x, float y) {
  println("pose position\tX: " + x + " Y: " + y );
  posePosition.set(x, y, 0);
}

public void poseOrientation(float x, float y, float z) {
  println("pose orientation\tX: " + x + " Y: " + y + " Z: " + z);
  poseOrientation.set(x, y, z);
}

public void mouthWidthReceived(float w) {
  println("mouth Width: " + w);
  mouthWidth = w;
}

public void mouthHeightReceived(float h) {
  println("mouth height: " + h);
  mouthHeight = h;
}

public void eyeLeftReceived(float f) {
  println("eye left: " + f);
  eyeLeft = f;
}

public void eyeRightReceived(float f) {
  println("eye right: " + f);
  eyeRight = f;
}

public void eyebrowLeftReceived(float f) {
  println("eyebrow left: " + f);
  eyebrowLeft = f;
}

public void eyebrowRightReceived(float f) {
  println("eyebrow right: " + f);
  eyebrowRight = f;
}

public void jawReceived(float f) {
  println("jaw: " + f);
  jaw = f;
}

public void nostrilsReceived(float f) {
  println("nostrils: " + f);
  nostrils = f;
}

// all other OSC messages end up here
void oscEvent(OscMessage m) {
  if(m.isPlugged() == false) {
    println("UNPLUGGED: " + m);
  }
}
