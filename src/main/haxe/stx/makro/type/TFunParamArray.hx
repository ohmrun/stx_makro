package stx.makro.type;

@:forward abstract TFunParamArray(Array<TFunParam>) from Array<TFunParam>{
  public function new(self){
    this = self;
  }
  #if macro
  public function call(m:MethodCall,pos):HExpr{
    return HExprDef.ECall(
      m.expr(pos),
      HExprArray.unto((this.map(
        (param) -> param.getModule().toExpr()
      )))
    ).expr(pos);
  }
  #end
} 