package stx.makro.expr;

typedef MethodCallDef = {
  var data : MethodRef;
  var args : ExprArray;
}

abstract MethodCall(MethodCallDef) from MethodCallDef{
  public function new(self){
    this = self;
  }
  static public function pure(def:MethodCallDef){
    return new MethodCall(def);
  }
  static public function make(ref:MethodRef,args:ExprArray):MethodCall{
    return pure({
      data : ref,
      args : args
    });
  }
  public function prj(){
    return this;
  }
  public function expr(pos):Expr{
    return ExprDef.ECall(
      Expr._._.MethodRef.toExpr(this.data,pos),
      this.args
    ).expr(pos);
  }
}