
PVector fromPolar(float r,float theta){
  return new PVector(r*cos(theta),r*sin(theta));
}

int gcd(int a, int b) {
   if (b==0) return a;
   return gcd(b,a%b);
}

int lcm(int a, int b){
  if(a==0 && b ==0){return 0;}
  return abs(a*b)/gcd(a,b);
}

//int[] pointIndices(int points,int step){
//  if(points < 3){throw new IllegalArgumentException("There must be at least 3 points.");}
//  int[] out = new int[points];
//  for (int i=0; i<points; i++){
//    out[i] = (i*step) % points;
//  }
//}
