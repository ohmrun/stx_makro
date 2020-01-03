package stx.macro.type.pack;


@:forward abstract EnumType(StdEnumType) from StdEnumType{
  public function getSimpleSwitch(gen:TFunParamArray->Option<Expr>,pos):Expr{
    return EnumTypes.getSimpleSwitch(this,gen,pos);
  }
}