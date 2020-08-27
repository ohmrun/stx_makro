package ah.macro;

import ah.macro.Path;

class PathTest{
  public function new(){}
  public function testConstants(){
    var a : Path = "ah.macro.TestPath";
    var b : Path = Path.fromPathExpr(ah.macro.TestPath);
    trace(a);
  }
}
class TestPath{
  static public function testPathStatic(){

  }
}
