package stx.makro.type;

typedef EnumValueConstructorDef = {
  var type  : EnumType;
  var ref   : MethodRef;
  var args  : TFunParamArray;
}
@:forward abstract EnumValueConstructor(EnumValueConstructorDef) from EnumValueConstructorDef{
  public function new(self:EnumValueConstructorDef){
    this = self;
  }
  static public function make(e:EnumType,ref:MethodRef,args:TFunParamArray):EnumValueConstructor{
    return new EnumValueConstructor({
      type : e,
      ref : ref,
      args : args
    });
  }
}