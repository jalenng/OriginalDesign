int INITIAL_BALL_DIAMETER = 50;
float ballDiameter = INITIAL_BALL_DIAMETER;

void setup()
{
  assignVars();
  size(640, 640);
  frameRate(60);
  noStroke();
}

int x;
int y;
float v;

double vX = 4;
double vY = 4;

float ballBrightness = 255;

float circleRotation = 0;

int redQueue = 0;
int greenQueue = 0;
int blueQueue = 0;
int subtractQueue = 0;

float maxCircleDiameter;
float minCircleDiameter;

void assignVars()
{
  x = 50;
  y = height / 2;
  
  maxCircleDiameter = 1.25 * sqrt(sq(width / 2) + sq(height / 2));
  minCircleDiameter = 30;
}

void draw()
{
  background(0);
  drawWalls();
  drawBall();
  updateBall();
  processPosition();
}

void drawBall()
{
  noStroke();
  fill(ballBrightness, ballBrightness, ballBrightness, 200);
  ellipse(x, y, ballDiameter, ballDiameter);
}

void drawWalls()
{ 
  for(int d = parseInt(minCircleDiameter); d < maxCircleDiameter; d += 10) {
    strokeWeight(10);
    noFill();
    float alpha = 255 * (d / maxCircleDiameter);
    stroke(255, 0, 0, alpha);
    arc(width / 2, height / 2, d, d, circleRotation + (-5 * PI / 6), circleRotation + (-1 * PI / 6));
    stroke(0, 255, 0, alpha);
    arc(width / 2, height / 2, d, d, circleRotation + (-1 * PI) / 6, circleRotation + (3 * PI / 6));
    stroke(0, 0, 255, alpha);
    arc(width / 2, height / 2, d, d, circleRotation + (3 * PI / 6), circleRotation + (7 * PI / 6));
  }
}

void updateBall()
{
  x += vX;
  y += vY;
}

void processPosition()
{
  circleRotation += PI / 30;
  double cAngle = calculateCAngle();
  
  float ballRadiusFromCenter = sqrt(sq(x - (width / 2)) + sq(y - (height / 2)));
  
  float ratio = (ballRadiusFromCenter) / (minCircleDiameter / 2);
  ballBrightness = 255 * ratio / (minCircleDiameter / 2);
  ballDiameter = INITIAL_BALL_DIAMETER * ratio / (minCircleDiameter / 2);
  float xRatio = (x - (width / 2)) / (minCircleDiameter / 2);
  float yRatio = (y - (height / 2)) / (minCircleDiameter / 2);
  vX -= xRatio / 15;
  vY -= yRatio / 15;
  println(ratio);
  if (ratio >= 1) {
    
    if (cAngle >= 1 * PI / 6 && cAngle < 5 * PI / 6) {
      redQueue++;
      println("RED");
    } else if ((cAngle >= 5 * PI / 6 && cAngle < 9 * PI / 6)) {
      blueQueue++;
      println("BLUE");
    } else if ((cAngle >= 9 * PI / 6 && cAngle < 12 * PI / 6) || (cAngle > 0 && cAngle < 1 * PI / 6)) {
      greenQueue++;
      println("GREEN");
    }
  }
}

double calculateCAngle() {
  if (x != width / 2) {
    return Math.atan((y - (height / 2))/(x - (width / 2)));
  } else {
    return y - (height / 2);
  }
}
