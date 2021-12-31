int P = 7; //<>//
int Q = 3;
float RHO = 0.9;
String Pstring = Integer.toString(P);
String Qstring = Integer.toString(Q);
final float POINTSIZE = 3;
float SCALE;
float relSpeed;
boolean settingP,settingQ;
boolean fullMode = true;
Spiro spiro;
Poly star;

void setup() {
  SCALE = min(width,height)*0.45;
  size(1200, 1200);
  textSize(22);
  refresh();
  
  
  background(0);
  strokeWeight(2);
}

void refresh(){
  spiro = new Spiro(SCALE, P, Q, RHO);
  star = new Poly(SCALE, P, Q);
  relSpeed = (float)spiro.getMaxT()/(float)star.getMaxT();
}

void draw() {
  background(0);
  //blendMode(BLEND);
  //fill(0,15);
  //rect(-10,-10,width+20,height+20);
  //filter(BLUR,1);
  //blendMode(ADD);

  pushMatrix();
  translate(width/2, height/2);
  rotate(-PI/2f);
  scale(1, -1);

  float time = 0.5*0.125*0.125*frameCount;
  noFill();
  stroke(50);
  star.show();
  spiro.showContainment();
  stroke(0,50,0);
  spiro.show();
  noFill();
  stroke(HSL(0, 1, 0.5));
  spiro.showQPoints1((time*relSpeed) % spiro.getMaxT(), POINTSIZE,fullMode);
  stroke(HSL(PI, 1, 0.5));
  spiro.showQPoints2((time*relSpeed) % spiro.getMaxT(), POINTSIZE,fullMode);
  
  noStroke();
  fill(255,10);
  spiro.showRoller(time*relSpeed,true);
  
  popMatrix();
  
  fill(255);
  text("Press P or Q to start editing the values in the Schlafli symbol.\nOr +/- to change the radius of the pen on the rolling circle.\nType with numbers and BACKSPACE. ENTER to confirm.",15,25);
  text("\n\n\n{" + Pstring + "/" + Qstring + "} = {P/Q};  Pen Radius:"+RHO,15,25);
  
  if(settingP){
    text("\n\n\n\n[P-edit on]",20,25);
  } else if (settingQ){
    text("\n\n\n\n[Q-edit on]",20,25);
  }
}

void keyPressed(){
  if(settingP){
    if(key >= '0' && key <= '9'){
      Pstring = Pstring + key;
    } else if (key==BACKSPACE){
      if(Pstring.length() > 0){
        Pstring = Pstring.substring(0,Pstring.length()-1);
      }
    } else if (key==RETURN || key==ENTER){
      if(Pstring.length() > 0){
        P = Integer.parseInt(Pstring);
        settingP = false;
        refresh();
      }
    }
  } else if(settingQ){
    if(key >= '0' && key <= '9'){
      Qstring = Qstring + key;
    } else if (key==BACKSPACE){
      if(Qstring.length() > 0){
        Qstring = Qstring.substring(0,Qstring.length()-1);
      }
    } else if (key==RETURN || key==ENTER){
      if(Qstring.length() > 0){
        Q = Integer.parseInt(Qstring);
        settingQ = false;
        refresh();
      }
    }
  }
  switch(key){
    case '=':
      RHO += 0.01;
      refresh();
      break;
    case '-':
      RHO -= 0.01;
      refresh();
      break;
    case 'p': 
      settingP = true;
      settingQ = false;
      break;
    case 'q': 
      settingP = false;
      settingQ = true;
      break;
    case 'f':
      fullMode = !fullMode;
      break;
  }
  
}
