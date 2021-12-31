class Spiro implements Shape{
  int sides,step,repeats;
  int reducedSides,reducedStep;
  float K,l,k,R,r,rho,PERIOD;
  float currentAngle = 0;
  Spiro(float scale, int _sides, int _step, float _l){
    if(_sides < 2){throw new IllegalArgumentException("There must be at least 3 points.");}
    if(_step < 1){throw new IllegalArgumentException("Step must be at least 1.");}
    if(_step >= _sides){throw new IllegalArgumentException("Step must be less than Sides.");}
    //if(_l <0 ||_l > 1){throw new IllegalArgumentException("l must be between 0 and 1");}
    sides = _sides;
    step = _step;
    K = (float)sides / (float)step;
    l = _l;
    k = 1f/K;
    R = scale;
    r = k*R;
    repeats = gcd(sides,step);
    reducedSides = sides / repeats;
    reducedStep = step / repeats;
    rho = l*r;
    PERIOD = TAU * lcm(sides,step) / sides;
    currentAngle = 0;
  }
  
  PVector penAtT(float t){return penAtT(t,0);}
  PVector penAtT(float t, float offset){
    float theta = t*(1f-K) ;
    return PVector.mult(PVector.add(fromPolar(1-k,t + currentAngle + offset) , fromPolar(l*k,theta + currentAngle + offset)),R);
  }
  
  PVector[] qPens1(float t){return qPens1(t,0);}
  PVector[] qPens1(float t,float offset){
    //inscribes the q'-gon in the inner circle
    PVector[] out = new PVector[reducedStep];
    //println(reducedStep);
    float theta = t*(1f-K) ;
    final float dTheta = TAU/reducedStep;
    for (int i=0; i<reducedStep; i++){
      out[i] = PVector.mult(PVector.add(fromPolar(1-k,t + currentAngle + offset) , fromPolar(l*k,theta + currentAngle + offset + i*dTheta)),R);
    }
    return out;
  }
  PVector[] qPens2(float t){return qPens2(t,0);}
  PVector[] qPens2(float t,float offset){
    PVector[] out = new PVector[reducedSides - reducedStep];
    float theta = t*(1f-K) ;
    final float dt = TAU/(reducedSides - reducedStep);
    for (int i=0; i<reducedSides - reducedStep; i++){
      out[i] = PVector.mult(PVector.add(fromPolar(1-k,t + currentAngle + offset + i*dt) , fromPolar(l*k,theta + currentAngle + offset)),R);
    }
    return out;
  }
  
  void showPoint(float t,float scale){
    if(t<0){throw new IllegalArgumentException("t must be greater than 0");}
    if(t >= getMaxT()){t= t % getMaxT();}
    if(repeats == 1){
      PVector x = penAtT(t);
      circle(x.x,x.y,scale);
      return;
    } else {
      println(repeats);
      float theta = TAU/sides;
      for(int n=0; n<=repeats;n++){
        if(t < PERIOD){
          PVector x = penAtT(t,n*theta);
          circle(x.x,x.y,scale);
          return;
        } else {
          t -= PERIOD;
        }
      }
    }
    throw new RuntimeException("Didn't find point. Possibly t to large");
  }
  
  void showQPoints1(float t, float scale,boolean full){
    if(t<0){throw new IllegalArgumentException("t must be greater than 0");}
    if(t>=getMaxT()){t= t%getMaxT();}
    int polyCount = (full)?(reducedSides - reducedStep):1;
    float polySep = TAU/polyCount;
    if(repeats == 1){
      for(int j=0; j<polyCount;j++){
        PVector[] poly  = qPens1(t+j*polySep);
        for(int i=0;i<poly.length;i++){
          circle(poly[i].x,poly[i].y,scale);
          line(poly[i].x,poly[i].y,poly[(i+1)%poly.length].x,poly[(i+1)%poly.length].y);
        }
      }
      return;
    } else {
      float theta = TAU/sides;
      for(int n=0; n<=repeats;n++){
        if(t < PERIOD){
          for(int j=0; j<polyCount;j++){
            PVector[] poly  = qPens1(t+j*polySep,theta*n);
            for(int i=0;i<poly.length;i++){
              circle(poly[i].x,poly[i].y,scale);
              line(poly[i].x,poly[i].y,poly[(i+1)%poly.length].x,poly[(i+1)%poly.length].y);
            }
          }
          return;
        } else {
          t -= PERIOD;
        }
      }
    }
    throw new RuntimeException("Didn't find point. Possibly t to large");
  }
  
  void showQPoints2(float t, float scale,boolean full){
    if(t<0){throw new IllegalArgumentException("t must be greater than 0");}
    if(t>=getMaxT()){t= t%getMaxT();}
    int polyCount = (full)?(reducedStep):1;
    float polySep = TAU/(reducedSides - reducedStep);
    if(repeats == 1){
      for(int j=0; j<polyCount;j++){
        PVector[] poly  = qPens2(t - j*polySep);
        for(int i=0;i<poly.length;i++){
          circle(poly[i].x,poly[i].y,scale);
          line(poly[i].x,poly[i].y,poly[(i+1)%poly.length].x,poly[(i+1)%poly.length].y);
        }
      }
      return;
    } else {
      float theta = TAU/sides;
      for(int n=0; n<=repeats;n++){
        if(t < PERIOD){
          for(int j=0; j<polyCount;j++){
            PVector[] poly  = qPens2(t - j*polySep,theta*n);
            for(int i=0;i<poly.length;i++){
              circle(poly[i].x,poly[i].y,scale);
              line(poly[i].x,poly[i].y,poly[(i+1)%poly.length].x,poly[(i+1)%poly.length].y);
            }
          }
          return;
        } else {
          t -= PERIOD;
        }
      }
    }
    throw new RuntimeException("Didn't find point. Possibly t to large");
  }
  
  void showRoller(float t,boolean full){
    int wheels = (full)?reducedSides - reducedStep:1;
    float dWheel = TAU/(wheels);
    for(int i=0;i<wheels;i++){
      circle((R-r)*cos(t + i*dWheel),(R-r)*sin(t+ i*dWheel),2*r);
    }
  }
  
  void showContainment(){
    circle(0,0,2*R);
  }
  
  void rotate(float angle){currentAngle += angle;}
  
  float getMaxT(){return repeats*PERIOD;}
  
  void show(){
    final int detail = 1024;
    final float dt = getMaxT()/(detail+1);
    final float theta = TAU/P;
    for (int n=0; n<repeats;n++){
      for(int i=0; i<detail;i++){
        PVector x1 = penAtT(   i *dt, n*theta);
        PVector x2 = penAtT((i+1)*dt, n*theta);
        line(x1.x,x1.y,x2.x,x2.y);
      }
    }
  }

}
