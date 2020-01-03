package stx.makro.type.pack;

import stx.makro.type.head.data.EnumValueConstructor in EnumValueConstructorT;

@:forward abstract EnumValueConstructor(EnumValueConstructorT) from EnumValueConstructorT{
  public function new(self:EnumValueConstructorT){
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