package stx.assert.makro.type.eq;

import stx.makro.type.HClassType as THClassType;

class HClassType extends EqCls<THClassType>{

  public function new(){}

  public function comply(a:THClassType,b:THClassType):Equaled{
    return throw UNIMPLEMENTED;
  }
}