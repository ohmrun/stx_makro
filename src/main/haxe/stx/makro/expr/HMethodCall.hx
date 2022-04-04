package stx.makro.expr;

typedef HMethodCallDef = {
  var data : MethodRef;
  var args : HExprCluster;
}

abstract HMethodCall(HMethodCallDef) from HMethodCallDef{
  public function new(self){
    this = self;
  }
  static public function pure(def:HMethodCallDef){
    return new HMethodCall(def);
  }
  static public function make(ref:MethodRef,args:HExprCluster):HMethodCall{
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
      LiftHExpr.MethodRef.toHExpr(this.data,pos),
      this.args
    ).expr(pos);
  }
}