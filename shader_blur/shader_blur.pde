// The world pixel by pixel 2018
// Daniel Rozin
// use fragment shader to do a blur on live video


import processing.video.*;


Capture video;
PShader myFragShader;

void setup() {
  size(640, 480, P2D);
  frameRate(400);
  myFragShader = loadShader("myFragShader.glsl");
  video = new Capture(this,width, height);
  video.start();
}
void captureEvent(Capture c) {
  c.read();
}

void draw() {
  image(video,0,0);
  int amount = int(map(mouseX, 0,width, 1,10));
  myFragShader.set("amount",amount);
  shader(myFragShader);
  println (frameRate);
}