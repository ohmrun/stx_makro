package stx.macro;

import stx.macro.expr.Module;
import haxe.macro.Expr;

class ExprsTest{
  public function new(){}
  public function testQuote(){
    haxe.macro.ExprDef.EConst;
    //Exprs.quote(a);
    var a = [];
    //Exprs.quote(a[1]);
    //Exprs.quote(var something = "oops");
  }
}
class TestClass{
  public function new(){}
}
