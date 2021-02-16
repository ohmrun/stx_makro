package stx.macro;

#if macro
  import tink.macro.HExprs;
  import tink.macro.Types;
  import haxe.macro.Type;
  import haxe.macro.Expr;
  import haxe.macro.Context;
#end

class ConstructorsTest{
  public function new(){}
  #if macro
  public function testGetArityFromClass(){
    var e0 = HExprs.toHExpr(ArityTestZero);
    var e1 = HExprs.toHExpr(ArityTestOne);
    var e2 = HExprs.toHExpr(ArityTestTwo);
    trace(Context.typeof(e0));
    var a = Constructors.arity(e0);
    var b = Constructors.arity(e1);
    var c = Constructors.arity(e2);
    trace(a,b,c);

    var a   =  new ArityTestZero();
    trace(a);
    var e1  = HExprs.toHExpr(a);
    

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