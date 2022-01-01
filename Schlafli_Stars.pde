int P = 7; //<>//
int Q = 3;
float RHO = 1;
String Pstring = Integer.toString(P);
String Qstring = Integer.toString(Q);
final float POINTSIZE = 3;
int TEXTSIZE;
float SCALE;
float relSpeed;
boolean settingP,settingQ;
boolean showCircles = true;
boolean showQShape1 = true;
boolean showQShape2 = true;
boolean showSpiro = true;
boolean showStar = true;
boolean fullMode = true;
boolean showHelp = true;
boolean traceMode = false;
boolean recording = false;
boolean showInfo = true;
Spiro spiro;
Poly star;

void setup() {
  //size(600, 1000);
  fullScreen();
  SCALE = min(width,height)*0.45;
  TEXTSIZE = min(width,height)/30;
  textSize(TEXTSIZE);
  refresh();
  
  
  background(0);
  strokeWeight(2);
}

void refresh(){
  P = Integer.parseInt(Pstring);
  Q = Integer.parseInt(Qstring);
  settingP = false;
  settingQ = false;
  spiro = new Spiro(SCALE, P, Q, RHO);
  star = new Poly(SCALE, P, Q);
  relSpeed = (float)spiro.getMaxT()/(float)star.getMaxT();
}

void draw() {
  if(traceMode){
    blendMode(SUBTRACT);
    fill(5);
    rect(-10,-10,width+20,height+20);
    blendMode(ADD);
  } else {
    background(0);
  }

  pushMatrix();
    translate(width/2, height/2);
    rotate(-PI/2f);
    scale(1, -1);
  
    float time = 0.5*0.125*0.125*frameCount;
    noFill();
    stroke(50);
    if(showStar){star.show();}
    if(showCircles){spiro.showContainment();}
    if(showSpiro){spiro.show();}
    noFill();
    stroke(HSL(PI, 1, 0.5));
    if(showQShape2){spiro.showQPoints2((time*relSpeed) % spiro.getMaxT(), POINTSIZE,fullMode);}
    stroke(HSL(0, 1, 0.5));
    if(showQShape1){spiro.showQPoints1((time*relSpeed) % spiro.getMaxT(), POINTSIZE,fullMode);}
    
    noStroke();
    fill(150,10);
    if(showCircles){spiro.showRoller(time*relSpeed,fullMode);}
  popMatrix();
  
  blendMode(BLEND);
  fill(255);
  if(showHelp){
    textAlign(LEFT,BOTTOM);
    text("Press P or Q to start editing the values in the Schlafli symbol." + 
         "\nOr +/- to change the radius of the pen on the rolling circle." + 
         "\nType with numbers and BACKSPACE. ENTER to confirm." + 
         "\n(Toggle)?:Help Text. A:Rolling shape. S:Formation shape. D:Rollers. I:Info " + 
         "\nF:Full Mode. G:Spirograph. H: Ideal Polygon. T : Trace Mode. R:Record",15,height-TEXTSIZE/2);
  }
  if(showInfo){
    textAlign(LEFT,CENTER);
    text("{P/Q}={" + Pstring + "/" + Qstring + "} = " + spiro.repeats + "{" + (spiro.sides/spiro.repeats) + "/" + (spiro.step/spiro.repeats) + "};  Pen Radius:"+RHO + 
       "\ngcd:" + gcd(P,Q) + " lcm:" + lcm(P,Q) + " Degeneracy:" + (spiro.repeats - 1),15,TEXTSIZE + 5);
    
    if(settingP){
      text("\n\n\n[P-edit on]",20,25);
    } else if (settingQ){
      text("\n\n\n[Q-edit on]",20,25);
    }
  }
  if(recording){
    saveFrame("frames/frame#########.png");
    fill(255,0,0);
    circle(width - 20, 20, 10);
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
        refresh();
      }
    }
  }
  switch(key){
    case '=':
      RHO += 0.125*0.125;
      refresh();
      break;
    case '-':
      RHO -= 0.125*0.125;
      refresh();
      break;
    case 'p': 
      if(settingQ && Qstring.length() == 0){
        return;
      }
      settingP = true;
      settingQ = false;
      showInfo = true;
      break;
    case 'q': 
      if(settingP && Pstring.length() == 0){
        return;
      }
      settingP = false;
      settingQ = true;
      showInfo = true;
      break;
    case 't':
      traceMode = !traceMode;
      break;
    case 'a':
      showQShape1 = !showQShape1;
      break;
    case 's':
      showQShape2 = !showQShape2;
      break;
    case 'd':
      showCircles = !showCircles;
      break;
    case 'f':
      fullMode = !fullMode;
      break;
    case 'g':
      showSpiro = !showSpiro;
      break;
    case 'h':
      showStar = !showStar;
      break;
    case 'r':
      recording = !recording;
      break;
    case 'i':
      showInfo = !showInfo;
      break;
    case '/':
      showHelp = !showHelp;
      break;
  }
  
}
