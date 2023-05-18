package stx.assert.makro.type.eq;

import stx.makro.type.HTypeParameter as THTypeParameter;

class HTypeParameter extends EqCls<THTypeParameter>{

  public function new(){}

  public function comply(a:THTypeParameter,b:THTypeParameter):Equaled{
    return throw UNIMPLEMENTED;
  }
}