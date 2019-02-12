package stx.macro;

#if macro
  import tink.macro.Exprs;
  import tink.macro.Types;
  import haxe.macro.Type;
  import haxe.macro.Expr;
  import haxe.macro.Context;
#end

class ConstructorsTest{
  public function new(){}
  #if macro
  public function testGetArityFromClass(){
    var e0 = Exprs.toExpr(ArityTestZero);
    var e1 = Exprs.toExpr(ArityTestOne);
    var e2 = Exprs.toExpr(ArityTestTwo);
    trace(Context.typeof(e0));
    var a = Constructors.arity(e0);
    var b = Constructors.arity(e1);
    var c = Constructors.arity(e2);
    trace(a,b,c);

    var a   =  new ArityTestZero();
    trace(a);
    var e1  = Exprs.toExpr(a);
    

  }
  #end
}
class ArityTestZero{
  public function new(){

  }
}
class ArityTestOne{
  public function new(s:String){

  }
}
class ArityTestTwo{
  public function new(s:String,i:Int){

  }
}