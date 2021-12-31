interface Shape{
  void show();
  void showPoint(float t,float scale);
  float getMaxT();
  void rotate(float angle);//rotates about center of window, not center of self
}

class Poly implements Shape{
  float scale;
  int sides, step,splitting;
  Shape[] subShapes;
  Poly(float _scale, int _sides, int _step){
    if(_sides < 2){throw new IllegalArgumentException("There must be at least 3 points.");}
    if(_step < 1){throw new IllegalArgumentException("Step must be at least 1.");}
    if(_step >= _sides){throw new IllegalArgumentException("Step must be less than Sides.");}
    scale = _scale;
    sides = _sides;
    step = _step;
    splitting = gcd(sides,step);
    if(splitting == 1){
      subShapes = new Line[sides];
      float angle = step*TAU/sides;
      for(int i=0;i<sides;i++){
        PVector x1 = fromPolar(scale,i*angle);
        PVector x2 = fromPolar(scale,(i+1)*angle);
        subShapes[i] = new Line(x1,x2);
      }
    } else {
      subShapes = new Poly[splitting];
      int subShapeSides = sides / splitting;
      int subShapeStep = step / splitting;
      float angleOffset = TAU / sides;
      for(int i=0;i<splitting;i++){
        subShapes[i] = new Poly(scale,subShapeSides,subShapeStep);
        subShapes[i].rotate(angleOffset*i);
      }
    }
  }
  
  void rotate(float angle){
    for(Shape shape: subShapes){
      shape.rotate(angle);
    }
  }
  
  void show(){
    for(Shape shape:subShapes){
      shape.show();
    }
  }
  
  float getMaxT(){
    if(splitting == 1){
      return (float)sides;
    } else {
      float sum = 0;
      for(Shape shape:subShapes){
        sum += shape.getMaxT();
      }
      return sum;
    }
  }
  
  void showPoint(float t,float scale){
    if(t<0){throw new IllegalArgumentException("t must be greater than 0");}
    if(splitting == 1){
      int passTo = floor(t);
      float passAs = t - passTo;
      subShapes[passTo].showPoint(passAs,scale);
      return;
    } else {
      for(Shape shape:subShapes){
        float shapeLength = shape.getMaxT();
        if(t < shapeLength){
          shape.showPoint(t,scale);
          return;
        } else {
          t -= shapeLength;
        }
      }
    }
    throw new RuntimeException("Didn't find point. Possibly t to large");
  }
  
}

class Line implements Shape{
  PVector start,end;
  Line(PVector _start,PVector _end){
    start = _start;
    end = _end;
  }
  void rotate(float angle){
    start = start.rotate(angle);
    end = end.rotate(angle);
  }
  void show(){line(start.x,start.y,end.x,end.y);}
  
  void showPoint(float t,float scale){
    PVector point = PVector.lerp(start,end,t);
    circle(point.x,point.y,scale);
  }
  
  float getMaxT(){return 1f;}
  
}
