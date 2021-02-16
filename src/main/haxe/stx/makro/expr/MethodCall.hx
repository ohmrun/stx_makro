package stx.makro.expr;

typedef MethodCallDef = {
  var data : MethodRef;
  var args : HExprArray;
}

abstract MethodCall(MethodCallDef) from MethodCallDef{
  public function new(self){
    this = self;
  }
  static public function pure(def:MethodCallDef){
    return new MethodCall(def);
  }
  static public function make(ref:MethodRef,args:HExprArray):MethodCall{
    return pure({
      data : ref,
      args : args
    });
  }
  public function prj(){
    return this;
  }
  public function expr(pos):HExpr{
    return HExprDef.ECall(
      HExpr._._.MethodRef.toHExpr(this.data,pos),
      this.args
    ).expr(pos);
  }
}