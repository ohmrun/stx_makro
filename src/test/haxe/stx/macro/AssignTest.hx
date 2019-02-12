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



