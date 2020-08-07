package stx.makro.type.pack;


@:forward abstract EnumType(StdEnumType) from StdEnumType{
  public function new(self){
    this = self;
  }
  public function getSimpleSwitch(gen:TFunParamArray->Option<Expr>,pos):Expr{
    return EnumTypes.getSimpleSwitch(this,gen,pos);
  }
}