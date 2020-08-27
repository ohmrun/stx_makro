package ah.macro;

import utest.Assert.*;

import Metah.select;

@:keep class SelectTest{
  public function new(){}
  public function testSelectEConst(){
    var a : Something = {
      a : "hello",
      b : 1,
      c : 0.4
    };
    var o   = select(Other,a);
    var o2  = select(Else,a);
    var o3  = select(Something,a);
    var st  = new SomeType();
    //var o4  = select(st,a);
    //select(a,a);
    equals(o2.b,1);
    equals(o.a,"hello");
    //var o3 = select(More,a);//nope
  }
}
class SomeType{
  public function new(){

  }
  public var a : String;
}
typedef Something = {
  var a : String;
  var b : Int;
  var c : Float;
}
typedef Other = {
  var a : String;
  var c : Float;
}
typedef Else = {
  var b : Int;
}
typedef More = {
  >Something,
  var d : Bool;
}
