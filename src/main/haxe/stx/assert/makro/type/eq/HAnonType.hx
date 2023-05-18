package stx.assert.makro.type.eq;

import stx.makro.type.HAnonType as THAnonType;

class HAnonType extends EqCls<THAnonType>{

  public function new(){}

  public function comply(a:THAnonType,b:THAnonType):Equaled{
    return throw UNIMPLEMENTED;
  }
}