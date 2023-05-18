package stx.assert.makro.type.eq;

import stx.makro.type.HEnumType as THEnumType;

class HEnumType extends EqCls<THEnumType>{

  public function new(){}

  public function comply(a:THEnumType,b:THEnumType):Equaled{
    return throw UNIMPLEMENTED;
  }
}