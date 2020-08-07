package stx.makro.type.pack;

@:forward abstract TFunParamArray(Array<TFunParam>) from Array<TFunParam>{
  public function new(self){
    self;
  }
  public function call(m:MethodCall,pos):Expr{
    return ExprDefs.ECall(
      m.expr(pos).prj(),
      this.map(
        (param) -> param.getModule().force().expr(pos)
      ).prj()
    ).expr(pos);
  }
} 