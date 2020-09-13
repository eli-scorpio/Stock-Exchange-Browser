class load{
 PImage one;
 PImage two;
 PImage three;
  PImage four;

  
 load( PImage one, PImage two,PImage three,  PImage four){
this.one=one;
 this.two=two;
 this.three=three;
 this.four=four;
 

 }
void draw(){
background(0,0,0);

  image(one, 800, 150);
  image(two, 700, 450);
  image(three, 1400, 510);
   image(four, 0, 510);

fill(250);

}
}
