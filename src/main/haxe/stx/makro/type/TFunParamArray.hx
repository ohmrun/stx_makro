package stx.makro.type;

@:forward abstract TFunParamArray(Array<TFunParam>) from Array<TFunParam>{
  public function new(self){
    self;
  }
  public function call(m:MethodCall,pos):Expr{
    return ExprDef.ECall(
      m.expr(pos),
      ExprArray.unto((this.map(
        (param) -> param.getModule().toExpr()
      )))
    ).expr(pos);
  }
} 