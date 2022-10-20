Food [] grass;
Runners [] prey;
Hunters [] predators;
int foodEaten = 0;
int [] runX = new int[20];
int [] runY = new int[20];
boolean [] aliveRunners = new boolean[20];
int token = 0;
int [] hunX = new int[3];
int [] hunY = new int[3];
int lowest = 0;
int currentLow = 0;
boolean checkedX = false;
boolean checkedY = false;
int ticks = 0;
int size = 30;
int play = 0;
int numPrey = 0;
int numPredators = 0;

void setup(){
  size(750,750);
  background(0, 0, 0);
  prey = new Runners[20];
  predators = new Hunters[3];
  grass = new Food[30];
  for(int i = 0; i < prey.length;i++)
  {
    prey[i] = new Runners((int)(Math.random()*751), (int)(Math.random()*751));
  }
  for(int i = 0; i < predators.length;i++)
  {
    predators[i] = new Hunters((int)(Math.random()*751), (int)(Math.random()*51));
  }
  for(int i = 0; i < grass.length;i++)
  {
    grass[i] = new Food();
  }
}

void draw(){
  background(0, 0, 0);
  if(ticks < 180)
  {
    fill(255);
    textSize(100);
    textAlign(CENTER);
    if(ticks < 60)
      text("3", 375, 375);
    else if(ticks < 120)
      text("2", 375, 375);
    else if(ticks < 180)
      text("1", 375, 375);
  }
  if(ticks >= 180)
  {
     fill(255, 0, 0);
     textSize(20);
     if(ticks < 240)
       text("10", 730, 20);
     else if(ticks < 300)
       text("9", 730, 20);
     else if(ticks < 360)
       text("8", 730, 20);
     else if(ticks < 420)
       text("7", 730, 20);
     else if(ticks < 480)
       text("6", 730, 20);
     else if(ticks < 540)
       text("5", 730, 20);
     else if(ticks < 600)
       text("4", 730, 20);
     else if(ticks < 660)
       text("3", 730, 20);
     else if(ticks < 720)
       text("2", 730, 20);
     else if(ticks < 780)
       text("1", 730, 20);
    if(token != 20 && foodEaten != 30)
    {
      for(int i = 0; i < grass.length; i++)
      {
        grass[i].show();
        foodEaten = foodEaten + grass[i].fToken;
      }
      if(ticks > 780)
      {
        for(int i = 0; i < predators.length;i++)
        {
          predators[i].show();
          predators[i].move();
          hunX[i] = predators[i].hunterX;
          hunY[i] = predators[i].hunterY;
          checkedX = false;
          checkedY = false;
          numPredators++;
        }
      } 
      for(int i = 0; i < prey.length;i++)
      {
        prey[i].show();
        prey[i].move();
        runX[i] = prey[i].runnerX;
        runY[i] = prey[i].runnerY;
        aliveRunners[i] = prey[i].alive;
        token = token + prey[i].pToken;
        numPrey++;
      }
      numPrey = 0;
      numPredators = 0;
    }
    if(token != 20)
      token = 0;
    if(token == 20)
    {
      fill(255, 0, 0);
      textSize(100);
      textAlign(CENTER);
      text("GAME OVER", 375, 375);
    }
    if(foodEaten != 30)
      foodEaten = 0;
    if(foodEaten == 30)
    {
      fill(0, 0, 255);
      textSize(100);
      textAlign(CENTER);
      text("YOU WON", 375, 375);
    }
  }
  ticks++;
}

class Food
{
  
  int foodX, foodY, foodColor, fToken, foodCount;
  boolean eaten;
  
  Food()
  {
    foodX = (int)(Math.random()*751);
    foodY = (int)(Math.random()*751);
    foodColor = color(0, (int)(Math.random()*156)+100, 0);
    eaten = false;
    foodCount = 0;
  }
  
  void show()
  {
    fill(foodColor);
    if(eaten == false)
      ellipse(foodX, foodY, 0.6*size, 0.6*size);
    for(int i = 0; i < prey.length; i++)
    {
      if(dist(foodX, foodY, runX[i], runY[i]) < 0.6*size)
      {
        eaten = true;
        foodCount++;
      }
      if(eaten == true && foodCount == 1)
      {
        fToken = 1;
        foodCount++;
      }
    }
  }
  
}

class Runners
{
  
  int runnerX, runnerY, runnerColor, pToken, pCount;
  boolean alive;
  
  Runners(int xOne, int yOne){
    runnerX = xOne;
    runnerY = yOne;
    runnerColor = color(0,0,(int)(Math.random()*151)+105);
    alive = true;
  }
  
  void move(){
    if(alive == true)
    {
      if(runnerX < mouseX)
       runnerX = runnerX + (int)(Math.random()*3);
      if(runnerX > mouseX)
       runnerX= runnerX - (int)(Math.random()*3);
      if(runnerY < mouseY)
       runnerY = runnerY + (int)(Math.random()*3);
      if(runnerY > mouseY)
       runnerY = runnerY - (int)(Math.random()*3);  
      for(int i = 0; i< prey.length; i++)
      {
        if(dist(runnerX, runnerY, runX[i], runY[i]) < size && i != numPrey) 
        {
          if(runnerX < runX[i])
            runnerX = runnerX + (int)(Math.random())-2;
          if(runnerX > runX[i])
            runnerX = runnerX + (int)(Math.random())+2;
          if(runnerY < runY[i])
            runnerY = runnerY + (int)(Math.random())-2;
          if(runnerY > runY[i])  
            runnerY = runnerY + (int)(Math.random())+2;
        }
      }
      if(runnerX < 0)
        runnerX += 5;
      if(runnerX > 750)
        runnerX -= 5;
      if(runnerY < 0)
        runnerY += 5;
      if(runnerY > 750)
        runnerY -= 5; 
    }
  }
  
  void show(){
    if(alive == true)
    {
      fill(runnerColor);
      ellipse(runnerX,runnerY,size,size);
      fill(255, 255, 255);
      ellipse(runnerX-0.2*size, runnerY-0.2*size, 0.3*size, 0.3*size);
      ellipse(runnerX+0.2*size, runnerY-0.2*size, 0.3*size, 0.3*size);
      ellipse(runnerX, runnerY+0.25*size, 0.4*size, 0.4*size);
      pToken = 0; 
    }
    for(int i = 0; i < hunX.length; i++)
    {
      if(dist(runnerX, runnerY, hunX[i], hunY[i]) < size)
      {
        alive = false;
        pCount++;
      }
      if(alive == false && pCount == 1)
      {
        pToken = 1;
        pCount++;
      }
    }
    if(alive == false)
    {
      runnerX = 10000;
      runnerY = 10000;
    }
  }
  
}

class Hunters 
{
  
  int hunterX, hunterY, hunterColor;
  
  Hunters(int xTwo, int yTwo){
    hunterX = xTwo;
    hunterY = yTwo;
    hunterColor = color((int)(Math.random()*151)+105,0,0);
  }
  
  void move(){
    for(int i = 0; i < runX.length-1; i++)
    {
      if(aliveRunners[i] == true)
      {
        dist(hunterX, hunterY, runX[i], runY[i]);
        if(dist(hunterX, hunterY, runX[i], runY[i]) < dist(hunterX, hunterY, runX[i+1], runY[i+1]))
        {
          currentLow = i; 
          if(dist(hunterX, hunterY, runX[currentLow], runY[currentLow]) <= dist(hunterX, hunterY, runX[lowest], runY[lowest]))
            lowest = currentLow;
        }
      }
    }
     if(dist(hunterX, hunterY, runX[lowest], runY[lowest]) < 300)
     {
       if(abs(hunterX - runX[lowest]) < abs(hunterY - runY[lowest]) || hunterY == runY[lowest])
        {
            if(hunterX < runX[lowest] && checkedX == false)
            {
              hunterX = hunterX + (int)(Math.random()*3);
              checkedX = true;
            }
            if(hunterX > runX[lowest] && checkedX == false)
            {
              hunterX = hunterX - (int)(Math.random()*3);
              checkedX = true;
          }
        }
        if(abs(hunterY - runY[lowest]) < abs(hunterX - runX[lowest]) || hunterX == runX[lowest])
        {
            if(hunterY < runY[lowest] && checkedY == false)
            {
              hunterY = hunterY + (int)(Math.random()*3);
              checkedY = true;
            }
            if(hunterY > runY[lowest] && checkedY == false)
            {
              hunterY = hunterY - (int)(Math.random()*3);  
              checkedY = true;
          }
      }
     }
     else 
     {
       hunterX = hunterX + (int)(Math.random()*11)-5;
       if(hunterY < 350)
         hunterY = hunterY + (int)(Math.random()*8)-2;
       if(hunterY >= 350)
         hunterY = hunterY + (int)(Math.random()*8)-5;
     }
     for(int i = 0; i< predators.length; i++)
      {
        if(dist(hunterX, hunterY, hunX[i], hunY[i]) < 2*size && i != numPredators) 
        {
          if(hunterX < hunX[i])
            hunterX = hunterX + (int)(Math.random())-2;
          if(hunterX > hunX[i])
            hunterX = hunterX + (int)(Math.random())+2;
          if(hunterY < hunY[i])
            hunterY = hunterY + (int)(Math.random())-2;
          if(hunterY > hunY[i])  
            hunterY = hunterY + (int)(Math.random())+2;
        }
      }
     if(hunterX < 0)
        hunterX += 5;
     if(hunterX > 750)
        hunterX -= 5;
     if(hunterY < 0)
        hunterY += 5;
     if(hunterY > 750)
        hunterY -= 5; 
  }
  
  void show(){
    fill(hunterColor);
    ellipse(hunterX,hunterY,2*size,2*size);
    fill(255, 255, 255);
    ellipse(hunterX-0.4*size, hunterY-0.4*size, 0.6*size, 0.6*size);
    ellipse(hunterX+0.4*size, hunterY-0.4*size, 0.6*size, 0.6*size);
    ellipse(hunterX, hunterY+0.5*size, 0.8*size, 0.8*size);
  }
  
}
