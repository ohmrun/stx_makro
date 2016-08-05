package ah.macro;

import ah.Macro.*;

class TupleTest{
  public function new(){}
  public function test1(){
    var a = something();
    trace(a);
  }
  public function something():ah.Tuple<Int,Bool,String,Float>{
    return tuple(1,false,"hello",0.3);
  }
}