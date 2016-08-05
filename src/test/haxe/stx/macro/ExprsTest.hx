package stx.macro;

import haxe.macro.Expr;

class ExprsTest{
  public function new(){}
  public function testQuote(){
    haxe.macro.ExprDef.EConst;
    //Exprs.quote(a);
    var a = [];
    //Exprs.quote(a[1]);
    //Exprs.quote(var something = "oops");
    Exprs.quote(new TestClass());
  }
}
class TestClass{
  public function new(){}
}
