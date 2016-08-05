package stx.macro;

class AssignTest{
  public function new(){}
  public function testAssign(){
    var a = ({
      a : "abc",
      b : 1,
      c : 0.3
    }:BaseTDef);
    var b = ({
      a : "cde",
      b : 4
    }:NarrowTDef);
    Assign.apply(a,b,Left);
    /*Assign.apply(
      {
        a : "abc",
        b : 1,
        c : 0.3
      },
      {
        a : "cde",
        b : 4
      },
      Left
    );*/
  }
}
typedef BaseTDef = {
  var a : String;
  var b : Int;
  var c : Float;
}
typedef NarrowTDef = {
  var a : String;
  var b : Int;
}
typedef WideTDef = {
  >BaseTDef,
  var d : Int;
}
typedef Incompatible = {
  var a : String;
  var b : Int;
}